#!/bin/bash

# ==========================================
# Bash File Organizer
# ==========================================

echo "======================================"
echo "        Bash File Organizer"
echo "======================================"

# Directory to organize
TARGET_DIR="$HOME/Downloads"

# Check if Downloads directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Downloads directory does not exist."
    exit 1
fi

# Create folders
mkdir -p "$TARGET_DIR/Images"
mkdir -p "$TARGET_DIR/Documents"
mkdir -p "$TARGET_DIR/Videos"
mkdir -p "$TARGET_DIR/Music"
mkdir -p "$TARGET_DIR/Others"

# Move image files
for file in "$TARGET_DIR"/*; do

    if [ -f "$file" ]; then

        case "$file" in
            *.jpg|*.jpeg|*.png|*.gif|*.webp)
                mv "$file" "$TARGET_DIR/Images/"
                ;;

            *.pdf|*.doc|*.docx|*.txt|*.xls|*.xlsx|*.ppt|*.pptx)
                mv "$file" "$TARGET_DIR/Documents/"
                ;;

            *.mp4|*.mkv|*.avi|*.mov|*.webm)
                mv "$file" "$TARGET_DIR/Videos/"
                ;;

            *.mp3|*.wav|*.flac|*.aac)
                mv "$file" "$TARGET_DIR/Music/"
                ;;

            *)
                mv "$file" "$TARGET_DIR/Others/"
                ;;
        esac

    fi

done

echo ""
echo "Files organized successfully!"
echo "======================================"
