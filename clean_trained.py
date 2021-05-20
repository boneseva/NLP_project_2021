
def clean_row(row):
    return row.replace("&apos;", "'")\
        .replace("@-@", "-")\
        .replace("&quot;", '"')\
        .replace(" ,", ",")\
        .replace(" .", ".")\
        .replace(" ?", "?")\
        .replace(" !", "!")

def parse_file(dataset, results_folder, model):
    try:
        if dataset == 'asistent':
            file_to_clean = results_folder + "generate-train.txt"
        else:
            file_to_clean = results_folder + "generate-valid.txt"
        clean_file_valid = results_folder + "valid.sl"
        clean_file_translation = results_folder + "translated-" + model + ".en-sl.sl"

        print("Parsing", file_to_clean)

        current = None
        ordered_rows = {}
        with open(file_to_clean, 'r', encoding='utf-8') as f, \
                open(clean_file_valid, 'w', encoding='utf-8') as f_valid, \
                open(clean_file_translation, 'w', encoding='utf-8') as f_translation:
            for row in f:
                if (current is None or current == "H") and row.startswith("S-"):
                    current = "S"
                elif current == "S" and row.startswith("T-"):
                    replaced = clean_row(row)
                    index = int(replaced.split("\t")[0].split("-")[1])
                    ordered_rows[index] = {}
                    ordered_rows[index]['valid'] = " ".join(replaced.split("\t")[1:])
                    f_valid.write(" ".join(replaced.split("\t")[1:]))
                    current = "T"
                elif current == "T" and row.startswith("H-"):
                    replaced = clean_row(row)
                    index = int(replaced.split("\t")[0].split("-")[1])
                    ordered_rows[index]['translated'] = " ".join((" ".join(replaced.split("\t")[1:])).split(" ")[1:])
                    f_translation.write(" ".join((" ".join(replaced.split("\t")[1:])).split(" ")[1:]))
                    current = "H"

        if dataset == 'ted':
            clean_file_first60 = results_folder + "translated-" + model + "-for-manual-evaluation.en-sl.sl"
            with open(clean_file_first60, "w", encoding='utf-8') as f:
                for index in sorted(list(ordered_rows.keys())):
                    f.write(ordered_rows[index]['translated'])
    except Exception:
        print("Couldn't clean file", file_to_clean)

if __name__ == '__main__':
    for dataset in ['general', 'asistent', 'ted']:

        base_folder = "fairseq_extension/data/translated-" + dataset + "/"

        for i in range(1, 9):
            results_folder = base_folder + "results" + str(i) + "/"
            parse_file(dataset, results_folder, "general")

        if dataset != 'general':
            # there is no ted_conf evaluation
            for i in range(1, 4):
                results_folder = base_folder + "results_ted_conf" + str(i) + "/"
                parse_file(dataset, results_folder, "ted")