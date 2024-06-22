#!/bin/bash

FONTS_DIR=$(pwd)/fonts
echo "the fonts dir: $FONTS_DIR"

FIND_COMMAND="find \"$FONTS_DIR\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

KERNEL=$(uname)
case "$KERNEL" in
    'Darwin') # macOS  
		FONT_DIR="$HOME/Library/Fonts"
		;;
	'Linux')
		FONT_DIR="$HOME/.local/share/fonts"
		mkdir -p $FONT_DIR
		;;
    *)
        echo "Unknown OS: $KERNEL"
        ;;
esac

# Copy all fonts to user fonts directory
echo "Copying fonts..."
# printing
eval $FIND_COMMAND | xargs -0 -I %

eval $FIND_COMMAND | xargs -0 -I % cp "%" "$FONT_DIR/"

# Reset font cache on Linux
if command -v fc-cache @>/dev/null ; then
    echo -e "\nResetting font cache, this may take a moment..."
    fc-cache -f $FONT_DIR
fi

echo -e "\nAll fonts have been installed to $FONT_DIR"
