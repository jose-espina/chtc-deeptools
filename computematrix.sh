#!/bin/bash
#
# computematrix.sh
# Template script for generating matrix files for plotting heatmaps with deepTools
# Usage: computematrix.sh

# mkdir
export HOME=$PWD
mkdir -p input output

region1=240930-nuc-EZH2_peaks.narrowPeak
region2=240930-nuc-SUZ12_peaks.narrowPeak
sample1=240930-nuc-IgG.bw
sample2=240930-nuc-EZH2.bw
sample3=240930-nuc-SUZ12.bw

# copy necessary files from staging to input
cp /staging/groups/roopra_group/jespina/$region1 input
cp /staging/groups/roopra_group/jespina/$region2 input
cp /staging/groups/roopra_group/jespina/$sample1 input
cp /staging/groups/roopra_group/jespina/$sample2 input
cp /staging/groups/roopra_group/jespina/$sample3 input

# run computematrix commands
computeMatrix reference-point -S input/$sample1 input/$sample2 input/$sample3 -R input/$region1 \
	-o output/EZH2_peaks.mat.gz \
	--referencePoint center -b 3000 -a 3000 \
	--samplesLabel IgG EZH2 SUZ12 --verbose \

computeMatrix reference-point -S input/$sample1 input/$sample2 input/$sample3 -R input/$region2 \
	-o output/SUZ12_peaks.mat.gz \
	--referencePoint center -b 3000 -a 3000 \
	--samplesLabel IgG EZH2 SUZ12 --verbose \

# move outputs to staging
cd output
mv *.mat.gz /staging/groups/roopra_group/jespina
cd ~

# before script exits, remove files from working directory
rm -r input output

###END