#!/usr/bin/perl
use strict;
use warnings;

use DBI;
use Data::Dumper;
use Audio::MPD;
use File::Basename;
use File::Copy;

my $collection_dir = shift || die "не передана директория коллекции\n";
my $cover_dir = shift || die "не передана директория обложек\n";
my $mpd = Audio::MPD->new;
my $collection = $mpd->collection;

my $db = DBI->connect("dbi:SQLite:dbname=/home/noname/play_stat.db","",
    "", { RaiseError => 1, AutoCommit => 1 } );

my $get_artist_id = $db->prepare(<<'__SQL_END__');
SELECT artist_id FROM artist WHERE name = ?
__SQL_END__

my $get_album_id = $db->prepare(<<'__SQL_END__');
SELECT album_id FROM album WHERE artist_id = ?
    and title = ? and release_year = ?
__SQL_END__

foreach my $artist ( sort($collection->all_artists) ) {
    next unless $artist;
    $get_artist_id->execute($artist);
    my @row = $get_artist_id->fetchrow_array;
    my $artist_id;
    $artist_id = $row[0] if $row[0];
    next unless $artist_id;

    my @songs = $collection->songs_by_artist($artist);
    my %seen = ();
    my @albums = ();
    foreach my $song ( @songs ) {
        next if not ( $song->date =~ m/(\d{4})(?:-(\d{4}))?/ 
                and $song->album );
        unless ($seen{$song->date,"\0",$song->album}++) {
            my %entry = ();
            $entry{orig_year} = $1;
            $entry{release_year} = $2 || $1;
            $entry{title} = $song->album;
            $entry{cover} = dirname($song->file).'/cover.jpg';
            push(@albums,\%entry);
        }
    }

    foreach my $album (@albums) {
        # используется алгоритм, похожий на добавление исполнителя
        $get_album_id->execute($artist_id,$album->{title},
            $album->{release_year});
        my @row = $get_album_id->fetchrow_array;
        my $album_id;
        $album_id = $row[0] if $row[0];
        next unless $album_id;
        my $cover = $collection_dir.'/'.$album->{cover};
        if ( -e $cover ) {
            copy($cover,sprintf('%s/%04d.jpg',$cover_dir,$album_id));
        }
    }
}
