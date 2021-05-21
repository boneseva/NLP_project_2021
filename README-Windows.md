# Automatic language translation NLP course 2021

Because this code was prepared for Linux environments, we only adapted evaluation of already translated texts for Windows environments. 

## Prepare the environment
#### Prerequisites:
* Windows environment
* Python 3
* Clone the repository and enter the folder.

```bash
pip install -r requirements.txt
pip install --editable fairseq_extension
```

### Evaluate

* Download the translated files from https://drive.google.com/file/d/10q0vKenMVS5cxNHhXYnNaz9AUjyiIQRt/view?usp=sharing and unzip it into the folder data. 
* Download and unzip (and untar) all files from the assistant dataset (https://unilj-my.sharepoint.com/:f:/g/personal/slavkozitnik_fri1_uni-lj_si/EtOvwH2ldEdJhL9i-fMJj_kBPxzAp_6h6151GuvEsSILzw?e=TJ0a1F) into data/asistent-testset.
* The folder structure should look like this:

📦NLP_project_2021

 ┣ 📂fairseq_extension
 
 ┣ 📂scripts
 
 ┣ 📂data
 
 ┃ ┣ 📂translated-asistent
 
 ┃ ┣ 📂translated-general
 
 ┃ ┣ 📂translated-ted
 
 ┃ ┣ 📂asistent-testset
 

You can then evaluate and calculate the needed metrics for each model and dataset using the following command: 
```bash
python3 evaluate.py <model> <dataset>
```
The model can be one of pretrained, general, domain, while the dataset can be asistent, general or ted. You can also omit the dataset, in which case the script will evaluate the model on all the datasets.
