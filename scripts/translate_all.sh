#!/bin/bash

bash scripts/download_general_binarized.sh
bash scripts/translate_general.sh

bash scripts/download_asistent_binarized.sh
bash scripts/translate_asistent.sh

bash scripts/download_ted_binarized.sh
bash scripts/translate_ted.sh

python3 clean_trained.py
python3 translate_pretrained.py