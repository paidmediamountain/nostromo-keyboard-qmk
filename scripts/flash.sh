#!/bin/bash

# Flash script for Nostromo keyboard
# Supports both QMK flash and direct avrdude methods

QMK_DIR="$HOME/qmk_firmware"
KEYBOARD="weyland_yutani/nostromo"
KEYMAP="default"
HEX_FILE="../firmware/weyland_yutani_nostromo_default.hex"

echo "================================"
echo "Nostromo Keyboard Flash Script"
echo "================================"
echo ""

# Check for hex file
if [ ! -f "$HEX_FILE" ]; then
    echo "Hex file not found. Building firmware first..."
    ./build.sh
    if [ $? -ne 0 ]; then
        echo "Build failed. Exiting."
        exit 1
    fi
fi

echo "Choose flash method:"
echo "1) QMK Flash (recommended)"
echo "2) Direct avrdude"
echo "3) Auto-reset flash"
read -p "Select (1-3): " choice

case $choice in
    1)
        echo ""
        echo "Using QMK Flash..."
        echo ""
        echo "IMPORTANT: When you see 'Waiting for USB serial port':"
        echo "  Double-tap the RESET button on your Pro Micro!"
        echo ""
        read -p "Press Enter to continue..."
        
        cd "$QMK_DIR" || exit 1
        qmk flash -kb "$KEYBOARD" -km "$KEYMAP"
        ;;
        
    2)
        echo ""
        echo "Using direct avrdude..."
        echo ""
        echo "IMPORTANT: Put Pro Micro in bootloader mode first:"
        echo "  Double-tap the RESET button NOW!"
        echo ""
        read -p "Press Enter after reset..."
        
        # Find the port
        PORT=$(ls /dev/ttyACM* 2>/dev/null | head -n1)
        if [ -z "$PORT" ]; then
            PORT=$(ls /dev/ttyUSB* 2>/dev/null | head -n1)
        fi
        
        if [ -z "$PORT" ]; then
            echo "No device found! Make sure Pro Micro is in bootloader mode."
            exit 1
        fi
        
        echo "Found device at: $PORT"
        avrdude -p atmega32u4 -c avr109 -P "$PORT" -U flash:w:"$HEX_FILE":i
        ;;
        
    3)
        echo ""
        echo "Using auto-reset flash..."
        
        # Find current port
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
        echo "Triggering bootloader..."
        
        # Reset using stty
        stty -F "$PORT" 1200 2>/dev/null
        sleep 0.5
        
        echo "Waiting for bootloader..."
        sleep 2
        
        # Find new port
        PORT=$(ls /dev/ttyACM* 2>/dev/null | head -n1)
        avrdude -p atmega32u4 -c avr109 -P "$PORT" -U flash:w:"$HEX_FILE":i
        ;;
        
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Flash completed successfully!"
    echo "Your Nostromo keyboard should now be ready to use."
else
    echo ""
    echo "✗ Flash failed!"
    echo ""
    echo "Troubleshooting tips:"
    echo "- Make sure you double-tap reset quickly"
    echo "- Try a different USB cable"
    echo "- Check that you're in the dialout group:"
    echo "    sudo usermod -a -G dialout \$USER"
    echo "- Log out and back in after adding to dialout group"
fi