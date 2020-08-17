#!/bin/sh

BCK_PATH=~/.cache      #path from where to backup
BCK_EXT=whl            #extension of files to backup
DEST_PATH=~/backuped   #path where to save backup files
tempscript=.temp.sh  #name of temporary helper script

mkdir $DEST_PATH 2>/dev/null
echo "#!/bin/sh" >$tempscript
find $BCK_PATH | grep "\.$BCK_EXT$" | sed -e "s=$BCK_PATH=cp $BCK_PATH=" | sed -e "s=\.$BCK_EXT$=\.$BCK_EXT $DEST_PATH=" >>$tempscript
chmod +x $tempscript
./$tempscript
rm $tempscript

