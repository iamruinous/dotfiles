#include "planck.h"
#include "action_layer.h"
#ifdef AUDIO_ENABLE
#include "audio.h"
#endif
#include "eeconfig.h"
#include "keymap_plover.h"
#include "version.h"

extern keymap_config_t keymap_config;

// Keymap layers
enum planck_layers {
  BASE_QWERTY_LAYER,
  BASE_COLEMAK_LAYER,
  LOWER_LAYER,
  RAISE_LAYER,
  NAV_LAYER,
  GUI_LAYER,
  STENO_LAYER,
  KEYBOARD_LAYER
};

// Key aliases for legibility
#define _______ KC_TRNS
#define ___x___ KC_NO

// Dashes (macOS)
#define KC_NDSH LALT(KC_MINS)
#define KC_MDSH S(LALT(KC_MINS))

// Window manager keys
#define WM_FULL LALT(LGUI(KC_F))
#define WM_NEXT LCTL(LALT(LGUI(KC_RGHT)))
#define WM_PREV LCTL(LALT(LGUI(KC_LEFT)))
#define WM_NW   LCTL(LGUI(KC_LEFT))
#define WM_N    LALT(LGUI(KC_UP))
#define WM_NE   LCTL(LGUI(KC_RGHT))
#define WM_E    LALT(LGUI(KC_RGHT))
#define WM_SE   S(LCTL(LGUI(KC_RGHT)))
#define WM_S    LALT(LGUI(KC_DOWN))
#define WM_SW   S(LCTL(LGUI(KC_LEFT)))
#define WM_W    LALT(LGUI(KC_LEFT))
#define WM_CNTR LALT(LGUI(KC_C))

// Custom key codes
enum planck_keycodes {
  QWERTY = SAFE_RANGE,
  COLEMAK,
  STENO,
  LOWER,
  RAISE,
  PV_EXIT,
  PV_LOOK,
  SEND_VERSION,
  SEND_MAKE
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  /* Base layer (Qwerty)
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │  ⇥  │  Q  │  W  │  E  │  R  │  T  │  Y  │  U  │  I  │  O  │  P  │  '  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   * Tap for Esc -- │  ⌃  │  A  │  S  │  D  │  F  │  G  │  H  │  J  │  K  │  L  │; Nav│  ⌃  │ -- Tap for Enter
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *   Tap for ( -- │  ⇧  │  Z  │  X  │  C  │  V  │  B  │  N  │  M  │  ,  │  .  │  /  │  ⇧  │ -- Tap for )
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *   Tap for [ -- │ GUI │Hyper│  ⌥  │  ⌘  │  ↓  │   Space   │  ↑  │  ⌘  │  ⌥  │Hyper│ GUI │ -- Tap for ]
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   *                        /                                                     /
   *   Tap for ] [ --------'-----------------------------------------------------'
   */
  [BASE_QWERTY_LAYER] = {
    {KC_TAB,                 KC_Q,           KC_W,    KC_E,    KC_R,  KC_T,   KC_Y,    KC_U,  KC_I,    KC_O,    KC_P,                   KC_QUOT},
    {CTL_T(KC_ESC),          KC_A,           KC_S,    KC_D,    KC_F,  KC_G,   KC_H,    KC_J,  KC_K,    KC_L,    LT(NAV_LAYER, KC_SCLN), CTL_T(KC_ENT)},
    {KC_LSPO,                KC_Z,           KC_X,    KC_C,    KC_V,  KC_B,   KC_N,    KC_M,  KC_COMM, KC_DOT,  KC_SLSH,                KC_RSPC},
    {LT(GUI_LAYER, KC_LBRC), ALL_T(KC_RBRC), KC_LALT, KC_LGUI, LOWER, KC_SPC, KC_BSPC, RAISE, KC_RGUI, KC_RALT, ALL_T(KC_LBRC),         LT(GUI_LAYER, KC_RBRC)}
  },

