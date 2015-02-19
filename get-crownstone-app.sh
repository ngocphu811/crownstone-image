#!/bin/bash

if [ ! $1 ]; then
	echo "Usage: $0 your_github_username"
	exit 1
fi

if [ -e crownstone-app ]; then
	echo "Dir 'crownstone-app' already exists! Use rm -rf crownstone-app to remove it."
	exit 1
fi


git clone https://github.com/${1}/crownstone-app
result=$?
if [ $result -ne 0 ]; then
	echo "ERROR: Could not clone https://github.com/${1}/crownstone-app"
	echo "Make sure you filled in the correct username and that you are connected to the internet."
	echo "Also make sure you forked the repository: https://github.com/dobots/crownstone-app/fork"
	exit 1
fi

cd crownstone-app
git remote add upstream https://github.com/dobots/crownstone-app
#git branch -u upstream/master

echo "Done!"
