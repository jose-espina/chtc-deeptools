#!/bin/bash
#
# computematrix.sh
# Template script for generating matrix files for plotting heatmaps with deepTools
# Usage: computematrix.sh

# mkdir
export HOME=$PWD
mkdir -p input output

region1=
region2=
sample1=
sample2=
sample3=
sample4=

rdir= ## directory for regions files
bwdir= ## directory for bigwigs


# copy necessary files from staging to input
cp $rdir/$region1 input
cp $rdir/$region2 input
cp $bwdir/$sample1 input
cp $bwdir/$sample2 input
cp $bwdir/$sample3 input
cp $bwdir/$sample4 input

# run computematrix commands
computeMatrix reference-point -S input/$sample1 input/$sample2 input/$sample3 input/$sample4 -R input/$region1 \
	-o output/ .mat.gz \ ## output mat filename
	--referencePoint center -b 3000 -a 3000 \
	--samplesLabel label1 label2 labelx --verbose

computeMatrix reference-point -S input/$sample1 input/$sample2 input/$sample3 input/$sample4 -R input/$region1 \
	-o output/ .mat.gz \  ## output mat filename
	--referencePoint center -b 3000 -a 3000 \
	--samplesLabel label1 label2 labelx --verbose

# move outputs to staging
cd output
mv *.mat.gz $bwdir ## or wherever you want the output directory
cd ~

# before script exits, remove files from working directory
rm -r input output

###END