# Automatic language translation NLP course 2021

## Prepare the environment
#### Prerequisites:
* Python 3

```bash
python3 -m venv myvenv
source myvenv/bin/activate
pip install -r requirements
pip install --editable fairseq_extension
```
## Train general model

### Prepare the data
You can prepare the data by either downloading the original data and preprocessing it (will take a long time):
```bash
wget download original corpus into data/data-original
bash bash_scripts/preprocess_general.sh
```
or downloading the already preprocessed data:
```bash
wget download binarized corpus into data/data-binarized
```

### Train transformer model with data augmentation on general datasets

```bash
bash bash_scripts/train.sh
```

## Fine-tune the general model on TED data

### Prepare the data
You can again prepare the data by either downloading the original data and preprocessing it:
```bash
wget download TED corpus into data/data-original-ted
bash bash_scripts/preprocess_ted.sh
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
bash bash_scripts/fine_tune.sh
```

### Evaluate
