import nltk
from jiwer import wer
import sys

evaluation_data = {'ted': 'fairseq_extension/data/translated-ted/valid',
         'asistent': 'fairseq_extension/data/asistent-testset/asistent_testset',
         'general': 'fairseq_extension/data/translated-general/valid'}

base_translation_path = "fairseq_extension/data/translated-"

def evaluate_one(translation_path, valid_path):
    hypotheses = []
    references = []
    list_of_references = []
    joined_references = []
    joined_hypotheses = []
    joined_list_of_references = []

    lang_pair = 'en-sl'
    with open(valid_path + '.' + lang_pair.split('-')[1], 'r',
              encoding='utf-8') as references_file:
        with open(translation_path + '.' + lang_pair + '.' + lang_pair.split('-')[1], 'r',
                  encoding='utf-8') as hypotheses_file:
            for r, h in zip(references_file, hypotheses_file):
                list_of_references.append([r[:-1].split()])
                references.append(r[:-1].split())
                hypotheses.append(h[:-1].split())
                joined_references.append(r[:-1])
                joined_hypotheses.append(h[:-1])
                joined_list_of_references.append([r[:-1]])

    print('BLEU:', nltk.translate.bleu_score.corpus_bleu(list_of_references, hypotheses))
    print("CHRF:", nltk.translate.chrf_score.corpus_chrf(references, hypotheses))
    print("GLEU:", nltk.translate.gleu_score.corpus_gleu(list_of_references, hypotheses))

    meteor_score = sum([nltk.translate.meteor_score.meteor_score(r, jh) for r, jh in
                        zip(joined_list_of_references, joined_hypotheses)]) / len(joined_hypotheses)
    print("METEOR:", meteor_score)
    print("NIST:", nltk.translate.nist_score.corpus_nist(list_of_references, hypotheses))
    try:
        print("RIBES:", nltk.translate.ribes_score.corpus_ribes(list_of_references, hypotheses))
    except ZeroDivisionError:
        print("RIBES undefined")
    print("WER:", wer(joined_references, joined_hypotheses))

def evaluate_dataset(model, dataset):
    print("Evaluating dataset", dataset)

    translation_path = base_translation_path + dataset
    if model == 'pretrained':
        evaluate_one(translation_path + '/translated-pretrained', evaluation_data[dataset])
    elif model == 'general':
        for i in range(1, 9):
            print("Evaluating epoch", i)
            results_path = translation_path + '/results' + str(i)
            evaluate_one(results_path + "/translated-general", results_path + "/valid")
    elif model == 'domain':
        for i in range(1, 4):
            print("Evaluating configuration", i)
            results_path = translation_path + '/results_ted_conf' + str(i)
            evaluate_one(results_path + "/translated-ted", results_path + "/valid")



if __name__ == '__main__':
    model = sys.argv[1]
    print("Evaluating model", model)
    if len(sys.argv) > 2:
        evaluate_dataset(sys.argv[2])
    else:
        if model == 'pretrained' or model == 'domain':
            for dataset in ['asistent', 'ted']:
                evaluate_dataset(model, dataset)
        elif model == 'general':
            for dataset in evaluation_data:
                evaluate_dataset(model, dataset)





