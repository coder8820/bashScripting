#!/bin/bash

# ==========================================================
# Professional Bash File Organizer
# ==========================================================

# -----------------------------
# Configuration
# -----------------------------

SCRIPT_NAME="File Organizer"
LOG_FILE="organizer.log"

DRY_RUN=false

# Counters
IMAGE_COUNT=0
DOCUMENT_COUNT=0
VIDEO_COUNT=0
MUSIC_COUNT=0
ARCHIVE_COUNT=0
OTHER_COUNT=0
TOTAL_COUNT=0


# -----------------------------
# Colors
# -----------------------------

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'


# -----------------------------
# Usage Function
# -----------------------------

usage() {

    echo ""
    echo "Usage:"
    echo "  ./file_organizer.sh <directory>"
    echo "  ./file_organizer.sh <directory> --dry-run"
    echo ""
    echo "Examples:"
    echo "  ./file_organizer.sh ~/Downloads"
    echo "  ./file_organizer.sh ~/Downloads --dry-run"
    echo ""
}


# -----------------------------
# Logging Function
# -----------------------------

log_message() {

    local message="$1"

    echo "$(date '+%Y-%m-%d %H:%M:%S') | $message" >> "$LOG_FILE"
}


# -----------------------------
# Success Message
# -----------------------------

success() {

    echo -e "${GREEN}[SUCCESS]${NC} $1"

}


# -----------------------------
# Error Message
# -----------------------------

error_message() {

    echo -e "${RED}[ERROR]${NC} $1"

}


# -----------------------------
# Get Unique Filename
# -----------------------------

get_unique_filename() {

    local destination="$1"
    local filename
    local extension
    local name
    local counter=1

    filename=$(basename "$destination")

    if [[ "$filename" == *.* ]]; then
        extension=".${filename##*.}"
        name="${filename%.*}"
    else
        extension=""
        name="$filename"
    fi

    while [ -e "$destination" ]; do

        destination="$(dirname "$destination")/${name}_${counter}${extension}"

        ((counter++))

    done

    echo "$destination"
}


# -----------------------------
# Move File
# -----------------------------

move_file() {

    local file="$1"
    local destination_dir="$2"

    local filename
    local destination

    filename=$(basename "$file")

    destination="$destination_dir/$filename"

    # Handle duplicate files
    if [ -e "$destination" ]; then

        destination=$(get_unique_filename "$destination")

        echo -e "${YELLOW}[DUPLICATE]${NC} $filename already exists."
        echo "            Renaming to: $(basename "$destination")"

    fi


    # Dry run
    if [ "$DRY_RUN" = true ]; then

        echo -e "${CYAN}[DRY RUN]${NC} $filename -> $(basename "$destination_dir")/"

        log_message "[DRY RUN] $filename -> $destination"

        return

    fi


    # Actual move
    if mv "$file" "$destination"; then

        success "$filename -> $(basename "$destination_dir")/"

        log_message "MOVED | $filename -> $destination"

    else

        error_message "Failed to move $filename"

        log_message "ERROR | Failed to move $filename"

    fi
}


# -----------------------------
# Create Directories
# -----------------------------

create_directories() {

    mkdir -p \
        "$TARGET_DIR/Images" \
        "$TARGET_DIR/Documents" \
        "$TARGET_DIR/Videos" \
        "$TARGET_DIR/Music" \
        "$TARGET_DIR/Archives" \
        "$TARGET_DIR/Others"

}


# -----------------------------
# Organize Files
# -----------------------------

organize_files() {

    local file
    local extension

    for file in "$TARGET_DIR"/*; do

        # Skip directories
        if [ ! -f "$file" ]; then
            continue
        fi

        # Skip log file
        if [ "$(basename "$file")" = "$LOG_FILE" ]; then
            continue
        fi

        extension="${file##*.}"
        extension="${extension,,}"


        case "$extension" in

            jpg|jpeg|png|gif|webp|svg|bmp)
                move_file "$file" "$TARGET_DIR/Images"
                ((IMAGE_COUNT++))
                ;;

            pdf|doc|docx|txt|xls|xlsx|ppt|pptx|csv)
                move_file "$file" "$TARGET_DIR/Documents"
                ((DOCUMENT_COUNT++))
                ;;

            mp4|mkv|avi|mov|webm)
                move_file "$file" "$TARGET_DIR/Videos"
                ((VIDEO_COUNT++))
                ;;

            mp3|wav|flac|aac|ogg)
                move_file "$file" "$TARGET_DIR/Music"
                ((MUSIC_COUNT++))
                ;;

            zip|rar|7z|tar|gz|bz2)
                move_file "$file" "$TARGET_DIR/Archives"
                ((ARCHIVE_COUNT++))
                ;;

            *)
                move_file "$file" "$TARGET_DIR/Others"
                ((OTHER_COUNT++))
                ;;

        esac

        ((TOTAL_COUNT++))

    done

}


# -----------------------------
# Summary
# -----------------------------

show_summary() {

    echo ""
    echo "================================================"
    echo "              ORGANIZATION SUMMARY"
    echo "================================================"

    echo "Images      : $IMAGE_COUNT"
    echo "Documents   : $DOCUMENT_COUNT"
    echo "Videos      : $VIDEO_COUNT"
    echo "Music       : $MUSIC_COUNT"
    echo "Archives    : $ARCHIVE_COUNT"
    echo "Others      : $OTHER_COUNT"
    echo "------------------------------------------------"
    echo "Total Files : $TOTAL_COUNT"
    echo "================================================"

}


# ==========================================================
# Main Program
# ==========================================================

echo ""
echo "=============================================="
echo "        PROFESSIONAL FILE ORGANIZER"
echo "=============================================="
echo ""


# -----------------------------
# Check Arguments
# -----------------------------

if [ $# -eq 0 ]; then

    error_message "No directory provided."

    usage

    exit 1

fi


TARGET_DIR="$1"


# -----------------------------
# Check Dry Run
# -----------------------------

if [ "$2" = "--dry-run" ]; then

    DRY_RUN=true

    echo -e "${CYAN}Dry-run mode enabled.${NC}"
    echo "No files will be moved."
    echo ""

fi


# -----------------------------
# Validate Directory
# -----------------------------

if [ ! -d "$TARGET_DIR" ]; then

    error_message "Directory does not exist: $TARGET_DIR"

    exit 1

fi


# -----------------------------
# Create Categories
# -----------------------------

create_directories


# -----------------------------
# Start Logging
# -----------------------------

log_message "========== ORGANIZER STARTED =========="
log_message "Target directory: $TARGET_DIR"


# -----------------------------
# Organize
# -----------------------------

organize_files


# -----------------------------
# Show Summary
# -----------------------------

show_summary


# -----------------------------
# Finish
# -----------------------------

log_message "========== ORGANIZER FINISHED =========="

echo ""
success "File organization completed!"
echo ""
