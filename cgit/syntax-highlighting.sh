#!/bin/sh

BASENAME="$1"
EXTENSION="${BASENAME##*.}"
TABSTOP="4"

[ "${BASENAME}" = "${EXTENSION}" ] && EXTENSION=txt
[ -z "${EXTENSION}" ] && EXTENSION=txt

while \
	[ "${EXTENSION}" = "in" ] || \
	[ "${EXTENSION}" = "inc" ] || \
	[ "${EXTENSION}" = "template" ]; do
	BASENAME="${BASENAME%.*}"; EXTENSION="${BASENAME##*.}"
done

case "${EXTENSION}" in
	*project|*proj|*props|glade*) EXTENSION="xml" ;;
	*mount) EXTENSION="ini" ;;
	'service'|'target'|'socket'|'path'|'timer'|'client') EXTENSION="ini" ;;
	'desktop'|'convert') EXTENSION="ini" ;;
	'doap'|'ui'|'rdf'|'omf'|'page'|'etspec'|'galview') EXTENSION="xml" ;;
	'json') EXTENSION="js" ;;
	'xpm') EXTENSION="c" ;;
	'ac'|'m4'|'po'|'dirs') EXTENSION="sh" ;;
	'am') EXTENSION="mk" ;;
	's') EXTENSION="asm" ;;
	'p') EXTENSION="c" ;;
esac

case "${BASENAME%%.*}" in
	Makefile|makefile|GNUmakefile|BSDmakefile|Makevars) EXTENSION=mk ;;
	pkg-install|pkg-deinstall|pkg-req|pkg-plist|rc) EXTENSION=sh ;;
	PKGBUILD|bash_include) EXTENSION=bash ;;
	POTFILES) EXTENSION=ini ;;
	vimrc|vimadd) EXTENSION=vim ;;
	patch-*) EXTENSION=patch ;;
esac

case "${CGIT_REPO_NAME}" in
    taiwan-online-judge*) TABSTOP=8 ;;
    *) TABSTOP=4 ;;
esac

HIGHLIGHT="/usr/bin/highlight --force -f -I --inline-css -s edit-gedit -O xhtml -t $TABSTOP -S $EXTENSION"

case "${CGIT_REPO_NAME}" in
    *bbs|maple3-itoc)
        /usr/bin/iconv -f Big5 -t UTF-8 | $HIGHLIGHT 2>/dev/null
        ;;
    *)
        exec $HIGHLIGHT 2>/dev/null
        ;;
esac
