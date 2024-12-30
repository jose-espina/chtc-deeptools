#!/bin/bash
#
# bamcoverage.sh
# CHTC generating coverage files with deepTools
# Usage: bamcoverage.sh <sorted bam> <bigwig or bedgraph>

# mkdir
export HOME=$PWD
mkdir -p input output

# assign bam to $1
# assign setting to $2
bam=$1
setting=$2

# copy $bam and index from staging to input
cp /staging/jespina/$bam input
cp /staging/jespina/${bam).bai input

# get basename of $bam and assign to $samplename for naming output files
samplename=`basename $bam _bowtie2_sorted_mkdup.bam`

# print name of $bam and $setting to stdout
echo "Converting" $bam "to" $setting

# run bamcoverage depending on $setting
if [ "$setting" == "bigwig" ]; then 
	bamCoverage -b input/$bam --binSize 20 -p max \
	--effectiveGenomeSize 2652783500 \
	--smoothLength 60 --extendReads 150 --centerReads \
	-of bigwig -o output/${samplename}.bw
elif [ "$setting" == "bedgraph" ]; then
	bamCoverage -b input/$bam --binSize 10 -p max \
	--effectiveGenomeSize 2652783500 \
	--smoothLength 60 --extendReads 150 --centerReads\
	-of bedgraph -o output/${samplename}.bg
fi

# move output file to staging
cd output
if [ "$setting" == "bigwig" ]; then
	mv ${samplename}.bw /staging/jespina
elif [ "$setting" == "bedgraph" ]; then
	mv ${samplename}.bg /staging/jespina
fi
cd ~

# before script exits, remove files from working directory
rm -r input output

###END
