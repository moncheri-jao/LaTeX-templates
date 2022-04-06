#!/bin/sh

# this script will install the templates inside your home folder, in a way that lets you use the automated book-creator script I've inserted inside the repo (mkbook.sh)
# v0.1 06/04/2022 12.06

template=$(ls $HOME | awk '/[Tt]emplate[s]*/')
if [[ -z "$template" ]] 
then
	mkdir -p $HOME/Templates
	template="Templates"
fi
if [[ -e "$HOME/texmf" ]]
then
	localtex="$HOME/texmf/tex/latex"
else
	mkdir -p "$HOME/texmf/tex/latex"
fi
sed -i '/\/templates\/\/$template\//g' ./mkbook.sh
echo "Copying the files..."
folder=$(ls -d "$HOME"/* | awk '/[Tt]emplate[s]*/')
mkdir "$folder"/latex2
mkdir "$localtex"/fancypages
cp -r ./packages/*.sty "$localtex/fancypages"
cp -r ./base "$folder"/latex2/
cp -r ./title "$folder"/latex2/
cp mkbook.sh "$folder"/latex2
echo "Finished. Add mkbook to your local bin folder in order to use it systemwide."
