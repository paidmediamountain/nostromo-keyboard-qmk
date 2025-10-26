#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /*
     * Base Layer (Layer 0)
     * ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
     * │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │
     * ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
     * │ A │ S │ D │ F │ G │ H │ J │ K │ L │ ; │
     * ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
     * │ Z │ X │ C │ V │ B │ N │ M │ , │ . │ / │
     * ├───┼───┼───┼───┼───────┼───────┼───┼───┤
     * │Ctl│Alt│ ` │ \ │Tab 2u │Bksp2u │ ' │ = │
     * ├───┼───┼───────┼───────┼───────┼───┼───┤
     * │Fn1│Sys│Shift2u│Space2u│Return2│Fn2│Esc│
     * └───┴───┴───────┴───────┴───────┴───┴───┘
     */
    [0] = LAYOUT(
        // Row 0: Q W E R T Y U I O P
        KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,
        
        // Row 1: A S D F G H J K L ;
        KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN,
        
        // Row 2: Z X C V B N M , . /
        KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH,
        
        // Row 3: Ctrl Alt ` \ [Tab 2u] [Backspace 2u] ' =
        KC_LCTL, KC_LALT, KC_GRV,  KC_BSLS, KC_TAB,  KC_NO,   KC_BSPC, KC_NO,   KC_QUOT, KC_EQL,
        
        // Row 4: Fn1(left) Sys [Shift 2u] [Space 2u] [Return 2u] Fn2(right) Esc
        MO(1),   KC_NO,   KC_LSFT, KC_NO,   KC_SPC,  KC_NO,   KC_ENT,  KC_NO,   MO(2),   KC_ESC
    ),

    /*
     * Layer 1: Numbers & Navigation (LEFT Fn key)
     * Accessed by holding LEFT Fn key
     * 
     * Features:
     * - Top row: Numbers 1-0
     * - HJKL: Arrow keys (vim-style)
     * - Additional navigation keys
     * 
     * ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
     * │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │
     * ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
     * │   │   │   │   │   │ ← │ ↓ │ ↑ │ → │Del│
     * ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
     * │   │   │   │   │   │Hom│PgD│PgU│End│Ins│
     * ├───┼───┼───┼───┼───────┼───────┼───┼───┤
     * │   │   │   │   │       │  Del  │ [ │ ] │
     * ├───┼───┼───────┼───────┼───────┼───┼───┤
     * │Fn1│   │       │       │       │   │   │
     * └───┴───┴───────┴───────┴───────┴───┴───┘
     */
    [1] = LAYOUT(
        // Row 0: Numbers 1-0
        KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,
        
        // Row 1: Arrow keys on HJKL + Delete
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_DEL,
        
        // Row 2: Navigation cluster
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_HOME, KC_PGDN, KC_PGUP, KC_END,  KC_INS,
        
        // Row 3: Additional keys
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO,   KC_DEL,  KC_NO,   KC_LBRC, KC_RBRC,
        
        // Row 4: Hold state
        KC_TRNS, KC_TRNS, KC_TRNS, KC_NO,   KC_TRNS, KC_NO,   KC_TRNS, KC_NO,   KC_TRNS, KC_TRNS
    ),

    /*
     * Layer 2: Function Keys & Media (RIGHT Fn key)
     * Accessed by holding RIGHT Fn key
     * 
     * Features:
     * - Top row: F1-F10
     * - Media controls
     * - System controls
     * 
     * ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
     * │F1 │F2 │F3 │F4 │F5 │F6 │F7 │F8 │F9 │F10│
     * ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
     * │F11│F12│   │   │   │Prv│VoD│VoU│Nxt│Mut│
     * ├───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
     * │   │   │   │   │   │Stp│Ply│Pau│   │   │
     * ├───┼───┼───┼───┼───────┼───────┼───┼───┤
     * │   │   │   │   │       │       │ - │ + │
     * ├───┼───┼───────┼───────┼───────┼───┼───┤
     * │   │   │       │       │       │Fn2│Rst│
     * └───┴───┴───────┴───────┴───────┴───┴───┘
     */
    [2] = LAYOUT(
        // Row 0: Function keys F1-F10
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,
        
        // Row 1: F11-F12 and Media controls
        KC_F11,  KC_F12,  KC_TRNS, KC_TRNS, KC_TRNS, KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT, KC_MUTE,
        
        // Row 2: Media playback
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_MSTP, KC_MPLY, KC_MUTE, KC_TRNS, KC_TRNS,
        
        // Row 3: Volume and brightness
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO,   KC_TRNS, KC_NO,   KC_MINS, KC_PLUS,
        
        // Row 4: Hold state + Reset
        KC_TRNS, KC_TRNS, KC_TRNS, KC_NO,   KC_TRNS, KC_NO,   KC_TRNS, KC_NO,   KC_TRNS, QK_BOOT
    ),
};