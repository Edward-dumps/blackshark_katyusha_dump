# $1: audio source
#     main-mic: main mic
#     top-mic: top mic
#     side-mic: side mic
#     headset-mic: headset mic
#     us: ultrasound
# $2: sample rate(Hz)
# $3: sample bit
# $4: channel number
# $5: capture duration(s)
# tinycap file.wav [-D card] [-d device] [-c channels] [-r rate] [-b bits] [-p period_size] [-n n_periods] [-t duration]
# sample usage: capture.sh main-mic 48000 16 2 10

rate=KHZ_192
filename=/data/unknown_mic.wav
sd_filename=/sdcard/unknown_mic.wav

case "$2" in
    "48000" )
        rate=KHZ_48
        ;;
    "96000" )
        rate=KHZ_96
        ;;
    "192000" )
        rate=KHZ_192
        ;;
esac

function enable_main_mic
{
	echo "enabling main mic"
	tinymix 'TX_AIF1_CAP Mixer DEC2' 1
	tinymix 'TX DEC2 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX2' 'SWR_MIC4'
	tinymix 'ADC1 ChMap' 'SWRM_TX2_CH1'
	tinymix 'TX0 MODE' 'ADC_LP'
	tinymix 'ADC1_MIXER Switch' 1
	tinymix 'AMIC1_MIXER Switch' 1
}

function disable_main_mic
{
	echo "disabling main mic"
	tinymix 'TX_AIF1_CAP Mixer DEC2' 0
	tinymix 'TX DEC2 MUX' 'MSM_DMIC'
	tinymix 'TX SMIC MUX2' 'ZERO'
	tinymix 'ADC1 ChMap' 'ZERO'
	tinymix 'TX0 MODE' 'ADC_NORMAL'
	tinymix 'ADC1_MIXER Switch' 0
	tinymix 'AMIC1_MIXER Switch' 0
}

function enable_top_mic
{
	echo "enabling top mic"
	tinymix 'TX DEC3 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX3' 'SWR_MIC9'
	tinymix 'TX_AIF1_CAP Mixer DEC3' 1
	tinymix 'ADC4 ChMap' 'SWRM_TX3_CH2'
	tinymix 'ADC4 MUX' 'INP5'
	tinymix 'TX3 MODE' 'ADC_LP'
	tinymix 'ADC4_MIXER Switch' 1
	tinymix 'AMIC5_MIXER Switch' 1
}

function disable_top_mic
{
	echo "disabling top mic"
	tinymix 'TX DEC3 MUX' 'MSM_DMIC'
	tinymix 'TX SMIC MUX3' 'ZERO'
	tinymix 'TX_AIF1_CAP Mixer DEC3' 0
	tinymix 'ADC4 ChMap' 'ZERO'
	tinymix 'ADC4 MUX' 'INP5'
	tinymix 'TX3 MODE' 'ADC_NORMAL'
	tinymix 'ADC4_MIXER Switch' 0
	tinymix 'AMIC5_MIXER Switch' 0
}

function enable_side_mic
{
	echo "enabling side mic"
	tinymix 'TX DEC5 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX5' 'SWR_MIC8'
	tinymix 'TX_AIF1_CAP Mixer DEC5' 1
	tinymix 'ADC3 MUX' 'INP4'
	tinymix 'TX2 MODE' 'ADC_LP'
	tinymix 'ADC3 ChMap' 'SWRM_TX3_CH1'
	tinymix 'HDR34 MUX' 'NO_HDR34'
	tinymix 'ADC3_MIXER Switch' 1
	tinymix 'AMIC4_MIXER Switch' 1
}

function disable_side_mic
{
	echo "disabling side mic"
	tinymix 'TX DEC5 MUX' 'MSM_DMIC'
	tinymix 'TX SMIC MUX5' 'ZERO'
	tinymix 'TX_AIF1_CAP Mixer DEC5' 0
	tinymix 'ADC3 MUX' 'INP4'
	tinymix 'TX2 MODE' 'ADC_NORMAL'
	tinymix 'ADC3 ChMap' 'SWRM_TX3_CH1'
	tinymix 'HDR34 MUX' 'NO_HDR34'
	tinymix 'ADC3_MIXER Switch' 0
	tinymix 'AMIC4_MIXER Switch' 0
}

function enable_camera_mic
{
	echo "enabling camera mic"
	tinymix 'TX DEC2 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX2' 'SWR_MIC5'
	tinymix 'TX_AIF1_CAP Mixer DEC2' 1
	tinymix 'ADC2 ChMap' 'SWRM_TX2_CH2'
	tinymix 'ADC2 MUX' 'INP3'
	tinymix 'TX1 MODE' 'ADC_LP'
	tinymix 'ADC2_BCS Disable' 1
	tinymix 'HDR12 MUX' 'NO_HDR12'
	tinymix 'ADC2_MIXER Switch' 1
	tinymix 'AMIC3_MIXER Switch' 1
}

