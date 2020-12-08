#*********************************
# Calculate METEOR score to compute the similarity of
#  original document and obfuscated document (English documents).
#
# Call:
#   python3 eng_score.py <doc1> <doc2>
#
# Output:
#   This program only outputs meteor score between reference and hypothesis documents.
# Unfortunately, I could not compute the meteor score between French documents.
#*********************************

# Imports
import nltk
from nltk.translate.meteor_score import single_meteor_score
import sys

print(sys.argv[0])
print(sys.argv[1])
print(sys.argv[2])

doc1 = sys.argv[1]
doc2 = sys.argv[2]

print('Calculating METEOR score between documents {} and {}.'.format(doc1, doc2))

# Calculate and print score
r = open(doc1, 'r') # reference (pre-obfuscated)
rlines = r.readlines()

h = open(doc2, 'r') # hypothesis (post-obfuscated)
hlines = h.readlines()

score = 0.0
max_score = 0.0
n = len(rlines)
for i in range(n):
    ri = rlines[i]
    hi = hlines[i]
    score += round(single_meteor_score(ri, hi), 4)
    max_score += 1.0

print('The overall METEOR score is: {} out of max possible score of {}'.format(score, max_score))
