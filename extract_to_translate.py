import os


def main():
    tsv = open(os.path.join('data', 'ADR_lexicon.tsv'), 'r').readlines()
    terms = []
    for line in tsv:
        l = line.split('\t')
        if len(l) > 1:
            terms.append(l[1] + '\n')
    with open(os.path.join('data', 'ADR_lexicon_terms.txt'), 'w') as f:
        f.writelines(terms)


if __name__ == '__main__':
    main()
