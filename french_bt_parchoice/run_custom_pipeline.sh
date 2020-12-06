#*********************************
# Custom Pipeline for obfuscating French documents
# 
# Call:
#   $ bash -i run_custom_pipeline.sh <in_doc>
#
# NOTE: use "bash -i" in order to invoke interactive environment.
#
# where...
#   <in_doc> is the input French document to pass through pipeline, each sentence should be a line. Same directory as this script.
#
# Pipeline:
#   1. Feed input French doc to machine translator (FR -> EN)
#   2. Feed EN doc to Parhoice
#   3. Feed transformed file from Parchoice to machine translator (EN -> FR)
#   4. TODO: Compute METEOR score between original <in_doc> and final French result file
#*********************************

echo
echo " Running French Parchoice obsfuscation pipeline."
echo



# Init
p_dir="parchoice-master/" # parchoice code directory name

in_doc=$1
if [ -z "$in_doc" ]
then
    echo "  Error: input document not specified."
    exit 1
fi



#=================================
# 1. Translate French <in_doc> to English
#=================================
echo "_______________________________________________"
echo " Translating French document to English."
fr2en_doc="fr2en.txt" # will contain translated (now English) text
python3 translators/translate.py $in_doc $fr2en_doc 'fr' 'en'
echo "_______________________________________________"
echo



#=================================
# 2. Feed intermediate English doc to Parchoice
#=================================
# NOTE i: execution based on 'Running a custom experiment' section in Parchoice readme
# NOTE ii: did not use training corpus, and thus getting random transformations
echo "_______________________________________________"
echo " Using Parchoice to obsfucate translated document."
echo
echo " Activating parchoice Anaconda environment."
conda activate parchoice
python parchoice-master/style_transfer/main.py --src $fr2en_doc --use_ppdb --use_wordnet --use_typos --spell_check
#python parchoice-master/style_transfer/main.py --src $fr2en_doc --use_ppdb --use_wordnet --use_typos --spell_check # use classifier
conda deactivate
echo " Deactivated parchoice Anaconda environment."
echo " Retrieving obsfucated document..."
cp parchoice-master/results/alice_test_transf_ppdb_wn_typos.txt ./obsfucated.txt
echo " Retrieved document."
$obfuscated="obsfucated.txt" # name of English obsfucated document
echo "_______________________________________________"
echo



#=================================
# 3. Translate English Parchoice output file back to French
#=================================
echo "_______________________________________________"
echo " Translating English document to French."
en2fr_doc="result.txt" # finally, store final obsfucated French text
#python3 translators/translate.py $in_doc $fr2en_doc 'fr' 'en'
#  $ python3 translate.py <in_doc> <out_doc> <source_lang> <target_lang>
python3 translators/translate.py $obfuscated $en2fr_doc 'en' 'fr'
echo
echo "Final output document $en2fr_doc successfully created!"
echo "_______________________________________________"
echo



#=================================
# 4. Perform automated evaluation of transformed result document (French)
#=================================
echo "TODO: Perform automated evaluation of final document."
#TODO
echo

# Remove intermediate files
rm $fr2en_doc
rm $obfuscated

echo "Done with custom pipeline."
