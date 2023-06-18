#!/bin/bash

# Get a list of all submodules
submodules=$(git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

# Deinit and remove each submodule
for submodule in $submodules
do
  git submodule deinit -f -- $submodule
  git rm -f $submodule
done

# Add the files back to the repository and commit
git add .
git commit -m "Converted submodules to regular directories"

# Push the changes
git push

