#!/bin/bash
#mpc update --wait
[ -e ~/.mpdcron/var/dbupdate_state/ ] || mkdir ~/.mpdcron/var/dbupdate_state/
if [ \( ! -e ~/.mpdcron/var/dbupdate_state/dbupdate_timestamp \) -o \( ! -e ~/.mpdcron/var/dbupdate_state/prev_cue_list \) ] 
then
    echo "обновляется вся библиотека!"
    find ~/MUSIC/lossless/cd \
        ~/MUSIC/lossless/ -name '*.cue' \
        > ~/.mpdcron/var/dbupdate_state/cue_update_list 

    cp ~/.mpdcron/var/dbupdate_state/cue_update_list ~/.mpdcron/var/dbupdate_state/all_cue_list
else
    find ~/MUSIC/lossless/cd \
        ~/MUSIC/lossless/dvd -name '*.cue' \
        \( -newercc ~/.mpdcron/var/dbupdate_state/dbupdate_timestamp \
        -o -newercm ~/.mpdcron/var/dbupdate_state/dbupdate_timestamp \) \
        -fprint /dev/stderr -print > ~/.mpdcron/var/dbupdate_state/cue_update_list

    find ~/MUSIC/lossless/cd \
        ~/MUSIC/lossless/dvd -name '*.cue' > \
        ~/.mpdcron/var/dbupdate_state/all_cue_list

#находим новые cue-файлы
    echo "новые cue-файлы"
    cat ~/.mpdcron/var/dbupdate_state/prev_cue_list ~/.mpdcron/var/dbupdate_state/all_cue_list | sort | uniq -d | cat - ~/.mpdcron/var/dbupdate_state/all_cue_list | sort | uniq -u | tee -a ~/.mpdcron/var/dbupdate_state/cue_update_list
fi

temp_db=`mktemp -p /tmp mpd_db_XXXXXXXX`
cat ~/.mpdcron/var/dbupdate_state/cue_update_list | sort -u \
    | xargs -d "\n" --no-run-if-empty ~/bin/perl/dbupdate.0.16.pl --output $temp_db
if [ $? -ne 0 ] 
then
    echo "ошибка при обновлении базы mpd"
    mpc -q single on
    mpc -q pause
    rm $temp_db
    exit 1
elif [ -s $temp_db ]
then
    echo "база mpd обновлена успешно"
    chmod a+r $temp_db
    #sudo -u mpd mpd --kill
    sudo -u mpd mpd --kill
    sudo -u mpd cp $temp_db /var/lib/mpd/mpd.db
    sleep 1 && sudo -u mpd mpd
    touch ~/.mpdcron/var/dbupdate_state/dbupdate_timestamp
    rm $temp_db
else
    echo "нет cue-файлов к обновлению"
fi
mv ~/.mpdcron/var/dbupdate_state/all_cue_list ~/.mpdcron/var/dbupdate_state/prev_cue_list
