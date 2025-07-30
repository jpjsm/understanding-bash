# This script requires GitHub CLI
# See https://github.com/cli/cli/blob/trunk/docs/install_linux.md

export today=$(date)
echo "================ Starting Bulk Update GIT Commit ================" | tee -a /tmp/bulk-git-commit-errors.log
echo "Job started: $today" | tee -a /tmp/bulk-git-commit-errors.log

export GITHUBFOLDER="/repos/jpjsm@github"

pushd $GITHUBFOLDER > /dev/null
echo "Starting at: $PWD" | tee -a /tmp/bulk-git-commit-errors.log
for d in "$GITHUBFOLDER"/*
do  
  if [ -d "$d" ]; then
    export REPONAME=$d
    echo "Processing: $REPONAME" | tee -a /tmp/bulk-git-commit-errors.log
    git config --global --add safe.directory $REPONAME
    pushd $REPONAME > /dev/null
    echo "Inside: $PWD" | tee -a /tmp/bulk-git-commit-errors.log    
    git add -A
    git commit -m"Bulk update of changes"
    git pull
    git push 
    if [ $? == 0 ]; then
      echo "[info]  Push succeeded for $REPONAME"  | tee -a /tmp/bulk-git-commit-errors.log
    else
      echo "[ERROR] Failed to push changes for $REPONAME"  | tee -a /tmp/bulk-git-commit-errors.log
    fi

    popd > /dev/null
    # echo "Back to    : $PWD"
  fi
done
popd > /dev/null

export today=$(date)
echo "Job complete: $today" | tee -a /tmp/bulk-git-commit-errors.log
echo "================ Finished Bulk Update GIT Commit ================" | tee -a /tmp/bulk-git-commit-errors.log
echo "Done, job complete"