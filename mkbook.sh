#!/bin/bash
#This application creates a folder optimized for writing books with subfiles with my template. For now you'd need to set up manually the directory where the app takes the templates, maybe in the future I'll make an automatic setup of that but for now it is what it is
bookcreate() {
	if [ ! -d "$name" ]; then
		mkdir -p "$(pwd)/$name/chapters"
		mkdir "$(pwd)/$name/images"
		mkdir "$(pwd)/$name/resources"
		cp "$HOME"/templates/latex/base/base.tex "$(pwd)"/"$name"/"$name".tex
		cp "$HOME"/templates/latex/base/newchapter.tex "$(pwd)"/"$name"/chapters/newchapter.tex
		sed -i 's/..\/<++>/..\/'"$name"'/g' "$(pwd)"/"$name"/chapters/newchapter.tex
	else
		echo "there exists already a book with that name"
		exit
	fi
}
maketitle () {
	mkdir "$(pwd)"/"$name"/title
	if [ -n "$lang" ]; then
		if [ "$lang" = "en" ]; then
			cp "$HOME"/templates/latex/title/en/title.tex "$(pwd)"/"$name"/title/title.tex
			sed -i 's/..\/<++>/..\/'"$name"'.tex/g' "$(pwd)"/"$name"/title/title.tex
		elif [ "$lang" = "it" ]; then
			cp "$HOME"/templates/latex/title/it/title.tex "$(pwd)"/"$name"/title/title.tex
			sed -i 's/..\/<++>/..\/'"$name"'.tex/g' "$(pwd)"/"$name"/title/title.tex
		else
			echo "the language inserted is not supported, using the english version"
			cp "$HOME"/templates/latex/title/en/title.tex "$(pwd)"/"$name"/title/title.tex
			sed -i 's/..\/<++>/..\/'"$name"'.tex/g' "$(pwd)"/"$name"/title/title.tex
		fi
	else
		echo "language not selected, using the english version"
		cp "$HOME"/templates/latex/title/en/title.tex "$(pwd)"/"$2"/title/title.tex
		sed -i 's/..\/<++>/..\/'"$name"'.tex/g' "$(pwd)"/"$name"/title/title.tex
	fi
}
titlecomplete () {
	sed -i "s/\\Huge\ /\\Huge\ '$title'/g" "$(pwd)"/"$name"/title/title.tex
	if [ "$lang" = "it" ]; then
		sed -i "s/Appunti\ di/Appunti di\ '$title'/g" "$(pwd)"/"$name"/title/title.tex
		sed -i "s/Versione\ /Versione\ '$ver'/g" "$(pwd)"/"$name"/title/title.tex
	else
		sed -i "s/Notes\ on/Notes on\ '$title'/g" "$(pwd)"/"$name"/title/title.tex
		sed -i "s/Version\ /Version\ '$ver'/g" "$(pwd)"/"$name"/title/title.tex
	fi
}
titlecolor() {
	if [ "$opt" = 1 ]; then
		sed -i 's/\\pagecolor{title}/\\pagecolor{sapienza}/g' "$(pwd)"/"$name"/title/title.tex
		rm "$(pwd)"/"$name"/"$name".tex
		cp "$HOME"/templates/latex/base/sapienza.tex "$(pwd)"/"$name"/"$name".tex
	fi
}
helpf() {
	echo "mkbook, LaTeX book folder creator from template"
	echo "USAGE AND ARGUMENTS:	"
	echo "			mkbook -n NAME		Create folder and .tex file with NAME"
	echo "				-l lang		Use specified language (it/en) supported. Uses en if not specified or not supported"
	echo "				-v vers		Add a version value of the book"
	echo "				-t TITLE	Title of the book"
	echo "				-h 		Prints this help section"
	echo "				--sapienza	Optional argument for changing the color of equations and the titlepage to the official color of Sapienza Università"
}
if [[ -n $1 ]]; then
	case $1 in
		-n)
			name=$2
			bookcreate "$2";;
		-h)
			helpf;;
		*)
			echo "you must first insert a" name" (-n NAME)"
			helpf;;
	esac
	case $3 in
		-l)
			lang=$4;;
		--sapienza)
			opt=1;;
		-t)
			title=$4;;
		-v)
			ver=$4;;
		-h)
			helpf;;
	esac
	case $4 in
		--sapienza)
			opt=1;;
		-t)
			title=$5;;
		-v)
			ver=$5;;
		-h)
			helpf;;
	esac
	case $5 in
		--sapienza)
			opt=1;;
		-t)
			title=$6;;
		-v)
			ver=$6;;
		-h)
			helpf;;
	esac
	case $6 in
		--sapienza)
			opt=1;;
		-t)
			title=$7;;
		-v)
			ver=$7;;
		-h)
			helpf;;
	esac
	case $7 in
		--sapienza)
			opt=1;;
		-t)
			title=$8;;
		-v)
			ver=$8;;
		-h)
			helpf;;
	esac
	case $8 in
		--sapienza)
			opt=1;;
		-t)
			title=$9;;
		-v)
			ver=$9;;
		-h)
			helpf;;
	esac
	maketitle "$@"
	titlecomplete
	titlecolor
	exit
#else
#	echo "insert a" name" [-n NAME]"
#	exit
fi
maketitle "$@"
titlecomplete
titlecolor
exit
