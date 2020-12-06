#*********************************
# Translate input document text from French to English
'''
	Using translate-api

	https://pypi.org/project/translate-api/
'''
#*********************************

import translators as ts

text = 'I like to each pineapples and I am from Tijuana!'

# Bing seems to work well
print(ts.bing(text, from_language='en', to_language='fr'))

