#!/bin/sh

# Markdown support requires perl.
# RestructuredText support requires python and docutils.
# Man page support requires groff.

cd "$(dirname $0)/html-converters/"
case "$(echo "$1" | tr '[:upper:]' '[:lower:]')" in
	*.md|*.mkd) exec ./md2html; ;;
	*.rst) exec ./rst2html; ;;
	*.[1-9]) exec ./man2html; ;;
	*.htm|*.html) exec cat; ;;
	*.txt|*) exec ./txt2html; ;;
esac
