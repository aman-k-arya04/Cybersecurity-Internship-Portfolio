
#!/bin/bash

# ==========================================
# PROJECT 02: LINUX FILE ORGANIZER
# ==========================================

# 1. Get the target directory
TARGET_DIR="${1:-.}"

# 2. Check whether the directory exists
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory does not exist!"
    exit 1
fi

echo "=================================="
echo "       FILE ORGANIZER"
echo "=================================="

# 3. Create category folders
mkdir -p "$TARGET_DIR/Images"
mkdir -p "$TARGET_DIR/Documents"
mkdir -p "$TARGET_DIR/Videos"
mkdir -p "$TARGET_DIR/Others"

# 4. Process files in the target directory
for file in "$TARGET_DIR"/*; do

    # Ignore directories and non-files
    [[ -f "$file" ]] || continue

    # Extract the filename
    filename="${file##*/}"

    # Extract and normalize the extension
    extension="${filename##*.}"
    extension="${extension,,}"

    # Handle files without an extension
    if [[ "$filename" != *.* ]]; then
        extension=""
    fi

    # 5. Select the destination folder
    case "$extension" in

        jpg|jpeg|png|gif|svg|webp)
            destination="$TARGET_DIR/Images"
            ;;

        pdf|doc|docx|txt|ppt|pptx|xls|xlsx|csv)
            destination="$TARGET_DIR/Documents"
            ;;

        mp4|mkv|avi|mov|webm)
            destination="$TARGET_DIR/Videos"
            ;;

        *)
            destination="$TARGET_DIR/Others"
            ;;
    esac

    # 6. Prevent accidental overwriting
    if [[ -e "$destination/$filename" ]]; then
        echo "Skipped: $filename (already exists)"
        continue
    fi

    # 7. Move the file
    mv -- "$file" "$destination/"

    echo "Organized: $filename -> ${destination##*/}/"

done

echo ""
echo "=================================="
echo "     ORGANIZATION COMPLETE"
echo "=================================="
