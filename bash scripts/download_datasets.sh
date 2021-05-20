#!/bin/bash

DIR=data/data-original
mkdir -p $DIR
cd $DIR

v1corpora="CCAligned MultiCCAligned OpenSubtitles WikiMatrix XLEnt"

wget -O Europarl.zip -c https://opus.nlpl.eu/download.php?f=Europarl/v8/moses/en-sl.txt.zip
wget -O DGT.zip -c https://opus.nlpl.eu/download.php?f=DGT/v2019/moses/en-sl.txt.zip
wget -O wikimedia.zip -c https://opus.nlpl.eu/download.php?f=wikimedia/v20210402/moses/en-sl.txt.zip
wget -O TildeMODEL.zip -c https://opus.nlpl.eu/download.php?f=TildeMODEL/v2018/moses/en-sl.txt.zip

for corpus in $v1corpora
do
	wget -O ${corpus}.zip -c https://opus.nlpl.eu/download.php?f=${corpus}/v1/moses/en-sl.txt.zip
done

corpora="${v1corpora} DGT Europarl wikimedia TildeMODEL"

for corpus in $corpora
do
	unzip ${corpus}.zip
	rm README
	rm LICENSE
	rm ${corpus}.en-sl.xml
	rm ${corpus}.zip
done

cd ../..