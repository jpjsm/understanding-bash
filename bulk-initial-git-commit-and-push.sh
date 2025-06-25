# This script requires GitHub CLI
# See https://github.com/cli/cli/blob/trunk/docs/install_linux.md


export GITHUBFOLDER="/repos/jpjsm@github"

pushd $GITHUBFOLDER > /dev/null
echo "Starting at: $PWD"
for d in "$GITHUBFOLDER"/*
do  
  if [ -d "$d" ]; then
    export REPONAME=$d
    echo "Processing: $REPONAME"
    git config --global --add safe.directory $REPONAME
    pushd $REPONAME > /dev/null
    echo "Inside: $PWD"
    echo "# $REPONAME" > README.md
    git add -A
    git commit -m"Bulk update of changes"
    git push || echo "Failed to push changes for $REPONAME" >> /tmp/bulk-git-commit-errors.log

    popd > /dev/null
    # echo "Back to    : $PWD"
  fi
done
popd > /dev/null

echo "Done!"