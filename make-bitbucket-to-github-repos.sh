# This script requires GitHub CLI
# See https://github.com/cli/cli/blob/trunk/docs/install_linux.md


export GITHUBFOLDER="/repos/jpjsm@github/"
export UNDERSTANDING="/repos/understanding/*"

# See https://github.com/settings/tokens to create a token
export GITHUB_TOKEN="add-your-token-here"
gh auth login -h github.com

pushd $GITHUBFOLDER > /dev/null
# echo "Starting at: $PWD"
for d in $UNDERSTANDING
do  
  export REPONAME=${d##*/}

  mkdir -p $GITHUBFOLDER/$REPONAME

  pushd $REPONAME > /dev/null
  echo "Inside: $PWD"
  echo "# $REPONAME" > README.md
  git init
  git add .
  git commit -m"Initial commit"
  gh repo create $REPONAME --source=. --public --push

  popd > /dev/null
  # echo "Back to    : $PWD"
done
popd > /dev/null
gh auth logout