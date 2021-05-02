# Automatic language translation

## Used frameworks

* [fairseq](https://github.com/pytorch/fairseq) (for training from scratch)
* [Hugging Face](https://huggingface.co/) (for pretrained model)

## [Pretrained model](https://huggingface.co/Helsinki-NLP/opus-mt-en-zls)

The pretrained model can be evaluated using [translate_pretrained.py](https://github.com/bounesh/NLP_project_2021/blob/main/translate_pretrained.py).

## Datasets used for training the general model

* [MultiCCAligned](https://opus.nlpl.eu/MultiCCAligned-v1.php) 
* [WikiMatrix](https://opus.nlpl.eu/WikiMatrix-v1.php)
* [wikimedia](https://opus.nlpl.eu/wikimedia-v20210402.php)
* [OpenSubtitles](https://opus.nlpl.eu/OpenSubtitles-v2018.php)
* [DGT](https://opus.nlpl.eu/DGT-v2019.php) 
* [XLEnt](https://opus.nlpl.eu/XLEnt-v1.php)
* [TildeMODEL](https://opus.nlpl.eu/TildeMODEL-v2018.php)
* [ParaCrawl](https://opus.nlpl.eu/ParaCrawl-v7.1.php)
* [CCAligned](https://opus.nlpl.eu/CCAligned-v1.php) 
* [Europarl](https://opus.nlpl.eu/Europarl.php)

## Train transformer model with data augmentation on [general datasets](#datasets-used-for-training-the-general-model)

```bash
cd fairseq_extension
pip install -r requirements
pip install --editable ./
cd 'bash scripts'
bash preprocessing.sh # downloads the datasets, preprocesses them (bpe tokenization, binarization, ...) and splits them into train & valid (random 0.0002%) 
bash train.sh # trains the model on fairseq with cut off augmentation
```
