# Automatic language translation NLP course 2021

## Prepare the environment
#### Prerequisites:
* Linux environment (for Windows: go to [README for Windows](README-Windows.md))
* Python 3


1) Clone this repository and enter the folder.
2) Prepare virtual environment:
 ```bash
 python3 -m venv myvenv
 source myvenv/bin/activate
 pip install -r requirements.txt
 pip install --editable fairseq_extension
 ```
## Train general model

### Prepare the data
You can prepare the data by either downloading the original data and preprocessing it (it will take a long time and you will not get the same train and valid sets, as they are chosen at random):

 ```bash
 bash scripts/download_datasets.sh
 bash scripts/preprocess_general.sh
 ```
or downloading the already preprocessed data:

 ```bash
 bash scripts/download_general_binarized.sh
 ```

### Train transformer model with data augmentation on general datasets

 ```bash
 bash scripts/train.sh
 ```

## Fine-tune the general model on TED data

### Prepare the data

[comment]: <> (* Download the zip from https://drive.google.com/file/d/1ochxd0Uk52VNWjOpbXMNJtxcG7gi1Dg8/view?usp=sharing)

[comment]: <> (* Unzip its contents into data/datasets)
You can again prepare the data by either downloading the train and valid sets and preprocessing it (you need to have dictionaries (dict.en.txt & dict.sl.txt) from the previous step in data/data-binarized folder):

 ```bash
 bash scripts/download_ted_train_valid.sh
 bash scripts/preprocess_ted.sh
 ```
or downloading the already preprocessed data:

 ```bash
 bash scripts/download_ted_binarized.sh
 ```

If you didn't train the general model yourself, you can download the best epoch:

 ```bash
 bash scripts/download_epoch.sh
 ```

[comment]: <> (* Download the latest checkpoint from https://drive.google.com/drive/folders/1RObf3zXgZXqgzUf4EZWreblnpPr6u07x?usp=sharing)

[comment]: <> (* Save it to results/general as checkpoint_best.pt)

### Fine-tune a domain specific translation model on TED data

 ```bash
 bash scripts/fine_tune.sh
 ```

## Evaluate

1) Download all checkpoints from https://drive.google.com/drive/folders/1RObf3zXgZXqgzUf4EZWreblnpPr6u07x?usp=sharing and save them to results/general.
2) Download all checkpoints from https://drive.google.com/drive/folders/1cKTtlo_TlspxBj1K9vnRLmpGjMLubSLj?usp=sharing and save them to results/ted.

###TL;DR I just want to run it:
 ```bash
 bash scripts/translate_all.sh
 python3 evaluate.py <model> <dataset>
 ```
The model can be one of pretrained, general, domain, while the dataset can be asistent, general or ted. You can also omit the dataset, in which case the script will evaluate the model on all the datasets.


###The longer way:

####General validation set (translate with general model):
1) Download the binarized general validation set using:
 ```bash
 bash scripts/download_general_binarized.sh
 ```
2) Run translation for the general model on the general dataset:
 ```bash
 bash scripts/translate_general.sh
 ```

####Assistant validation set (translate with general and domain model):
1) Download and unzip (and untar) all files from the assistant dataset (https://unilj-my.sharepoint.com/:f:/g/personal/slavkozitnik_fri1_uni-lj_si/EtOvwH2ldEdJhL9i-fMJj_kBPxzAp_6h6151GuvEsSILzw?e=TJ0a1F) into data/asistent-testset and
preprocess them:
 ```bash
 bash scripts/preprocess_asistent.sh
 ```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or download the preprocessed files:

 ```bash
 bash scripts/download_asistent_binarized.sh
 ```

2) Run translation for both models on the assistant dataset:
 ```bash
 bash scripts/translate_asistent.sh
 ```

####Domain validation set (translate with general and domain model):

1) If you haven't preprocessed/downloaded TED validation sets for fine-tuning, download binarized files:
 ```bash
 bash scripts/download_ted_binarized.sh
 ```
2) Run translation for both models on the domain dataset:
 ```bash
 bash scripts/translate_ted.sh
 ```

[comment]: <> (Then, clean up the files using:)

[comment]: <> (```bash)

[comment]: <> (python3 clean_trained.py)

[comment]: <> (```)

#### Assistant and domain validation set (translate with pretrained model):
```bash
python3 translate_pretrained.py
```

[comment]: <> (To translate the assistant and domain validation sets with the pretrained model, run:)
    

#### Calculate metrics
1) Clean up the files produced by evaluation:
 ```bash
 python3 clean_trained.py
 ```
2) Calculate metrics (the model can be one of pretrained, general, domain, while the dataset can be asistent, general or ted. You can also omit the dataset, in which case the script will evaluate the model on all the datasets.)
 ```bash
 python3 evaluate.py <model> <dataset>
 ```
