#!/bin/sh

[ `ps auxw | grep student_dot_wine_klt_pabc_download.sh | wc -l` -gt 3 ] && exit

exec >> /tmp/ansible-student_dot_wine_klt_pabc-download.log 2>&1

start_dir=`pwd`

md5_dir=/opt/.lycu1580v2/files/student_dot_wine_klt_pabc_tbz_md5/ 
local_dir=/opt/.lycu1580v2/local/student_dot_wine_klt_pabc_tbz/
base_url=https://bf726e13342a.hosting.myjino.ru/mos12_ansible/student_dot_wine_klt_pabc_tbz/

[ -f $local_dir/ready01.timestamp ] && exit

mkdir -p $local_dir
rsync -a $md5_dir $local_dir
cd $local_dir

all_done=true

for md5_file in `ls *.??.md5`
do
    data_file=`cat $md5_file | awk '{print $2}'`

    md5sum -c $md5_file || (rm $data_file; wget $base_url/$data_file && md5sum -c $md5_file || all_done=false)

done


if [ $all_done = true ]
then
    rm -rf student_dot_wine_klt_pabc/
    cat *.tbz.?? | tar xjp && \
        date > ready01.timestamp && \
        rm -f *.??
fi

cd $start_dir

