import nltk

#evaluation_data_prefix = 'fairseq_extension/data/translated-ted/valid'
#translation_prefix = "fairseq_extension/data/translated-ted/translated-pretrained"
evaluation_data_prefix = 'fairseq_extension/data/asistent-testset/asistent_testset'
translation_prefix = "fairseq_extension/data/asistent-testset/translated-pretrained"

hypotheses = []
references = []
list_of_references = []
joined_hypotheses = []
joined_list_of_references = []

for lang_pair in ['en-sl', 'sl-en']:
    print('Evaluating', lang_pair)
    with open(evaluation_data_prefix + '.' + lang_pair.split('-')[1], 'r', encoding='utf-8') as references_file:
        with open(translation_prefix + '.' + lang_pair + '.' + lang_pair.split('-')[1], 'r', encoding='utf-8') as hypotheses_file:
            for r, h in zip(references_file, hypotheses_file):
                list_of_references.append([r.split()])
                references.append(r.split())
                hypotheses.append(h.split())
                joined_hypotheses.append(h)
                joined_list_of_references.append([r])

    print('BLEU:', nltk.translate.bleu_score.corpus_bleu(list_of_references, hypotheses))
    print("CHRF:", nltk.translate.chrf_score.corpus_chrf(references, hypotheses))
    print("GLEU:", nltk.translate.gleu_score.corpus_gleu(list_of_references, hypotheses))

    meteor_score = sum([nltk.translate.meteor_score.meteor_score(r, jh) for r, jh in zip(joined_list_of_references, joined_hypotheses)]) / len(joined_hypotheses)
    print("METEOR:", meteor_score)
    print("NIST:", nltk.translate.nist_score.corpus_nist(list_of_references, hypotheses))
    try:
        print("RIBES:", nltk.translate.ribes_score.corpus_ribes(list_of_references, hypotheses))
    except ZeroDivisionError:
        print("RIBES undefined")