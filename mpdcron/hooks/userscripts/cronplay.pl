#!/usr/bin/perl
use FindBin;
use lib "$FindBin::RealBin/lib";

use strict;
use DateTime::Cron::Simple;

use Config::INI::Reader;
my $config_hash = Config::INI::Reader->read_file('userscripts.ini');

unless ( $config_hash->{cronplay}->{ison} =~ m/true/i 
        or $config_hash->{cronplay}->{ison} == 1)
{
    warn "функция автоматического обновления плейлиста отключена\n";
    exit 0;
}

use DBI;
my $db = DBI->connect(
    $config_hash->{'statistic-db'}->{data_source} || "dbi:SQLite:dbname=/home/noname/play_stat.db",
    $config_hash->{'statistic-db'}->{username}    || "",
    $config_hash->{'statistic-db'}->{password}    || "",
    { RaiseError => 1, AutoCommit => 1 }
);

my %mpd_opts = (
    host => $config_hash->{'mpd_connection'}->{host} || 'localhost',
    port => $config_hash->{'mpd_connection'}->{port} || '6600',
    password => $config_hash->{'mpd_connection'}->{password} || ''
);
use Audio::MPD;
my $mpd = eval { Audio::MPD->new(\%mpd_opts) };
die "не удалось соединиться с сервером mpd: ".decode_utf8($@) if $@;
my $mpd_playlist = $mpd->playlist;

use Data::Dumper;
my $cron_checker = DateTime::Cron::Simple->new();

my $schedule_file = shift || $config_hash->{cronplay}->{schedule_file} || 'schedule.conf';
open(SCHEDULE,'<',$schedule_file)
    or die $schedule_file,':',$!,"\n";
my $line_num = 0;
while (my $line = <SCHEDULE>) {
    $line_num++;
    next if $line =~ m/(?:^#)|(?:^\s*$)/;
    $line .= <SCHEDULE> while $line =~ s/\\\s*$//;

    die "синтаксическая ошибка в строке $line_num\n"
        unless $line =~ m/((?:[-0-9,*]+\s+){5})(.*)/;

    my ($cron_time, $command) = ($1,$2);
    $cron_checker->new_cron($cron_time);
    if ($cron_checker->validate_time) {
        my $sql = "SELECT count(*) as count FROM ($command)";
        my $sth = $db->prepare($sql);
        printf "время: %s; комманда: %s\n",$cron_time,$sql;
        $sth->execute;
        if ($sth->fetchrow_hashref->{count} > 0) {
            $mpd_playlist->clear;

            $sql = "SELECT uri FROM ($command)";
            $sth = $db->prepare($sql);
            $sth->execute;
            while ( my $row = $sth->fetchrow_hashref ) {
                print "добавляется ",$row->{uri},"\n";
                $mpd_playlist->add($row->{uri});
            }
            $mpd->play;

            last;
        }
        else {
            warn "запрос не вернул записей, поиск продолжен\n"
        }
    }
}
