#!/usr/bin/env bash


package_name=$1

if [ -z "${package_name}" ]; then
	echo "must pass package name as first argument (without purescript- prefix)"
	exit 1
fi

set -euo pipefail

cd ~/git/purenix-org/

git clone "git@github.com:purescript/purescript-${package_name}.git"
cd "purescript-${package_name}/"

cp ../purescript-foldable-traversable/{flake.nix,packages.dhall,spago.dhall} ./
sed -i -e 's/description = "purescript-foldable-traversable"/description = "purescript-'${package_name}'"/' ./flake.nix
sed -i -e 's/name = "purescript-foldable-traversable"/name = "purescript-'${package_name}'"/' ./spago.dhall

nvim -p bower.json spago.dhall  # manually copy over deps from bower.json to spago.dhall.

rm -rf .git .github package.json bower.json .eslintrc.json

git init .
git add .
git config user.name "(cdep)illabout" && git config user.email "cdep.illabout@gmail.com"
git commit -m "Initial commit."
gh repo create -y --public purenix-org/$(basename `pwd`)
git push

nix flake lock
git add ./flake.lock
git commit -m "Add flake.lock"
git push

echo
echo
echo
echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! MAKE SURE YOU ADD THIS PACKAGE TO temp-package-set !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
echo
echo
echo
echo '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ALSO MAKE SURE TO git restore packages.dhall after next command !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
echo
echo
echo

nix develop -c spago build
