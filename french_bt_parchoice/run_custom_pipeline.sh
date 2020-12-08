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
touch $fr2en_doc
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

# use classifier and remember to use training sets (source and target style corpora), which may be left for future experiments.
#python parchoice-master/style_transfer/main.py --src $fr2en_doc --use_ppdb --use_wordnet --use_typos --spell_check 

conda deactivate
echo " Deactivated parchoice Anaconda environment."
echo " Retrieving obsfucated document..."
obfuscated="obfuscated.txt" # name of English obsfucated document
#cp "parchoice-master/results/alice_test_transf_ppdb_wn_typos.txt" "./$obfuscated"
cp "results/alice_test_transf_ppdb_wn_typos.txt" "./$obfuscated"

if [[ -f "$obfuscated" ]]
then
    echo " Retrieved document."
else
    echo " ! ERROR: document not retrieved."
    exit
fi

# Compute meteor score for English transformation
echo
echo "Calculating METEOR score of English documents post and pre-obfuscation."
python score/eng_score.py $fr2en_doc $obfuscated
echo "_______________________________________________"
echo



#=================================
# 3. Translate English Parchoice output file back to French
#=================================
echo "_______________________________________________"
echo " Translating English document to French."
en2fr_doc="result_$in_doc" # finally, store final obsfucated French text
#python3 translators/translate.py $in_doc $fr2en_doc 'fr' 'en'
#  $ python3 translate.py <in_doc> <out_doc> <source_lang> <target_lang>
python3 translators/translate.py $obfuscated $en2fr_doc 'en' 'fr'
echo
echo "Final output document $en2fr_doc successfully created!"
echo "_______________________________________________"
echo



# Remove intermediate files
rm $fr2en_doc
rm $obfuscated

echo "Done with custom pipeline."
