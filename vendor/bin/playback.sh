set -x
# $1: device for output
#     spk: stereo speaker
#     top-spk: top speaker
#     bot-spk: bottom speaker
#     rcv: receiver
#     spk_hp: speaker high power
#     top-spk_hp: top speaker high power
#     bot-spk_hp: bottom speaker high power
#     rcv_hp: headset
#     us: ultrasound

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk
# rcv.wav:-4.5dbfs   spk: -4.8dbfs  ultra: -4.5dbfs  spk_hp:-1.8dbfs

function enable_receiver
{
    echo "enabling receiver"
    tinymix 'RX_EAR Mode' 'ON'
    tinymix 'RX_MACRO RX0 MUX' 'AIF1_PB'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'EAR_RDAC Switch' 1
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'EAR PA Gain' 'G_6_DB'
}

function disable_receiver
{
    echo "disabling receiver"
    tinymix 'RX_EAR Mode' 'OFF'
    tinymix 'RX_MACRO RX0 MUX' 'ZERO'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'EAR_RDAC Switch' 0
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'EAR PA Gain' 'G_6_DB'
}

function enable_speaker
{
    echo "enabling speaker"
    tinymix 'Left SPK Safe EN' 0
    tinymix 'Left DIN Source Mux' 'PCM'
    tinymix 'Left SPK Channel' 'CH0'
    tinymix 'Right SPK Safe EN' 0
    tinymix 'Right DIN Source Mux' 'PCM'
    tinymix 'Right SPK Channel' 'CH1'

    sleep 1
}

function disable_speaker
{
    echo "disabling speaker"
    tinymix 'Left SPK Safe EN' 1
    tinymix 'Left DIN Source Mux' 'TONE'
    tinymix 'Left SPK Channel' 'CH0'
    tinymix 'Right SPK Safe EN' 1
    tinymix 'Right DIN Source Mux' 'TONE'
    tinymix 'Right SPK Channel' 'CH0'
}

function enable_speaker_top
{
    echo "enabling speaker top"
    tinymix 'Left SPK Safe EN' 0
    tinymix 'Left DIN Source Mux' 'PCM'
    tinymix 'Left SPK Channel' 'CH0'

    sleep 1
}

function disable_speaker_top
{
    echo "disabling speaker top"
    tinymix 'Left SPK Safe EN' 1
    tinymix 'Left DIN Source Mux' 'TONE'
    tinymix 'Left SPK Channel' 'CH0'
}

function enable_speaker_bot
{
    echo "enabling speaker bottom"
    tinymix 'Right SPK Safe EN' 0
    tinymix 'Right DIN Source Mux' 'PCM'
    tinymix 'Right SPK Channel' 'CH1'

    sleep 1
}

function disable_speaker_bot
{
    echo "disabling speaker bottom"
    tinymix 'Right SPK Safe EN' 1
    tinymix 'Right DIN Source Mux' 'TONE'
    tinymix 'Right SPK Channel' 'CH0'
}

function enable_headset_left
{
    echo "enabling headset left"
    tinymix 'RX_MACRO RX0 MUX' 'AIF1_PB'
    tinymix 'RX_MACRO RX1 MUX' 'AIF1_PB'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'RX INT1_1 MIX1 INP0' 'RX1'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX_COMP1 Switch' 1
    tinymix 'RX_COMP2 Switch' 1
    tinymix 'HPHL_COMP Switch' 1
    tinymix 'HPHR_COMP Switch' 1
    tinymix 'HPHL_RDAC Switch' 1
    tinymix 'HPHR_RDAC Switch' 1
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 100
    tinymix 'RX_RX1 Digital Volume' 0
}

function disable_headset_left
{
    echo "disabling headset left"
    tinymix 'RX_MACRO RX0 MUX' 'ZERO'
    tinymix 'RX_MACRO RX1 MUX' 'ZERO'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT1_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX_COMP1 Switch' 0
    tinymix 'RX_COMP2 Switch' 0
    tinymix 'HPHL_COMP Switch' 0
    tinymix 'HPHR_COMP Switch' 0
    tinymix 'HPHL_RDAC Switch' 0
    tinymix 'HPHR_RDAC Switch' 0
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 84
    tinymix 'RX_RX1 Digital Volume' 84
}

function enable_headset_right
{
    echo "enabling headset right"
    tinymix 'RX_MACRO RX0 MUX' 'AIF1_PB'
    tinymix 'RX_MACRO RX1 MUX' 'AIF1_PB'
    tinymix 'RX INT0_1 MIX1 INP0' 'RX0'
    tinymix 'RX INT1_1 MIX1 INP0' 'RX1'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'RX_COMP1 Switch' 1
    tinymix 'RX_COMP2 Switch' 1
    tinymix 'HPHL_COMP Switch' 1
    tinymix 'HPHR_COMP Switch' 1
    tinymix 'HPHL_RDAC Switch' 1
    tinymix 'HPHR_RDAC Switch' 1
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 0
    tinymix 'RX_RX1 Digital Volume' 100
}

