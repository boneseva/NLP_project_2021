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
```bash scripts/download_datasets.sh
bash scripts/preprocess_general.sh
```
or downloading the already preprocessed data:
```bash
wget download binarized corpus into data/data-binarized
```

### Train transformer model with data augmentation on general datasets

```bash
bash scripts/train.sh
```

## Fine-tune the general model on TED data

### Prepare the data
You can again prepare the data by either downloading the original data and preprocessing it:
```bash
wget download TED corpus into data/data-original-ted
bash scripts/preprocess_ted.sh
```
or downloading the already preprocessed data:
```bash
wget download binarized corpus into data/data-binarized-ted
```

If you didn't train the general model yourself, you can download the best epoch:
```bash
wget download best epoch as results/general/checkpoint_best.pt
```

### Fine-tune a domain specific translation model on TED data

```bash
bash scripts/fine_tune.sh
```

### Evaluate
