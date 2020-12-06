#*********************************
# Translate input document from source language 
#  to target language using Bing API via translators-api.
'''
Call:
    $ python3 translate.py <in_doc> <out_doc> <source_lang> <target_lang>

Where:
    <in_doc> is the input document to be translated
    <out_doc> is the output document to contain translated text
    <source_lang> language in_doc is written in
    <target_lang> translate to this language

Using translate-api
    https://pypi.org/project/translate-api/

'''
#*********************************

# Imports
import translators as ts
import sys

# Get cmd args
in_doc = sys.argv[1]
out_doc = sys.argv[2]
from_lang = sys.argv[3]
to_lang = sys.argv[4]
#print(' Input document: {}'.format(in_doc))
#print(' Translating from {} to {}.'.format(from_lang, to_lang))

# File setup
in_file = open(in_doc, 'r')
in_lines = in_file.readlines()

out_file = open(out_doc, 'w') # write translated contents to this file

# Execute translation procedure
for line in in_lines:
    translated_line = ts.bing(line, from_language=from_lang, to_language=to_lang)
    out_file.write(translated_line) # write line

'''
# Test call
text = 'I like to eat pineapples and I am from Tijuana!'
# Bing seems to work well
new_text = ts.bing(text, from_language='en', to_language='fr')
# Google has some network issue
print(ts.google(text, from_language='en', to_language='fr'))
print(new_text)
'''

# Close files
in_file.close()
out_file.close()

#print(' Done translating from {} to {}.'.format(from_lang, to_lang))
