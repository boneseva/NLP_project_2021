from transformers import pipeline
import time
import numpy as np

translator = pipeline("translation_en_to_sl", model='Helsinki-NLP/opus-mt-en-zls')

for evaluation_data_prefix, translation_prefix in zip(['data/datasets-asistent/asistent_testset', 'data/data-original-ted/valid'],
                                                    ["data/translated-asistent/translated-pretrained", "data/translated-ted/translated-pretrained"]):
    with open(evaluation_data_prefix + ".en", "r", encoding="utf-8") as f1:
        with open(translation_prefix + ".en-sl.sl", "w", encoding="utf-8") as f2:
            for row in f1:
                translation = translator(">>slv<< " + row)
                f2.write(translation[0]['translation_text'] + "\n")