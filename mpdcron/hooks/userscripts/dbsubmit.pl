#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use Storable;
use Config::INI::Reader;
use Digest::MD5 qw(md5_hex);
use Encode qw(encode_utf8 decode_utf8);
use utf8;

use constant MPD_STATUS_STATE        => $ENV{'MPD_STATUS_STATE'};
use constant MPD_STATUS_TOTAL_TIME   => $ENV{'MPD_STATUS_TOTAL_TIME'} || 0;
use constant MPD_SONG_ID             => $ENV{'MPD_SONG_ID'} || -1;
use constant MPD_SONG_URI            => $ENV{'MPD_SONG_URI'};
use constant MPD_SONG_TAG_ALBUM      => $ENV{'MPD_SONG_TAG_ALBUM'};
use constant MPD_SONG_TAG_ARTIST     => $ENV{'MPD_SONG_TAG_ALBUM_ARTIST'};
use constant MPD_SONG_TAG_TITLE      => $ENV{'MPD_SONG_TAG_TITLE'};
use constant MPD_SONG_TAG_TRACK      => $ENV{'MPD_SONG_TAG_TRACK'};
use constant MPD_SONG_TAG_DATE       => $ENV{'MPD_SONG_TAG_DATE'};
use constant MPD_SONG_TAG_DISC       => $ENV{'MPD_SONG_TAG_DISC'};
use constant MPD_STATUS_ELAPSED_TIME => $ENV{'MPD_STATUS_ELAPSED_TIME'};

# значение по умолчанию
my $prev_state_file = 'var/dbsubmit/prev_state';

my $config_hash = Config::INI::Reader->read_file('userscripts.ini');
if ( $config_hash->{dbsubmit}->{prev_state_file} and
    (-r $config_hash->{dbsubmit}->{prev_state_file} or
    not -e $config_hash->{dbsubmit}->{prev_state_file} ) ) {
    $prev_state_file = $config_hash->{dbsubmit}->{prev_state_file};
}

sub scrob;
sub elapsed;
sub song_change;

my $prev_state = { state => 'stop', song => { id => -1 }};
if ( -r $prev_state_file ) {
    $prev_state = retrieve $prev_state_file;
}

my $song = { 
    id => MPD_SONG_ID,
    total_time => MPD_STATUS_TOTAL_TIME,
    mpd_elapsed => MPD_STATUS_ELAPSED_TIME,
    tags => {
        uri => MPD_SONG_URI,
        uri_hash => md5_hex(Encode::is_utf8(MPD_SONG_URI)?encode_utf8(MPD_SONG_URI):MPD_SONG_URI),
        album => MPD_SONG_TAG_ALBUM,
        artist => MPD_SONG_TAG_ARTIST,
        title => MPD_SONG_TAG_TITLE,
        track => MPD_SONG_TAG_TRACK,
        date => MPD_SONG_TAG_DATE,
        disc => MPD_SONG_TAG_DISC,
    }
};

#print Dumper $song;
#print Data::Dumper->new([$prev_state],['prev'])->Dump;
# текущий статус play
if ( MPD_STATUS_STATE eq 'play' ) {
    # предыдущий статус play
    if ( $prev_state->{state} eq 'play' ) {
        # если трек сменился или воспроизводится заново
        unless ( $song->{id} == $prev_state->{song}->{id} &&
            $song->{mpd_elapsed} != 0) {
            $song->{start} = time;
            song_change($prev_state->{song});
        }
        # если трек перематывается
        else { 
            # сохраняем время (начала прослушивания) и воспроизведения
            $song->{start} = $prev_state->{song}->{start};
            $song->{elapsed} = $prev_state->{song}->{elapsed}
                if $prev_state->{song}->{elapsed};
        }
    }
    # предыдущий статус pause
    elsif ( $prev_state->{state} eq 'pause' ) {
        $song->{start} = time;
        if ( $song->{id} == $prev_state->{song}->{id} &&
            $song->{mpd_elapsed} != 0)
        {
            $song->{elapsed} = $prev_state->{song}->{elapsed};
        }
        else {
            song_change($prev_state->{song});
        }
    }
    # предыдущий статус stop
    elsif ( $prev_state->{state} eq 'stop' ) {
        $song->{start} = time;
    }
}
# текущий статус stop
elsif ( MPD_STATUS_STATE eq 'stop' ) {
    # предыдущий статус play
    if ( $prev_state->{state} eq 'play' ) {
        song_change($prev_state->{song});
    }
    elsif ( $prev_state->{state} eq 'pause' ) {
        song_change($prev_state->{song});
    }
}
# текущий статус pause
elsif ( MPD_STATUS_STATE eq 'pause' ) {
    # предыдущий статус play
    if ( $prev_state->{state} eq 'play' ) {
        if ($prev_state->{song}->{id} == $song->{id}) {
            elapsed($song,$prev_state->{song});
        }
        else {
            song_change($prev_state->{song});
        }
    }
}

my $state = { state => MPD_STATUS_STATE,
    song => $song
};

store $state, $prev_state_file;
#print Data::Dumper->new([$prev_state,$state],['prev','cur'])->Dump;



sub scrob {
    my $tags = shift;

    require DBI;
    import DBI;

    my $db = DBI->connect(
        $config_hash->{'statistic-db'}->{data_source} || "dbi:SQLite:dbname=/home/noname/play_stat.db",
        $config_hash->{'statistic-db'}->{username}    || "",
        $config_hash->{'statistic-db'}->{password}    || "",
    );
 
    my $insert_play_log = $db->prepare(<<'__SQL_END__');
INSERT INTO play_log ( track_id, time, source )
VALUES ( 
( SELECT track_id FROM track WHERE track.uri_hash = ?),
datetime('now'), 0 )
__SQL_END__

    my $rows_affected = $insert_play_log->execute($tags->{uri_hash});
    warn "error on insert to play_log table ".decode_utf8($@) 
        if ( $@ || ! defined($rows_affected) || $rows_affected != 1 );
}

sub elapsed {
    my $s = shift;
    my $p = shift;
    $s->{elapsed} ||= 0;
    $s->{elapsed} = ($p->{elapsed}||0) + time - $p->{start} if $p->{start};
}

sub song_change {
    my $s = shift;
    warn "[stats-pl] song changed\n";
    elapsed($s,$s);
    warn sprintf "[stats-pl] elapsed: %d, total: %d\n",
        $s->{elapsed},$s->{total_time};
    if ( ($s->{elapsed} >= 240 or $s->{elapsed} >= $s->{total_time}/2)
        and $s->{elapsed} >= 30 ) {
            scrob($s->{tags});
    }
    else { warn "[stats-pl] not enought elapsed time\n" }
}