  /* Base layer (Colemak)
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │     │  Q  │  W  │  F  │  P  │  G  │  J  │  L  │  U  │  Y  │  ;  │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │  A  │  R  │  S  │  T  │  D  │  H  │  N  │  E  │  I  │O Nav│     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │  Z  │  X  │  C  │  V  │  B  │  K  │  M  │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │           │     │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [BASE_COLEMAK_LAYER] = {
    {_______, KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,    KC_J,    KC_L,    KC_U,    KC_Y,    KC_SCLN,             _______},
    {_______, KC_A,    KC_R,    KC_S,    KC_T,    KC_D,    KC_H,    KC_N,    KC_E,    KC_I,    LT(NAV_LAYER, KC_O), _______},
    {_______, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_K,    KC_M,    _______, _______, _______,             _______},
    {_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,             _______}
  },

  /* Numeric layer
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   * Application -- │ ⌘-` │ F1  │ F2  │ F3  │ F4  │ F5  │ F6  │ F7  │ F8  │ F9  │ F10 │  |  │
   *      window    ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *    switcher    │     │  1  │  2  │  3  │  4  │  5  │  6  │  7  │  8  │  9  │  0  │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │  -  │  =  │  `  │  \  │  :  │ndash│mdash│  ,  │  .  │  /  │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │ Backspace │     │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [LOWER_LAYER] = {
    {LGUI(KC_GRV), KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_PIPE},
    {_______,      KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    _______},
    {_______,      KC_MINS, KC_EQL,  KC_GRV,  KC_BSLS, KC_COLN, KC_NDSH, KC_MDSH, KC_COMM, KC_DOT,  KC_SLSH, _______},
    {_______,      _______, _______, _______, _______, KC_BSPC, KC_BSPC, _______, _______, _______, _______, _______}
  },

  /* Symbol layer
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │     │ F11 │ F12 │ F13 │ F14 │ F15 │ F16 │ F17 │ F18 │ F19 │ F20 │  ~  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │  !  │  @  │  #  │  $  │  %  │  ^  │  &  │  *  │  '  │  "  │     │ \
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤  |-- Mostly shifted version
   *                │     │  _  │  +  │  ~  │  |  │  :  │ndash│mdash│  ,  │  .  │  /  │     │ /    of lower layer
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │  Delete   │     │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [RAISE_LAYER] = {
    {_______, KC_F11,  KC_F12,  KC_F13,  KC_F14,  KC_F15,  KC_F16,  KC_F17,  KC_F18,  KC_F19,  KC_F20,     KC_TILD},
    {_______, S(KC_1), S(KC_2), S(KC_3), S(KC_4), S(KC_5), S(KC_6), S(KC_7), S(KC_8), KC_QUOT, S(KC_QUOT), _______},
    {_______, KC_UNDS, KC_PLUS, KC_TILD, KC_PIPE, KC_COLN, KC_NDSH, KC_MDSH, KC_COMM, KC_DOT,  KC_SLSH,    _______},
    {_______, _______, _______, _______, _______, KC_DEL,  KC_DEL,  _______, _______, _______, _______,    _______}
  },

  /* Directional navigation layer
   *
   *         Large movements -----/```````````````````\   /```````````````````\----- Vim-style arrow keys
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │     │     │     │     │     │     │     │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │Home │PgUp │PgDn │ End │  ←  │  ↓  │  ↑  │  →  │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │     │     │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │           │     │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [NAV_LAYER] = {
    {___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___,                ___x___},
    {_______, ___x___, KC_HOME, KC_PGUP, KC_PGDN, KC_END,  KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, LT(NAV_LAYER, KC_SCLN), _______},
    {_______, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___,                _______},
    {_______, _______, _______, _______, ___x___, ___x___, ___x___, ___x___, _______, _______, _______,                _______}
  },

  /* GUI (window management/mouse/media controls) layer
   *
   *        Mouse keys -----/```````````````````\               /```````````````````\----- Window manager
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │     │Ms B2│Ms Up│Ms B1│Ms WD│     │     │Prev │ NW  │  N  │ NE  │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │Ms L │Ms Dn│Ms R │Ms WU│     │     │Full │  W  │Centr│  E  │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │Ms WL│Ms B3│Ms WR│     │     │     │Next │ SW  │  S  │ SE  │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │Prev │Play │Next │Brig-│   Sleep   │Brig+│Mute │Vol- │Vol+ │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   *                        \___ Media ___/   \___ Screen/sleep __/   \___ Volume __/
   */
  [GUI_LAYER] = {
    {_______, KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_D, ___x___, ___x___, WM_PREV, WM_NW,   WM_N,    WM_NE,   _______},
    {_______, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_U, ___x___, ___x___, WM_FULL, WM_W,    WM_CNTR, WM_E,    _______},
    {_______, KC_WH_L, KC_BTN3, KC_WH_R, ___x___, ___x___, ___x___, WM_NEXT, WM_SW,   WM_S,    WM_SE,   _______},
    {_______, KC_MPRV, KC_MPLY, KC_MNXT, KC_SLCK, KC_SLEP, KC_SLEP, KC_PAUS, KC_MUTE, KC_VOLD, KC_VOLU, _______}
  },

