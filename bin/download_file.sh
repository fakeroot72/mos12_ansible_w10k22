#!/bin/sh

[ `ps auxw | grep download_file.sh | wc -l` -gt 3 ] && exit

exec >> /tmp/ansible-download-file.log 2>&1 # перенаправляем весь вывод в лог для анализа чего не рабтает

[ ! -f /tmp/ansible-rc.local.log ] && exit

source bin/config.sh

start_dir=`pwd`

md5_dir=$1
local_dir=$2
destination=$3
base_url=$4
flag_file=$5

[ -f $local_dir/$flag_file ] && exit

mkdir -p $local_dir
rsync -a $md5_dir $local_dir
cd $local_dir

all_done=true

for md5_file in `ls *.??.md5`
do
    data_file=`cat $md5_file | awk '{print $2}'`

    md5sum -c $md5_file || (rm $data_file; wget $base_url/$data_file && md5sum -c $md5_file || all_done=false)

done

cd $start_dir

if [ $all_done = true ]
then
    cat $local_dir/*.?? | bunzip2 -c - > $destination && \
        cd $local_dir && \
        md5sum -c $destination.md5 && \
        cd $start_dir && \
        date > $local_dir/$flag_file && \
        rm -f $local_dir/*.??
fi
