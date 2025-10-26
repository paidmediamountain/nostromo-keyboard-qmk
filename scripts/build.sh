#!/bin/bash

# Build script for Nostromo keyboard firmware
# This script assumes QMK is installed in ~/qmk_firmware

QMK_DIR="$HOME/qmk_firmware"
KEYBOARD="weyland_yutani/nostromo"
KEYMAP="default"

echo "================================"
echo "Nostromo Keyboard Build Script"
echo "================================"
echo ""

# Check if QMK directory exists
if [ ! -d "$QMK_DIR" ]; then
    echo "Error: QMK firmware not found at $QMK_DIR"
    echo "Please install QMK first:"
    echo "  pip3 install qmk"
    echo "  qmk setup"
    exit 1
fi

# Copy firmware files to QMK directory
echo "Copying firmware files to QMK directory..."
cp -r ../firmware/weyland_yutani "$QMK_DIR/keyboards/"

# Navigate to QMK directory
cd "$QMK_DIR" || exit 1

# Compile the firmware
echo "Compiling firmware..."
qmk compile -kb "$KEYBOARD" -km "$KEYMAP"

if [ $? -eq 0 ]; then
    echo ""
    echo "Build successful!"
    echo "Firmware file: ${KEYBOARD//\//_}_${KEYMAP}.hex"
    
    # Copy the hex file back to project directory
    cp "${KEYBOARD//\//_}_${KEYMAP}.hex" "$OLDPWD/../firmware/"
    echo "Hex file copied to firmware directory"
else
    echo ""
    echo "Build failed! Please check the error messages above."
    exit 1
fi