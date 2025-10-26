#!/bin/bash

# Flash script with automatic reset for Leonardo/Pro Micro
# Usage: ./flash_with_reset.sh keyboard_name keymap_name

if [ $# -lt 2 ]; then
    echo "Usage: $0 keyboard_name keymap_name"
    echo "Example: $0 handwired/dactyl_manuform/5x6 default"
    exit 1
fi

KEYBOARD=$1
KEYMAP=$2

echo "==================================="
echo "Pro Micro Flash with Auto-Reset"
echo "==================================="
echo ""
echo "Keyboard: $KEYBOARD"
echo "Keymap: $KEYMAP"
echo ""

# First compile the firmware
echo "Compiling firmware..."
qmk compile -kb "$KEYBOARD" -km "$KEYMAP"

if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    exit 1
fi

echo ""
echo "Firmware compiled successfully!"
echo ""

# Find the current Arduino port
PORT=$(ls /dev/ttyACM* 2>/dev/null | head -n1)
if [ -z "$PORT" ]; then
    PORT=$(ls /dev/ttyUSB* 2>/dev/null | head -n1)
fi

if [ -z "$PORT" ]; then
    echo "No Arduino device found!"
    echo "Please connect your Pro Micro and try again."
    exit 1
fi

echo "Found device at: $PORT"
echo ""
echo "Triggering bootloader mode..."

# Reset the device using stty
stty -F "$PORT" 1200 2>/dev/null

# Give it a moment to disconnect
sleep 0.5

echo "Waiting for bootloader..."
echo ""

# Start the flash command in background
# It will wait for the device to appear
qmk flash -kb "$KEYBOARD" -km "$KEYMAP" &
FLASH_PID=$!

# Monitor for completion
wait $FLASH_PID
RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo ""
    echo "✓ Flash completed successfully!"
else
    echo ""
    echo "✗ Flash failed!"
    echo ""
    echo "Try manual method:"
    echo "1. Run: qmk flash -kb $KEYBOARD -km $KEYMAP"
    echo "2. When you see 'Detecting USB port, reset your controller now...'"
    echo "3. Double-tap the reset button on your Pro Micro"
fi

exit $RESULT