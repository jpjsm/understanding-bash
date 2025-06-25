
# Add all requirement files to conda environment
conda activate <environment>

for filename in $(find . -iname "*requirements*txt"); do pip install -r $filename; done
