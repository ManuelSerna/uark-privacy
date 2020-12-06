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
#   1. TODO: Feed input French doc to machine translator (FR -> EN)
#   2. Feed EN doc to Parhoice
#   3. TODO: Feed transformed file from Parchoice to machine translator (EN -> FR)
#   4. TODO: Compute METEOR score between original <in_doc> and final French result file
#*********************************

echo
echo "_______________________________________________"
echo "Running French Parchoice obsfuscation pipeline."
echo "_______________________________________________"
echo



# Init
p_dir="parchoice-master/" # parchoice code directory name

in_doc=$1
if [ -z "$in_doc" ]
then
    echo "  Error: input document not specified."
    exit 1
fi



# 1. Translate French <in_doc> to English
echo "_______________________________________________"
echo "TODO: Translate French document to English."
echo "_______________________________________________"
#TODO
echo



# 2. Feed intermediate English doc to Parchoice
# NOTE i: execution based on 'Running a custom experiment' section in Parchoice readme
# NOTE ii: did not use training corpus, and thus getting random transformations
echo "_______________________________________________"
echo "Using Parchoice to obsfucate translated document."
echo "_______________________________________________"
echo " Activating parchoice Anaconda environment."
conda activate parchoice
python parchoice-master/style_transfer/main.py --src $in_doc --use_ppdb --use_wordnet --use_typos --spell_check
conda deactivate
echo " Deactivated parchoice Anaconda environment."
echo " Retrieving obsfucated document..."
cp parchoice-master/results/alice_test_transf_ppdb_wn_typos.txt ./obsfucated.txt
echo " Retrieved document."
echo



# 3. Translate English Parchoice output file back to French
echo "_______________________________________________"
echo "TODO: Translate English document to French."
echo "_______________________________________________"
#TODO
echo



# 4. Perform automated evaluation of transformed result document (French)
echo "TODO: Perform automated evaluation of final document."
#TODO
echo



echo "Done with custom pipeline."
