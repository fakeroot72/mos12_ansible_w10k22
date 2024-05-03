#!/bin/sh

[ `ps auxw | grep w10k22_vdi_download.sh | wc -l` -gt 3 ] && exit

exec >> /tmp/ansible-w10k22-download.log 2>&1

# rm -rf /home/student_w10k22_vdi_current/
#rm -rf /opt/.lycu1580/local/w10k22_vdi_bz/
#rm -rf /opt/.lycu1580/local/w10k22.vdi

start_dir=`pwd`

md5_dir=/opt/.lycu1580v2/files/w10k22_vdi_bz_md5/ 
local_dir=/opt/.lycu1580v2/local/w10k22_vdi/
destination=/opt/.lycu1580v2/local/w10k22_vdi/w10k22.vdi
base_url=https://bf726e13342a.hosting.myjino.ru/mos12_ansible/w10k22_vdi_bz/

[ -f $local_dir/ready04.timestamp ] && exit

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
        date > $local_dir/ready04.timestamp && \
        rm -f $local_dir/*.??
fi
