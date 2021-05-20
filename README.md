# Automatic language translation NLP course 2021

## Prepare the environment
#### Prerequisites:
* Linux environment
* For Windows: you will able to run evaluation, but not preprocessing or training. Download the files by copying the link from wget into your browser. You can also download Ubuntu for Windows, if you would prefer to run scripts as you would in a Linux environment.  
* Python 3
* Clone the repository and enter the folder.

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
* Download the zip from https://drive.google.com/file/d/1ochxd0Uk52VNWjOpbXMNJtxcG7gi1Dg8/view?usp=sharing
* Unzip its contents into data/datasets
You can again prepare the data by either downloading the train and valid sets and preprocessing it:
```bash
bash scripts/download_ted_train_valid.sh
bash scripts/preprocess_ted.sh
```
or downloading the already preprocessed data:
```bash
bash scripts/download_ted_binarized.sh
```

If you didn't train the general model yourself, you can download the best epoch:
* Download the latest checkpoint from https://drive.google.com/drive/folders/1RObf3zXgZXqgzUf4EZWreblnpPr6u07x?usp=sharing
* Save it to results/general as checkpoint_best.pt

### Fine-tune a domain specific translation model on TED data

```bash
bash scripts/fine_tune.sh
```

### Evaluate

* Download all checkpoints from https://drive.google.com/drive/folders/1RObf3zXgZXqgzUf4EZWreblnpPr6u07x?usp=sharing and save them to results/general.
* Download all checkpoints from https://drive.google.com/drive/folders/1cKTtlo_TlspxBj1K9vnRLmpGjMLubSLj?usp=sharing and save them to results/ted.

* Download the binarized general validation set using:
```bash
bash scripts/download_general_binarized.sh
```
* Run translation for the general model on the general dataset:
```bash
bash scripts/translate_general.sh
```

* Download and unzip (and untar) all files from the assistant dataset (https://unilj-my.sharepoint.com/:f:/g/personal/slavkozitnik_fri1_uni-lj_si/EtOvwH2ldEdJhL9i-fMJj_kBPxzAp_6h6151GuvEsSILzw?e=TJ0a1F) into data/datasets-asistent.
* Preprocess them:
```bash
bash scripts/preprocess_asistent.sh
```
or download the preprocessed files:
```bash
bash scripts/download_asistent_binarized.sh
```
* Run translation for both models on the assistant dataset:
```bash
bash scripts/translate_asistent.sh
```

* Download the binarized domain validation set using:
```bash
bash scripts/download_ted_binarized.sh
```
* Run translation for both models on the domain dataset:
```bash
bash scripts/translate_ted.sh
```
