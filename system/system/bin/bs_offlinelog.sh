umask 022

LOGDIR=/data/local/log
LOGFILE=$LOGDIR"/logcat"
BACKUP_LOGFS=$LOGDIR"/backupLogfs"
MV_FILES_SHELL="/system/bin/mv_files.sh"
XBL_UEFI_LOG_0="/dev/logfs/UefiLog0.txt"
XBL_UEFI_LOG_1="/dev/logfs/UefiLog1.txt"
XBL_UEFI_LOG_2="/dev/logfs/UefiLog2.txt"
XBL_UEFI_LOG_3="/dev/logfs/UefiLog3.txt"
XBL_UEFI_LOG_4="/dev/logfs/UefiLog4.txt"
XBL_UEFI_LOG_DIR="/dev/logfs"

BACKUP_UEFI_LOG_0=$BACKUP_LOGFS"/UefiLog0.txt"
BACKUP_UEFI_LOG_1=$BACKUP_LOGFS"/UefiLog1.txt"
BACKUP_UEFI_LOG_2=$BACKUP_LOGFS"/UefiLog2.txt"
BACKUP_UEFI_LOG_3=$BACKUP_LOGFS"/UefiLog3.txt"
BACKUP_UEFI_LOG_4=$BACKUP_LOGFS"/UefiLog4.txt"

if [ "$1" == "clear" ]; then
    rm -rf /data/local/log/*
    exit 0
fi

NUM_MAX=1536
NUM_DEFAULT=768
NUM_MIN=64

size=$(getprop persist.offlinelog.logcatall.size)
if [ -z "$size" ]; then
        num=$NUM_DEFAULT
else
        num=$(($size/4))
fi

if [ "$num" -gt "$NUM_MAX" ] || [ "$num" -lt "NUM_MIN" ]; then
        num=$NUM_DEFAULT
fi

echo "bslogs offlinelog start" >> $LOGFILE
if [ ! -d $BACKUP_LOGFS ];then
    mkdir $BACKUP_LOGFS
fi


date >> $LOGFILE
# append bootloader log
finish=$(getprop service.offlinelog.bootloader)
if [ -z "$finish" ] || [ "$finish" -eq "false" ]; then
        echo "bslogs offlinelog start" >> $LOGFILE
        echo "" >> $LOGFILE
        echo "" >> $LOGFILE
        echo "----------------------------backup history logfs start------------------------------" >> $LOGFILE
        if [ -f $BACKUP_UEFI_LOG_4 ];then
            echo "" >> $LOGFILE
            echo "  ---- backup history uefi log 4 ----" >> $LOGFILE
            nl $BACKUP_UEFI_LOG_4 >> $LOGFILE
        fi
        if [ -f $BACKUP_UEFI_LOG_3 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- backup history uefi log 3 ----" >> $LOGFILE
            nl $BACKUP_UEFI_LOG_3 >> $LOGFILE
        fi
        if [ -f $BACKUP_UEFI_LOG_2 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- backup history uefi log 2 ----" >> $LOGFILE
            nl $BACKUP_UEFI_LOG_2 >> $LOGFILE
        fi
        if [ -f $BACKUP_UEFI_LOG_1 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- backup history uefi log 1 ----" >> $LOGFILE
            nl $BACKUP_UEFI_LOG_1 >> $LOGFILE
        fi
        if [ -f $BACKUP_UEFI_LOG_0 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- backup history uefi log 0 ----" >> $LOGFILE
            nl $BACKUP_UEFI_LOG_0 >> $LOGFILE
        fi
        echo "" >> $LOGFILE
        echo "----------------------------backup history logfs end------------------------------" >> $LOGFILE
        echo "" >> $LOGFILE
        echo "" >> $LOGFILE
        if [ -f $XBL_UEFI_LOG_4 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- uefi log 4 ----" >> $LOGFILE
            nl $XBL_UEFI_LOG_4 >> $LOGFILE
        fi
        if [ -f $XBL_UEFI_LOG_3 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- uefi log 3 ----" >> $LOGFILE
            nl $XBL_UEFI_LOG_3 >> $LOGFILE
        fi
        if [ -f $XBL_UEFI_LOG_2 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- uefi log 2 ----" >> $LOGFILE
            nl $XBL_UEFI_LOG_2 >> $LOGFILE
        fi
        if [ -f $XBL_UEFI_LOG_1 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- uefi log 1 ----" >> $LOGFILE
            nl $XBL_UEFI_LOG_1 >> $LOGFILE
        fi
        if [ -f $XBL_UEFI_LOG_0 ];then
            echo "" >> $LOGFILE
            echo "" >> $LOGFILE
            echo "  ---- uefi log 0 ----" >> $LOGFILE
            nl $XBL_UEFI_LOG_0 >> $LOGFILE
        fi
        cp -rf $XBL_UEFI_LOG_DIR"/"* $BACKUP_LOGFS
        setprop service.offlinelog.bootloader true
fi

date >> $LOGFILE
logcat -b kernel -c
dmesg >> $LOGFILE

/system/bin/logcat -b all -v threadtime -v usec -v printable -D -r 4096 -n $num -f $LOGFILE

