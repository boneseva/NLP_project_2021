import random, sys
import argparse

def split(lang, dataset, valid_len):
    if dataset == 'general':
        tmp="data/datasets/tmp/"
    elif dataset == 'ted':
        tmp="data/datasets-ted/tmp/"

    sl_unique = []
    en_unique = []

    print("removing duplicates...")
    with open(tmp+"train-cleaned.tags."+lang+".tok.sl", "r", encoding="utf-8") as fsl, \
        open(tmp+"train-cleaned.tags."+lang+".tok.en", "r", encoding="utf-8") as fen:
        for rsl, ren in zip(fsl, fen):
            if "http" not in rsl and "http" not in ren and rsl not in sl_unique and ren not in en_unique:
                # remove duplicate lines (applause, etc.), and lines starting with http
                sl_unique.append(rsl)
                en_unique.append(ren)

    joined_corpora = list(zip(en_unique, sl_unique))
    random.shuffle(joined_corpora)
    en_shuffled, sl_shuffled = zip(*joined_corpora)

    print("splitting train and valid...")

    with open(tmp + "valid.sl", "w", encoding="utf-8") as fsl_valid, \
        open(tmp + "valid.en", "w", encoding="utf-8") as fen_valid, \
        open(tmp + "train.sl", "w", encoding="utf-8") as fsl_train, \
        open(tmp + "train.en", "w", encoding="utf-8") as fen_train:
        for row in sl_shuffled[:valid_len]:
            fsl_valid.write(row)
        for row in sl_shuffled[valid_len:]:
            fsl_train.write(row)
        for row in en_shuffled[:valid_len]:
            fen_valid.write(row)
        for row in en_shuffled[valid_len:]:
            fen_train.write(row)

if __name__ == "__main__":
    lang = sys.argv[1]
    dataset = sys.argv[2]
    length = int(sys.argv[3])
    split(lang,dataset,length)