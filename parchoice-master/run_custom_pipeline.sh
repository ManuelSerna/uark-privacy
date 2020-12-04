#*********************************
# Custom Pipeline for obfuscating French documents
# 
# Call:
#	$ ./run_custom_pipeline.py <in_doc>
# where
#	<in_doc> is the input French document to pass through pipeline, each sentence should be a line.
#
# Pipeline:
#	1. TODO: Feed input French doc to machine translator (FR -> EN)
#	2. Feed EN doc to Parhoice
#	3. TODO: Feed transformed file from Parchoice to machine translator (EN -> FR)
#	4. TODO: Compute METEOR score between original <in_doc> and final French result file
#*********************************

echo
echo "(Note: make sure you are in parchoice environment on Anaconda)"
echo


in_doc=$1


# 1. Translate French <in_doc> to English
#TODO


# 2. Feed intermediate English doc to Parchoice
# NOTE i: execution based on 'Running a custom experiment' section in Parchoice readme
# NOTE ii: did not use training corpus, and thus getting random transformations
python style_transfer/main.py --src $in_doc --use_ppdb --use_wordnet --use_typos --spell_check


# 3. Translate English Parchoice output file back to French
#TODO


# 4. Perform automated evaluation of transformed result document (French)
#TODO


echo 
echo "Done with custom pipeline."

