from transformers import pipeline
import time
import numpy as np

#evaluation_data_prefix = 'fairseq_extension/data/translated-ted/valid'
#translation_prefix = "fairseq_extension/data/translated-ted/translated-pretrained"
evaluation_data_prefix = 'fairseq_extension/data/asistent-testset/asistent_testset'
translation_prefix = "fairseq_extension/data/translated-asistent/translated-pretrained"

translator = pipeline("translation_en_to_sl", model='Helsinki-NLP/opus-mt-en-zls')
with open(evaluation_data_prefix + ".en", "r", encoding="utf-8") as f1:
    with open(translation_prefix + ".en-sl.sl", "w", encoding="utf-8") as f2:
        for row in f1:
            translation = translator(">>slv<< " + row)
            f2.write(translation[0]['translation_text'] + "\n")