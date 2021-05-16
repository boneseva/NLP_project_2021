
file_to_clean = "fairseq_extension/data/translated-general/translated-general.txt"
clean_file = "fairseq_extension/data/translated-general/translated-general-clean.txt"

current = None

with open(file_to_clean, 'r', encoding='utf-8') as f1, \
    open(clean_file, 'w', encoding='utf-8') as f2, \
    open(clean_file_valid, 'w', encoding='utf-8') as f3, \
    open(clean_file_translation, 'w', encoding='utf-8') as f4:
    for row in f1:
        if (current is None or current == "H") and row.startswith("S-"):
            replaced = row.replace("&apos;", "'").replace("@-@", "-").replace("&quot;", '"')
            f2.write(replaced)
            current = "S"
        elif current == "S" and row.startswith("T-"):
            replaced = row.replace("&apos;", "'").replace("@-@", "-").replace("&quot;", '"')
            f2.write(replaced)
            f3.write(" ".join(row.split("\t")[1:]))
            current = "T"
        elif current == "T" and row.startswith("H-"):
            replaced = row.replace("&apos;", "'").replace("@-@", "-").replace("&quot;", '"')
            f2.write(replaced)
            f4.write(" ".join((" ".join(row.split("\t")[1:])).split(" ")[1:]))
            current = "H"
