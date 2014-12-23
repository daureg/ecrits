#! /usr/bin/env python
# vim: set fileencoding=utf-8
"""Display statistics about sentence length."""
from operator import itemgetter
import fileinput
try:
    import sparkline
except ImportError:
    print('install https://github.com/RedKrieg/pysparklines')


def display_sentence(sentence):
    words = sentence.split()
    if len(words) <= 20:
        return sentence
    fmt = '{} […] {}'
    return fmt.format(' '.join(words[:10]), ' '.join(words[-10:]))

if __name__ == '__main__':
    # pylint: disable=C0103
    data = []
    for line in fileinput.input():
        sentence = line.strip()
        data.append((sentence, len(sentence.split())))
    data.sort(key=itemgetter(1), reverse=True)
    separated = False
    for s, l in data:
        if l < 25 and not separated:
            print(78*'-')
            separated = True
        print('{}{}'.format(str(l).ljust(5), display_sentence(s)))
    lengths = [_[1] for _ in data]
    if sparkline:
        print(sparkline.sparkify(lengths))
    import numpy as np
    print('average: {:.1f}, std: {:.1f}'.format(np.mean(lengths),
                                                np.std(lengths)))
