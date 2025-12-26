FOLDER="$1"

if [ ! -d "$FOLDER" ]; then
    echo "Directory does not exist"
    exit 1
fi

cd "$FOLDER" || exit


for FILE in *; do

    if [ -f "$FILE" ]; then

        EXT="${FILE##*.}"
        if [ "$FILE" = "$EXT" ]; then
            EXT="no_extension"
        fi
        mkdir -p "$EXT"
        mv "$FILE" "$EXT/"
    fi
done


for DIR in */; do
    EXT_NAME="${DIR%/}"
    COUNT=$(ls "$DIR" | wc -l)
    echo "Organized $COUNT .$EXT_NAME files"
done
