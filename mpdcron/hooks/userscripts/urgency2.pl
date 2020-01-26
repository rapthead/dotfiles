#!/usr/bin/perl
use strict;
use warnings;

use DBI;
use Data::Dumper;
use Audio::MPD;
use Digest::MD5 qw(md5_hex);
use Encode qw(encode_utf8 decode_utf8);
use utf8;

use Config::INI::Reader;
my $config_hash = Config::INI::Reader->read_file('userscripts.ini');

my $db = DBI->connect(
    $config_hash->{'statistic-db'}->{data_source} || "dbi:SQLite:dbname=/home/noname/play_stat.db",
    $config_hash->{'statistic-db'}->{username}    || "",
    $config_hash->{'statistic-db'}->{password}    || "",
    { RaiseError => 1, AutoCommit => 1 }
);
#установка режима юникод
$db->{sqlite_unicode} = 1;

# опции для соединения с mpd по-умолчанию
my %mpd_opts = (
    host => $config_hash->{'mpd_connection'}->{host} || 'localhost',
    port => $config_hash->{'mpd_connection'}->{port} || '6600',
    password => $config_hash->{'mpd_connection'}->{password} || ''
);
my $mpd = eval { Audio::MPD->new(\%mpd_opts) };
die "не удалось соединиться с сервером mpd: ".decode_utf8($@) if $@;

my $collection = $mpd->collection;

my $get_track_by_uri_hash = $db->prepare(<<'__SQL_END__');
    SELECT album.*, track.*, album.title as album_title, artist.name as artist_name
    FROM track 
    LEFT JOIN album ON album.album_id = track.album_id
    LEFT JOIN artist ON artist.artist_id = album.artist_id
    WHERE uri_hash = ?
__SQL_END__

my $find_album = $db->prepare(<<'__SQL_END__');
    SELECT album_id FROM album
    JOIN artist ON artist.artist_id = album.artist_id
    WHERE artist.artist_id = ? and album.title = ?
        and album.release_year = ? and album.orig_year = ?
__SQL_END__
sub find_or_add_album {
    my $meta = shift;
    $find_album->execute($meta->{artist_id}, $meta->{album},
        $meta->{release_year}, $meta->{orig_year});
    my @row = $find_album->fetchrow_array;
    my $album_id = $row[0] if $row[0];
    unless ($album_id) {
        # создание альбома с указанными параметрами
        warn sprintf("Добавляется альбом: %d-%s\n",$meta->{release_year},$meta->{album});
        $db->do('INSERT INTO album (album_id, artist_id, title, orig_year, release_year) 
                    VALUES ( null, ?, ?, ?, ? )',undef,
            $meta->{artist_id},$meta->{album},$meta->{orig_year},$meta->{release_year});
        $album_id = $db->last_insert_id(undef,undef,undef,undef);
    }
    return $album_id;
}

my $find_artist = $db->prepare(<<'__SQL_END__');
    SELECT artist_id FROM artist WHERE name = ?
