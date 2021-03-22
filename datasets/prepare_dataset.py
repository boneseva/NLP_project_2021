import json
import csv

data = {}
# CONAN DATASET
with open('CONAN/CONAN.json', encoding="utf8") as json_file:
    file = json.load(json_file)
    data['conan'] = []
    counter = 0
    for c in file["conan"]:
        if c['cn_id'].startswith('EN'):
            # print("ID:{}\nSpeech:{}\nType:{}\n---------------\n".format(c['cn_id'], c['hateSpeech'], c['hsType']))
            data['conan'].append({'id': 'conan_{}'.format(counter),
                                           'speech': c['hateSpeech'],
                                           'hate': 1,
                                           'additional': [c['hsType'], c['hsSubType']]})
            counter += 1

# with open('data_conan.json', 'w') as outfile:
#     json.dump(data_conan, outfile)


# ONLINE HATE SPEECH DATASETS (REDDIT AND GAB)
with open('OnlineHateSpeech/reddit.csv', encoding="utf8") as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    counter = 0
    data['reddit'] = []
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
        elif row[2] != 'n/a':
            convo = row[1].split('\n')
            for i, c in enumerate(convo):
                if str(i + 1) in row[2]:
                    data['reddit'].append({'id': 'reddit_{}'.format(counter),
                                                    'speech': c,
                                                    'hate': 1})
                    # print("ID:{}\nTEXT:{}\nHS_idx:{}\n-------------\n".format(line_count, row[1], row[2]))
                    # print(f'\t{row[0]} works in the {row[1]} department, and was born in {row[2]}.')
                else:
                    data['reddit'].append({'id': 'reddit_{}'.format(counter),
                                                    'speech': c,
                                                    'hate': 0})
                counter += 1
        else:
            convo = row[1].split('\n')
            for c in convo:
                data['reddit'].append({'id': 'reddit_{}'.format(counter),
                                                'speech': c,
                                                'hate': 0})
                counter += 1
        line_count += 1
    print(f'Processed {line_count} lines.')

# with open('data_reddit.json', 'w') as outfile:
#     json.dump(data_reddit, outfile)

with open('OnlineHateSpeech/gab.csv', encoding="utf8") as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    counter = 0
    data['gab'] = []
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
        elif row[2] != 'n/a':
            convo = row[1].split('\n')
            for i, c in enumerate(convo):
                if str(i + 1) in row[2]:
                    data['gab'].append({'id': 'gab_{}'.format(counter),
                                                 'speech': c,
                                                 'hate': 1})
                    # print("ID:{}\nTEXT:{}\nHS_idx:{}\n-------------\n".format(line_count, row[1], row[2]))
                    # print(f'\t{row[0]} works in the {row[1]} department, and was born in {row[2]}.')
                else:
                    data['gab'].append({'id': 'gab_{}'.format(counter),
                                                 'speech': c,
                                                 'hate': 0})
                counter += 1
        else:
            convo = row[1].split('\n')
            for c in convo:
                data['gab'].append({'id': 'gab_{}'.format(counter),
                                             'speech': c,
                                             'hate': 0})
                counter += 1
        line_count += 1
    print(f'Processed {line_count} lines.')

# with open('data_gab.json', 'w') as outfile:
#     json.dump(data_gab, outfile)

with open('data.json', 'w') as outfile:
    json.dump(data, outfile)