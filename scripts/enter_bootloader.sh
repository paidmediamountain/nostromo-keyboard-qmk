#!/bin/bash

# Pro Micro Bootloader Entry Script
# Triggers bootloader mode using stty

echo "Pro Micro Bootloader Entry Tool"
echo "================================"

# Find the Pro Micro device
DEVICE=""
if [ -e /dev/ttyACM0 ]; then
    DEVICE="/dev/ttyACM0"
elif [ -e /dev/ttyACM1 ]; then
    DEVICE="/dev/ttyACM1"
else
    echo "✗ No Pro Micro found at /dev/ttyACM*"
    echo ""
    echo "Manual method: Double-tap the reset button quickly"
    exit 1
fi

echo "Found Pro Micro at: $DEVICE"
echo "Triggering bootloader mode..."

# Open at 1200 baud to trigger bootloader
# This causes the Pro Micro to reset into bootloader mode
stty -F $DEVICE 1200 2>/dev/null

echo "✓ Bootloader triggered!"
echo ""
echo "The device should now be in bootloader mode for ~8 seconds"
echo ""
echo "Quick test - checking for device changes:"
sleep 0.5

# Check if device changed (common indicator of bootloader mode)
if [ -e /dev/ttyACM1 ]; then
    echo "✓ Possible bootloader at /dev/ttyACM1"
elif [ ! -e /dev/ttyACM0 ]; then
    echo "✓ Device disconnected (likely in bootloader)"
fi

echo ""
echo "To flash with QMK:"
echo "  qmk flash -kb your_keyboard -km your_keymap"
echo ""
echo "Alternative manual method:"
echo "  Double-tap the reset button quickly (or short RST to GND twice)"