__SQL_END__
sub find_or_add_artist {
    my $artist_name = shift;
    $find_artist->execute($artist_name);
    my @row = $find_artist->fetchrow_array;
    my $artist_id;
    $artist_id = $row[0] if $row[0];
    unless ($artist_id) {
        # создание исполнителя с указанным именем
        warn "Добавляется исполнитель: $artist_name\n";
        $db->do('INSERT INTO artist ( artist_id, name ) 
            VALUES ( null, ? )',undef,$artist_name);
        $artist_id = $db->last_insert_id(undef,undef,undef,undef);
    }
    return $artist_id;
}

my $find_track = $db->prepare(<<'__SQL_END__');
    SELECT track.track_id, track.title, track.length FROM track
    LEFT JOIN album ON album.album_id = track.album_id
    LEFT JOIN artist ON artist.artist_id = album.artist_id
    WHERE artist.name = ? and album.title = ? 
        and album.release_year = ? and album.orig_year = ?
        and track.track_num = ? and track.disc = ?
__SQL_END__
my $find_track_ids = $db->prepare(<<'__SQL_END__');
    SELECT track.track_id FROM track
    WHERE track.album_id = ? and track.track_num = ? and track.disc = ? and track.title = ?
__SQL_END__
sub find_or_add_track {
    my $meta = shift;
    $find_track_ids->execute($meta->{album_id}, $meta->{track_num}, $meta->{disc}, $meta->{title});
    my @row = $find_track_ids->fetchrow_array;
    my $track_id;
    $track_id = $row[0] if $row[0];
    unless ($track_id) {
        # создание альбома с указанными параметрами
        warn sprintf("Добавляется трек: %d-%s\n",$meta->{track_num},$meta->{title});
        $db->do('INSERT INTO track (track_id, album_id, track_num, disc, title, track_artist, length)
                    VALUES ( null, ?, ?, ?, ?, ?, ? )',undef,
            $meta->{album_id}, $meta->{track_num}, $meta->{disc}, $meta->{title},
            $meta->{track_artist} , $meta->{length});
        $track_id = $db->last_insert_id(undef,undef,undef,undef);
    }
    return $track_id;
}

$db->do(<<'__SQL_END__',undef);
CREATE TEMP TABLE found_uris
( uri_hash VARCHAR NOT NULL );
DELETE FROM found_uris
__SQL_END__

my @uris;

# TODO: ругаться на незаполненные поля
my @songs = sort {
    ($a->albumartist||'') cmp ($b->albumartist||'')
        ||
    ($a->album||'') cmp ($b->album||'')
        ||
    ($a->disc||1) <=> ($b->disc||1)
        ||
    $a->track <=> $b->track
} $collection->all_songs;

foreach my $song (@songs) {
    $song->date =~ m/(\d{4})(?:-(\d{4}))?/;
#    warn "is_utf8:".Encode::is_utf8($song->file)."\n";
    my $song_info = {
        artist => $song->artist,
        album => $song->album,
        albumartist => $song->albumartist || $song->artist,
        title => $song->title,
        track => $song->track,
        disc => $song->disc || 1,
        release_year => $2 || $1,
        orig_year => $1,
        time => $song->time,
        uri => $song->file,
        uri_hash => md5_hex(encode_utf8($song->file))
    };

    # поиск трека по uri_hash
    $get_track_by_uri_hash->execute($song_info->{uri_hash});
    my $row = $get_track_by_uri_hash->fetchrow_hashref;

    if ($row && %$row) {
        # если найден по uri_hash
        unless ($row->{length}) {
            $db->do('UPDATE track SET length = ? WHERE track_id = ?',undef,
                $song_info->{time}, $row->{track_id});
        }
        push(@uris,$song_info->{uri_hash});
        die "изменилась продолжительность файла [$song_info->{uri}], требуется ручное исправление ошибки\n"
            if $row->{length} && $row->{length} != $song_info->{time};

        if (!defined($row->{title}) or ($row->{title} ne $song_info->{title})
            or !defined($row->{disc}) or ($row->{disc} != ($song_info->{disc}))
            or (defined($row->{track_artist}) and ($song_info->{artist} eq $song_info->{albumartist}))
            or (defined($row->{track_artist}) and ($row->{track_artist} ne $song_info->{artist}))
            or (!defined($row->{track_artist}) and ($song_info->{artist} ne $song_info->{albumartist}))
                ) {
            warn "У файла [$song_info->{uri}] изменены метаданные трека\n";
            # изменение метаданных трека в базе
            $db->do('UPDATE track SET title = ?, track_artist = ?, disc = ?, track_num = ? 
                WHERE track_id = ?',undef,
                $song_info->{title}, 
                ($song_info->{artist} ne $song_info->{albumartist})?$song_info->{artist}:undef,
                $song_info->{disc}, $song_info->{track}, $row->{track_id} );
        }

        my $album_id;
        if (!defined($row->{album_title}) or ($row->{album_title} ne $song_info->{album}) 
               or !defined($row->{orig_year}) or($row->{orig_year} != $song_info->{orig_year})
               or !defined($row->{release_year})
               or ($row->{release_year} != $song_info->{release_year})){
            warn "У файла [$song_info->{uri}] изменены метаданные альбома\n";
            $album_id = find_or_add_album({ artist_id => $row->{artist_id},
                    album => $song_info->{album}, release_year => $song_info->{release_year},
                    orig_year => $song_info->{orig_year} });
            # изменение идентификатора альбома у обрабатывемого трека
            $db->do('UPDATE track SET album_id = ? WHERE track_id = ?',undef,
                $album_id, $row->{track_id} );
        }

        if (!defined($row->{artist_name}) or ($row->{artist_name} ne $song_info->{albumartist})) {
            warn "У файла [$song_info->{uri}] изменены метаданные исполнителя\n";
            $db->do('UPDATE album SET artist_id = ? WHERE album_id = ?',undef,
                find_or_add_artist($song_info->{albumartist}),$album_id||$row->{album_id});
        }

    }
    else {
        # если не найден по uri_hash
        warn "Трек с uri [$song_info->{uri}] не найден в базе\n";
        $find_track->execute($song_info->{albumartist},$song_info->{album},$song_info->{release_year},
            $song_info->{orig_year}, $song_info->{track}, $song_info->{disc});
        my $row = $find_track->fetchrow_hashref;
        my $track_id;
        # изменился путь к файлу и название трека
        if ($row && %$row) {
            die sprintf("изменилась продолжительность трека #%d с альбома %s от %s,требуется вмешательство\n",
                $song_info->{track},$song_info->{album},$song_info->{albumartist}) 
                if $row->{length} && ($row->{length} != $song_info->{time});
            $track_id = $row->{track_id};
            if ($row->{title} ne $song_info->{title}) {
                $db->do('UPDATE track SET title = ? WHERE track_id = ?',undef,
                    $song_info->{title}, $row->{track_id} );
                warn "Трек с uri [$song_info->{uri}] был переименован и изменено название композиции\n";
            }
            else {
                warn "Трек с uri [$song_info->{uri}] был переименован\n";
            }
        }
        else {
            my $artist_id = find_or_add_artist($song_info->{albumartist});
            my $album_id = find_or_add_album({ artist_id => $artist_id, album => $song_info->{album},
                    release_year => $song_info->{release_year}, orig_year => $song_info->{orig_year} });
            $track_id = find_or_add_track({ album_id => $album_id, track_num => $song_info->{track},
                    disc => $song_info->{disc}, title => $song_info->{title},
                    track_artist =>
                    ($song_info->{artist} ne $song_info->{albumartist})?$song_info->{artist}:undef,
                    length => $song_info->{time} });
        }

        $db->do('UPDATE track SET uri = ?, uri_hash = ? WHERE track_id = ?',undef,
            $song_info->{uri}, $song_info->{uri_hash}, $track_id ) if $track_id;
    }

    # добавление uri во временную таблицу
    $db->do(<<'__SQL_END__',undef,$song_info->{uri_hash});
    INSERT INTO found_uris (uri_hash) VALUES (?)
__SQL_END__
}

#очистка uri отсутсвующих файлов
my $affected_rows = $db->do(<<'__SQL_END__',undef);
UPDATE track SET uri = null, uri_hash = null
WHERE uri NOTNULL and NOT EXISTS 
    ( SELECT uri_hash
        FROM found_uris
        WHERE found_uris.uri_hash = track.uri_hash )
__SQL_END__
warn "$affected_rows файлов удалено из библиотеки\n" if $affected_rows > 0;

# Удалить файлы альбома, треки которого ниразу не воспроизводились
$affected_rows = $db->do(<<'__SQL_END__',undef);
DELETE FROM track
WHERE uri ISNULL and NOT EXISTS (
SELECT subTrack.album_id
        FROM play_log
        JOIN track as subTrack ON subTrack.track_id = play_log.track_id
        WHERE subTrack.album_id = track.album_id
)
__SQL_END__
warn "Удалено $affected_rows треков, отсутсвующих в библиотеке и не воспроизводимых\n"
    if $affected_rows > 0;

# Удалить альбомы не содержащие треков
$affected_rows = $db->do(<<'__SQL_END__',undef);
DELETE FROM album 
WHERE NOT EXISTS 
    ( SELECT track.track_id 
        FROM track 
        WHERE track.album_id = album.album_id )
__SQL_END__
warn "Удалено $affected_rows пустых альбомов\n" if $affected_rows > 0;

# Удалить исполнителей без альбомов
$affected_rows = $db->do(<<'__SQL_END__',undef);
DELETE FROM artist 
WHERE NOT EXISTS 
    ( SELECT album.album_id
        FROM album
        WHERE artist.artist_id = album.artist_id )
__SQL_END__
warn "Удалено $affected_rows артистов, не содержащих альбомов\n" if $affected_rows > 0;

$db->disconnect;

warn "актуализация завершена успешно\n";
