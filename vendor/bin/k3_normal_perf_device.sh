#!/system/bin/sh

echo "Set to normal mode"
start mi_thermald
start thermal-engine

# All cpus online
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu4/online
echo 1 > /sys/devices/system/cpu/cpu5/online
echo 1 > /sys/devices/system/cpu/cpu6/online
echo 1 > /sys/devices/system/cpu/cpu7/online


# Disable cpu isolation
# Note: echo 4 here to work on both sdm845 and sdm855
echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus

echo walt > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo walt > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo walt > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo walt > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo walt > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo walt > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
echo walt > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
echo walt > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor

echo 0 > sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled


