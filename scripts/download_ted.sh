#!/bin/bash

DIR=data/data-original-ted
mkdir -p $DIR
cd $DIR

corpora="TED2013 TED2020"

wget -O TED2013.zip -c https://opus.nlpl.eu/download.php?f=TED2013/v1.1/moses/en-sl.txt.zip
wget -O TED2020.zip -c https://opus.nlpl.eu/download.php?f=TED2020/v1/moses/en-sl.txt.zip
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1hIODDj_TbyfDa0o5ouMmzh42ZSmYm7PD' -O extra.zip

for corpus in $corpora
do
	unzip ${corpus}.zip
	rm README
	rm LICENSE
	rm ${corpus}.en-sl.xml
	rm ${corpus}.en-sl.ids
	rm ${corpus}.zip
	mv ${corpus}.en-sl.en ${corpus}.en
	mv ${corpus}.en-sl.sl ${corpus}.sl
done

unzip extra.zip
rm extra.zip

#fix dataset file endings from drive
for f in *en.txt; do mv "$f" "${f%en.txt}.en"; done
for f in *sl.txt; do mv "$f" "${f%sl.txt}.sl"; done

cd ../..
