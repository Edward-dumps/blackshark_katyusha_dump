# $1: enable or disable ultrasound PCT test

function enable_ultrasound_mic
{
	#echo "enable ultrasound mic"
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
	#echo "disable ultrasound mic"
	tinymix 'TX DEC3 MUX' 'MSM_DMIC'
	tinymix 'TX SMIC MUX3' 'ZERO'
	tinymix 'TX_AIF1_CAP Mixer DEC3' 0
	tinymix 'ADC4 ChMap' 'ZERO'
	tinymix 'ADC4 MUX' 'INP5'
	tinymix 'TX3 MODE' 'ADC_NORMAL'
	tinymix 'ADC4_MIXER Switch' 0
	tinymix 'AMIC5_MIXER Switch' 0
}

function enable_ultrasound
{
    #echo "enable ultrasound"
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
    #echo "disable ultrasound"
    tinymix 'RX_MACRO RX2 MUX' 'AIF2_PB'
    tinymix 'RX INT0_2 MUX' 'ZERO'
    tinymix 'RX INT0 DEM MUX' 'CLSH_DSM_OUT'
    tinymix 'EAR_RDAC Switch' 0
    tinymix 'RDAC3_MUX' 'RX1'
    tinymix 'RX_EAR Mode' 'OFF'
    tinymix 'EAR PA GAIN' 'G_6_DB'
}

if [ "$1" = "1" ]; then
    # start
    enable_ultrasound_mic
    enable_ultrasound
	echo "start ultrasound SQT"
elif [ "$1" = "0" ]; then
    # stop
    disable_ultrasound_mic
    disable_ultrasound
	echo "stop ultrasound SQT"
else
    echo "command error, check your para"
fi