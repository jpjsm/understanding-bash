#!/bin/bash
#
# this script enables jp and jp_remote
# access to the following folders:
# - /repos
# - /learning
# - /nltk_data
# - /models
# - /medusa
# - /sample-data
# 
export FOLDERS=(repos learning nltk_data models medusa sample_data)
sudo apt-get update

for f in "${FOLDERS[@]}"; do
  echo "Enabling access for $f"

  sudo chown -R :developers /mnt/data/$f
  sudo chown -R :developers /$f

  sudo chmod -R 775 /mnt/data/$f
  sudo chmod -R 775 /$f

done