function disable_headset_right
{
    echo "disabling headset right"
    tinymix 'RX_MACRO RX0 MUX' 'ZERO'
    tinymix 'RX_MACRO RX1 MUX' 'ZERO'
    tinymix 'RX INT0_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT1_1 MIX1 INP0' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX INT1 DEM MUX' 'NORMAL_DSM_OUT'
    tinymix 'RX_COMP1 Switch' 0
    tinymix 'RX_COMP2 Switch' 0
    tinymix 'HPHL_COMP Switch' 0
    tinymix 'HPHR_COMP Switch' 0
    tinymix 'HPHL_RDAC Switch' 0
    tinymix 'HPHR_RDAC Switch' 0
    tinymix 'HPHL Volume' 24
    tinymix 'HPHR Volume' 24
    tinymix 'RX_RX0 Digital Volume' 84
    tinymix 'RX_RX1 Digital Volume' 84
}

function enable_ultrasound
{
    echo "enable ultrasound"
    tinymix 'RX_MACRO RX2 MUX' 'AIF2_PB'
    tinymix 'RX INT0_2 MUX' 'RX2'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'EAR_RDAC Switch' 1
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'RX_EAR Mode' 'ON'
    tinymix 'EAR PA GAIN' 'G_6_DB'
}

function disable_ultrasound
{
    echo "disable ultrasound"
    tinymix 'RX_MACRO RX2 MUX' 'AIF2_PB'
    tinymix 'RX INT0_2 MUX' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'EAR_RDAC Switch' 0
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'RX_EAR Mode' 'OFF'
    tinymix 'EAR PA GAIN' 'G_6_DB'
}

if [ "$1" = "spk" ]; then
    enable_speaker
    filename=/vendor/etc/spk.wav
elif [ "$1" = "top-spk" ]; then
    enable_speaker_top
    filename=/vendor/etc/spk.wav
elif [ "$1" = "bot-spk" ]; then
    enable_speaker_bot
    filename=/vendor/etc/spk.wav
elif [ "$1" = "rcv" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "spk_hp" ]; then
    enable_speaker
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "top-spk_hp" ]; then
    enable_speaker_top
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "bot-spk_hp" ]; then
    enable_speaker_bot
    filename=/vendor/etc/spk_hp.wav
elif [ "$1" = "rcv_hp" ]; then
    enable_headset
    filename=/vendor/etc/rcv.wav
elif [ "$1" = "us" ]; then
    enable_ultrasound
    filename=/vendor/etc/ultrasound.wav
elif [ "$1" = "main-mic" ]; then
    enable_speaker
    filename=/data/main_mic.wav
elif [ "$1" = "top-mic" ]; then
    enable_speaker
    filename=/data/top_mic.wav
elif [ "$1" = "side-mic" ]; then
    enable_speaker
    filename=/data/side_mic.wav
elif [ "$1" = "headset-left" ]; then
    enable_headset_left
    filename=/data/headset_mic.wav
elif [ "$1" = "headset-right" ]; then
    enable_headset_right
    filename=/data/headset_mic.wav
else
    echo "Usage: playback.sh device; device: spk or rcv or spk_hp or us"
fi

echo "start playing"
if [ "$1" = "spk" ]; then
    agmplay $filename  -D 100 -d 100 -i 'MI2S-LPAIF-RX-TERTIARY'
elif [ "$1" = "top-spk" ]; then
    agmplay $filename  -D 100 -d 100 -i 'MI2S-LPAIF-RX-TERTIARY'
elif [ "$1" = "bot-spk" ]; then
    agmplay $filename  -D 100 -d 100 -i 'MI2S-LPAIF-RX-TERTIARY'
elif [ "$1" = "rcv" ]; then
    agmplay $filename  -D 100 -d 100 -i 'CODEC_DMA-LPAIF_RXTX-RX-0'
elif [ "$1" = "headset-left" ]; then
    agmplay $filename  -D 100 -d 100 -i 'CODEC_DMA-LPAIF_RXTX-RX-0'
elif [ "$1" = "headset-right" ]; then
    agmplay $filename  -D 100 -d 100 -i 'CODEC_DMA-LPAIF_RXTX-RX-0'
elif [ "$1" = "us" ]; then
    agmplay $filename  -D 100 -d 100 -r 96000 -i 'CODEC_DMA-LPAIF_RXTX-RX-1'
fi


if [ "$1" = "spk" ]; then
    disable_speaker
elif [ "$1" = "top-spk" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv" ]; then
    disable_receiver
elif [ "$1" = "spk_hp" ]; then
    disable_speaker
elif [ "$1" = "top-spk_hp" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk_hp" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv_hp" ]; then
    disable_headset
elif [ "$1" = "us" ]; then
    disable_ultrasound
elif [ "$1" = "main-mic" ]; then
    disable_speaker
elif [ "$1" = "top-mic" ]; then
    disable_speaker
elif [ "$1" = "side-mic" ]; then
    disable_speaker
elif [ "$1" = "headset-left" ]; then
    disable_headset_left
elif [ "$1" = "headset-right" ]; then
    disable_headset_right
fi

exit 0
