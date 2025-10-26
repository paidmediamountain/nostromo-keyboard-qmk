# Nostromo Keyboard Wiring Guide

## Overview
This guide details the complete wiring for the Weyland-Yutani Nostromo keyboard using a Pro Micro controller.

## Matrix Layout (5x10)

### Physical Key Matrix
```
        Col0  Col1  Col2  Col3  Col4  Col5  Col6  Col7  Col8  Col9
Row0    Q     W     E     R     T     Y     U     I     O     P
Row1    A     S     D     F     G     H     J     K     L     ;
Row2    Z     X     C     V     B     N     M     ,     .     /
Row3    Ctrl  Alt   `     \     Tab   -     Bksp  -     '     =
Row4    Fn1   -     Shift -     Space -     Enter -     Fn2   Esc
```

Note: Dashes (-) indicate positions that are part of 2u keys but have no switch.

## Pro Micro Pin Assignments

### Left Side (when USB port is facing up)
```
         Pro Micro
     ┌─────────────┐
TX0  │ D3       RAW│
RX1  │ D2       GND│
GND  │ GND      RST│
GND  │ GND      VCC│
2    │ D1       F4 │ A3
3    │ D0       F5 │ A2
4    │ D4       F6 │ A1
5    │ C6       F7 │ A0
6    │ D7       B1 │ 15
7    │ E6       B3 │ 14
8    │ B4       B2 │ 16
9    │ B5       B6 │ 10
     └─────────────┘
```

### Pin to Matrix Connections

#### ROW Connections (5 wires)
- **Row 0** → TX0 (D3) - Top row (Q through P)
- **Row 1** → RX1 (D2) - Second row (A through ;)
- **Row 2** → Pin 2 (D1) - Third row (Z through /)
- **Row 3** → Pin 3 (D0) - Fourth row (Ctrl through =)
- **Row 4** → Pin 4 (D4) - Bottom row (Fn1 through Esc)

#### COLUMN Connections (10 wires)
- **Col 0** → Pin 5 (C6)
- **Col 1** → Pin 6 (D7)
- **Col 2** → Pin 7 (E6)
- **Col 3** → Pin 8 (B4)
- **Col 4** → Pin 9 (B5)
- **Col 5** → Pin 10 (B6)
- **Col 6** → Pin 16 (B2)
- **Col 7** → Pin 14 (B3)
- **Col 8** → Pin 15 (B1)
- **Col 9** → Pin A0 (F7)

## Diode Wiring

### Diode Orientation
- **Direction**: COL2ROW
- **Installation**: Diode cathode (stripe) connects to the ROW wire
- **One diode per switch** (45 total)

### Diode Connection Diagram
```
    Switch Pin 1 ───┤>├─── To Row Wire
                    Diode
                    (stripe towards row)
    
    Switch Pin 2 ────────── To Column Wire
```

## Wiring Steps

### Step 1: Prepare the Diodes
1. Bend each diode into shape
2. The stripe (cathode) will connect to the row wire
3. The other end (anode) connects to one switch pin

### Step 2: Wire the Rows
1. Start with Row 0 (top row)
2. Connect the cathode (stripe) end of 10 diodes to a common row wire
3. Connect this row wire to TX0 (D3) on the Pro Micro
4. Repeat for all 5 rows

### Step 3: Wire the Columns
1. Starting with Column 0 (leftmost)
2. Connect all switches in that column with a common wire
3. Connect to the switch pin that doesn't have a diode
4. Route this column wire to Pin 5 (C6) on the Pro Micro
5. Repeat for all 10 columns

### Step 4: Handle 2u Keys
For 2u keys (Tab, Backspace, Shift, Space, Return):
- Mount stabilizers
- Install switch in the center position
- Wire only the center switch position
- Leave adjacent matrix positions empty (no switch/diode)

## Testing

### Continuity Test
Before powering on:
1. Test each diode with multimeter in diode mode
2. Verify row connections from Pro Micro pin to diodes
3. Verify column connections from Pro Micro pin to switches
4. Check for shorts between adjacent rows/columns

### Matrix Test
After flashing firmware:
1. Open a text editor
2. Press each key systematically
3. Verify correct character appears
4. Test all layer functions (Fn keys)

## Common Issues and Solutions

### Key not working
- Check diode orientation (stripe to row)
- Resolder cold joints
- Verify continuity with multimeter

### Multiple keys activate
- Check for shorts between columns
- Check for shorts between rows
- Verify diode is not shorted

### Entire row/column not working
- Check Pro Micro pin connection
- Test continuity from Pro Micro to switches
- Verify pin isn't damaged on Pro Micro

### Ghost keys or chatter
- Check diode installation
- Increase debounce in firmware (currently 10ms)
- Clean flux residue from PCB

## Color Coding Suggestion
For easier troubleshooting:
- **Red wires**: Rows (5 wires)
- **Blue wires**: Columns (10 wires)  
- **Black wire**: Ground (if adding LEDs later)
- **Yellow wire**: VCC/5V (if adding LEDs later)

## Additional Notes

### Wire Gauge
- Recommended: 24-26 AWG solid core wire
- Solid core is easier to route and solder
- Stranded wire is more flexible but harder to work with

### Soldering Tips
- Use flux for cleaner joints
- Tin wires before soldering to switches
- Keep iron temperature around 350°C (660°F)
- Clean iron tip regularly

### Cable Management
- Route wires along edges when possible
- Use hot glue to secure wires in place
- Keep wires short but with slight slack for flex
- Avoid crossing row and column wires when possible