  /* Base layer (Qwerty-Steno)
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │  #  │  #  │  #  │  #  │  #  │  #  │  #  │  #  │  #  │  #  │  #  │  #  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │Look │     │  T  │  P  │  H  │           │  F  │  P  │  L  │  T  │  D  │
   *                │ -up │  S  ├─────┼─────┼─────┤     *     ├─────┼─────┼─────┼─────┼─────┤
   *                │     │     │  K  │  W  │  R  │           │  R  │  B  │  G  │  S  │  Z  │
   *                ├─────┼─────┼─────┼─────┼─────┼───────────┼─────┼─────┼─────┼─────┼─────┤
   *                │Exit │     │     │  A  │  O  │           │  E  │  U  │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [STENO_LAYER] = {
    {PV_NUM,  PV_NUM,  PV_NUM,  PV_NUM, PV_NUM, PV_NUM,  PV_NUM,  PV_NUM, PV_NUM, PV_NUM,  PV_NUM,  PV_NUM},
    {PV_LOOK, PV_LS,   PV_LT,   PV_LP,  PV_LH,  PV_STAR, PV_STAR, PV_RF,  PV_RP,  PV_RL,   PV_RT,   PV_RD},
    {PV_LOOK, PV_LS,   PV_LK,   PV_LW,  PV_LR,  PV_STAR, PV_STAR, PV_RR,  PV_RB,  PV_RG,   PV_RS,   PV_RZ},
    {PV_EXIT, ___x___, ___x___, PV_A,   PV_O,   KC_SPC,  KC_BSPC, PV_E,   PV_U,   ___x___, ___x___, ___x___}
  },

  /* Keyboard settings layer
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *    Firmware -- │     │Reset│Make │     │     │     │     │     │     │     │Vers │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *   Set layer -- │     │Qwert│Colem│Steno│     │     │     │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *       Audio -- │     │Voic-│Voic+│Mus +│Mus -│MIDI+│MIDI-│     │     │Aud +│Aud -│     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │Swap │Norm │     │  Toggle   │     │Toggl│ BL- │ BL+ │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   *               Swap GUI/Alt _/________/             \_____________\_ Backlight _/
   */
  [KEYBOARD_LAYER] = {
    {___x___, RESET,   SEND_MAKE, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, SEND_VERSION, ___x___},
    {___x___, QWERTY,  COLEMAK,   STENO,   ___x___, ___x___, ___x___, ___x___, ___x___, ___x___, ___x___,      ___x___},
    {___x___, MUV_DE,  MUV_IN,    MU_ON,   MU_OFF,  MI_ON,   MI_OFF,  ___x___, ___x___, AU_ON,   AU_OFF,       ___x___},
    {___x___, ___x___, AG_SWAP,   AG_NORM, LOWER,   BL_TOGG, BL_TOGG, RAISE,   BL_TOGG, BL_DEC,  BL_INC,       ___x___}
  }
};

