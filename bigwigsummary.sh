#!/bin/bash
#
# bigwigsummary.sh
# Template script for bigwig summaries for plotting correlation heatmaps with deepTools
# Script is modular and takes in bigwig files to plot counts over genomic bins using multiBigwigSummary command
# Usage: bigwigsummary.sh

# mkdir
export HOME=$PWD
mkdir -p input output

sample1=$1
sample2=$2
sample3=$3
sample4=$4
sample5=$5
sample6=$6

bwdir= ## directory for bigwigs
blacklist=mm39.excluderanges.bed


# copy necessary files from staging to input
cp $bwdir/$sample1 input
cp $bwdir/$sample2 input
cp $bwdir/$sample3 input
cp $bwdir/$sample4 input

cp /staging/groups/roopra_group/reference_misc/$blacklist input

# run multiBigwigsummary command

multiBigwigSummary bins -b input/$sample1 input/$sample2 input/$sample3 input/$sample4 input/$sample5 input/$sample6 \
	--smartLabels -bl input/$blacklist \
	-o output/result.npz

# move output to staging
cd output
mv *.npz $bwdir ## or wherever you want the output directory
cd ~

# before script exits, remove files from working directory
rm -r input output

###END
