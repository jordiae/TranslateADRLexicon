import os


def main():
    tsv = open(os.path.join('data', 'ADR_lexicon.tsv'), 'r').readlines()
    pre = []
    terms = []
    for line in tsv:
        l = line.split('\t')
        if len(l) > 1:
            terms.append(l)
        else:
            pre.append(line)
    translated = open(os.path.join('data', 'ADR_lexicon_terms.txt.tok.translated'), 'r').readlines()
    new = pre
    for orig, translated in zip(terms, translated):
        new.append(orig[0] + '\t' + ''.join(translated[:-1].split()).replace('\u2581', ' ') + '\t' + orig[2])
    with open(os.path.join('data', 'ADR_lexicon_translated.tsv'), 'w') as f:
        f.writelines(new)


if __name__ == '__main__':
    main()