#ifdef AUDIO_ENABLE
float plover_song[][2]    = SONG(PLOVER_SOUND);
float plover_gb_song[][2] = SONG(PLOVER_GOODBYE_SOUND);
#endif

// Send PHROPB ({PLOVER:RESUME}).
void plover_resume(void) {
  register_code(PV_LP);
  register_code(PV_LH);
  register_code(PV_LR);
  register_code(PV_O);
  register_code(PV_RP);
  register_code(PV_RB);
  unregister_code(PV_LP);
  unregister_code(PV_LH);
  unregister_code(PV_LR);
  unregister_code(PV_O);
  unregister_code(PV_RP);
  unregister_code(PV_RB);
}

// Send PHROF ({PLOVER:SUSPEND}).
void plover_suspend(void) {
  register_code(PV_LP);
  register_code(PV_LH);
  register_code(PV_LR);
  register_code(PV_O);
  register_code(PV_RF);
  unregister_code(PV_LP);
  unregister_code(PV_LH);
  unregister_code(PV_LR);
  unregister_code(PV_O);
  unregister_code(PV_RF);
}

// Send PHROBG ({PLOVER:LOOKUP}).
void plover_lookup(void) {
  register_code(PV_LP);
  register_code(PV_LH);
  register_code(PV_LR);
  register_code(PV_O);
  register_code(PV_RB);
  register_code(PV_RG);
  unregister_code(PV_LP);
  unregister_code(PV_LH);
  unregister_code(PV_LR);
  unregister_code(PV_O);
  unregister_code(PV_RB);
  unregister_code(PV_RG);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case QWERTY:
      if (record->event.pressed) {
        set_single_persistent_default_layer(BASE_QWERTY_LAYER);
      }
      return false;
    case COLEMAK:
      if (record->event.pressed) {
        set_single_persistent_default_layer(BASE_COLEMAK_LAYER);
      }
      return false;
    case LOWER:
      if (record->event.pressed) {
        layer_on(LOWER_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      } else {
        layer_off(LOWER_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      }
      return false;
    case RAISE:
      if (record->event.pressed) {
        layer_on(RAISE_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      } else {
        layer_off(RAISE_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      }
      return false;
    case STENO:
      if (record->event.pressed) {
#ifdef AUDIO_ENABLE
        stop_all_notes();
        PLAY_SONG(plover_song);
#endif
        layer_off(RAISE_LAYER);
        layer_off(LOWER_LAYER);
        layer_off(KEYBOARD_LAYER);
        layer_on(STENO_LAYER);
        if (!eeconfig_is_enabled()) {
          eeconfig_init();
        }
        keymap_config.raw = eeconfig_read_keymap();
        keymap_config.nkro = 1;
        eeconfig_update_keymap(keymap_config.raw);
        plover_resume();
      }
      return false;
    case PV_EXIT:
      if (record->event.pressed) {
#ifdef AUDIO_ENABLE
        PLAY_SONG(plover_gb_song);
#endif
        plover_suspend();
        layer_off(STENO_LAYER);
      }
      return false;
    case PV_LOOK:
      if (record->event.pressed) {
        plover_lookup();
      }
      return false;
    case SEND_VERSION:
      if (record->event.pressed) {
        SEND_STRING(QMK_KEYBOARD "/" QMK_KEYMAP "@" QMK_VERSION " (" QMK_BUILDDATE ")");
      }
      return false;
    case SEND_MAKE:
      if (record->event.pressed) {
        SEND_STRING("make " QMK_KEYBOARD ":" QMK_KEYMAP ":dfu\n");
      }
      return false;
  }
  return true;
}


