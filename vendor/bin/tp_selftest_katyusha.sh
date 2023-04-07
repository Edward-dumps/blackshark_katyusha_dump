#! /system/bin/sh
brightness=($(cat /sys/class/backlight/panel0-backlight/brightness))
if [ $brightness -eq 0 ];
then
    echo "backlight is 0,pls do tp_selftest when screen on"
    echo "TEST_FAIL"
        exit
fi
if [ -f /sys/bus/spi/devices/spi0.0/fts_test ];
then
        echo "FOCALTECH"
else
        echo "TEST_FAIL"
        exit
fi
tp_fw_version=($(cat /proc/tp_fw_version))
if [ $tp_fw_version -eq 9 ];
then
	echo "tp firmware is csot sync FW"
	echo "Katyusha_Sync_Conf_MultipleTest.ini" > /sys/bus/spi/devices/spi0.0/fts_test
else
	echo "tp firmware is blackshark non-sync FW"
	echo "Katyusha_Conf_MultipleTest.ini" > /sys/bus/spi/devices/spi0.0/fts_test
fi
test_result=$(cat /sys/bus/spi/devices/spi0.0/fts_test)
if  [ "$test_result" == "PASS" ]; then
    echo "TEST_PASS"
else
    echo "TEST_FAIL"
fi

mkdir -p /data/misc/tp_selftest_data
echo $test_result >> /data/misc/tp_selftest_data/result.txt