function disable_camera_mic
{
	echo "disabling camera mic"
	tinymix 'TX DEC2 MUX' 'MSM_DMIC'
	tinymix 'TX SMIC MUX2' 'ZERO'
	tinymix 'TX_AIF1_CAP Mixer DEC2' 0
	tinymix 'ADC2 ChMap' 'ZERO'
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'TX1 MODE' 'ADC_NORMAL'
	tinymix 'ADC2_BCS Disable' 0
	tinymix 'HDR12 MUX' 'NO_HDR12'
	tinymix 'ADC2_MIXER Switch' 0
	tinymix 'AMIC3_MIXER Switch' 0
}

function enable_headset_mic
{
	echo "enabling headset mic"
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'SWR_MIC5'
	tinymix 'DEC0_BCS Switch' 1
	tinymix 'TX_AIF1_CAP Mixer DEC0' 1
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'ADC2 ChMap' 'SWRM_TX2_CH2'
	tinymix 'MBHC ChMap' 'SWRM_TX3_CH3'
	tinymix 'TX1 MODE' 'ADC_LP'
	tinymix 'BCS Channel' 'CH10'
	tinymix 'HDR12 MUX' 'NO_HDR12'
	tinymix 'ADC2_MIXER Switch' 1
	tinymix 'AMIC2_MIXER Switch' 1

}

function disable_headset_mic
{
	echo "disabling headset mic"
	tinymix 'TX DEC0 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX0' 'ZERO'
	tinymix 'DEC0_BCS Switch' 0
	tinymix 'TX_AIF1_CAP Mixer DEC0' 0
	tinymix 'ADC2 MUX' 'INP2'
	tinymix 'ADC2 ChMap' 'ZERO'
	tinymix 'MBHC ChMap' 'ZERO'
	tinymix 'TX1 MODE' 'ADC_LP'
	tinymix 'BCS Channel' 'CH10'
	tinymix 'HDR12 MUX' 'NO_HDR12'
	tinymix 'ADC2_MIXER Switch' 0
	tinymix 'AMIC2_MIXER Switch' 0
}

function enable_ultrasound_mic
{
	echo "enable ultrasound mic"
	tinymix 'TX DEC3 MUX' 'SWR_MIC'
	tinymix 'TX SMIC MUX3' 'SWR_MIC9'
	tinymix 'TX_AIF1_CAP Mixer DEC3' '1'
	tinymix 'ADC4 ChMap' 'SWRM_TX3_CH2'
	tinymix 'ADC4 MUX' 'INP5'
	tinymix 'TX3 MODE' 'ADC_LP'
	tinymix 'ADC4_MIXER Switch' '1'
	tinymix 'AMIC5_MIXER Switch' '1'
}

function disable_ultrasound_mic
{
	echo "disable ultrasound mic"
	tinymix 'TX DEC3 MUX' 'MSM_DMIC'
	tinymix 'TX SMIC MUX3' 'ZERO'
	tinymix 'TX_AIF1_CAP Mixer DEC3' 0
	tinymix 'ADC4 ChMap' 'ZERO'
	tinymix 'ADC4 MUX' 'INP5'
	tinymix 'TX3 MODE' 'ADC_NORMAL'
	tinymix 'ADC4_MIXER Switch' 0
	tinymix 'AMIC5_MIXER Switch' 0
}


case "$1" in
    "main-mic" )
        enable_main_mic
        filename=/data/main_mic.wav
        sd_filename=/sdcard/main_mic.wav
        ;;
    "top-mic" )
        enable_top_mic
        filename=/data/top_mic.wav
        sd_filename=/sdcard/top_mic.wav
        ;;
    "side-mic" )
        enable_side_mic
        filename=/data/side_mic.wav
        sd_filename=/sdcard/side_mic.wav
        ;;
    "camera-mic" )
        enable_camera_mic
        filename=/data/camera_mic.wav
        sd_filename=/sdcard/camera_mic.wav
        ;;
    "headset-mic" )
        enable_headset_mic
        filename=/data/headset_mic.wav
        sd_filename=/sdcard/headset_mic.wav
        ;;
    "us" )
        enable_ultrasound_mic
        filename=/data/us_mic.wav
        sd_filename=/sdcard/us_mic.wav
        ;;
    *)
        echo "Usage: capture.sh main-mic 48000 16 2 10"
        ;;
esac

if [ -z "$6" ]; then
    period_size=1024
else
    period_size=$6
fi

if [ -z "$7" ]; then
    n_periods=4
else
    n_periods=$7
fi


# start recording
echo "start recording"
agmcap $filename -D 100 -d 101 -r $2 -b $3 -c 1 -T $5 -p $period_size -n $n_periods -i 'CODEC_DMA-LPAIF_RXTX-TX-3'
ret=$?
if [ $ret -ne 0 ]; then
    echo "tinycap done, return $ret"
fi
cp $filename $sd_filename
# tear down
case "$1" in
    "main-mic" )
        disable_main_mic
        ;;
    "top-mic" )
        disable_top_mic
        ;;
    "side-mic" )
        disable_side_mic
        ;;
    "camera-mic" )
        disable_camera_mic
        ;;
    "headset-mic" )
        disable_headset_mic
        ;;
    "us" )
        disable_ultrasound_mic
        ;;
esac

