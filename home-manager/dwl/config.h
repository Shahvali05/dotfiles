#define COLOR(hex) { ((hex >> 24) & 0xFF) / 255.0f, ((hex >> 16) & 0xFF) / 255.0f, ((hex >> 8) & 0xFF) / 255.0f, (hex & 0xFF) / 255.0f }

/* appearance */
static const int sloppyfocus = 1; /* focus follows mouse */
static const int bypass_surface_visibility = 0; /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const unsigned int borderpx = 1; /* border pixel of windows */
static const unsigned int gappih = 10; /* horiz inner gap between windows */
static const unsigned int gappiv = 10; /* vert inner gap between windows */
static const unsigned int gappoh = 10; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov = 10; /* vert outer gap between windows and screen edge */
static const int smartgaps = 0; /* 1 means no outer gap when there is only one window */
static const float rootcolor[] = COLOR(0x222222ff);
static const float bordercolor[] = COLOR(0x444444ff);
static const float focuscolor[] = COLOR(0x005577ff);
static const float urgentcolor[] = COLOR(0xff0000ff);
static const float fullscreen_bg[] = {0.1f, 0.1f, 0.1f, 1.0f};

/* tagging */
#define TAGCOUNT (9)
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

/* rules */
static const Rule rules[] = {
    /* app_id     title       tags_mask     isfloating   monitor scratchkey x    y    width height */
    /* example:
    { "Gimp",     NULL,       0,            1,           -1,      0,         0,   0,   500,  400 },
    { "firefox",  NULL,       1 << 8,       0,           -1,      0,        200, 100, 0,    0 },
    */
};

/* layouts */
static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",      tile },    /* first entry is default */
    { "><>",      NULL },    /* no layout function means floating behavior */
    { "[M]",      monocle },
};

/* monitor rules */
static const MonRule monrules[] = {
    /* name    mfact nmaster scale layout transform x y */
    { "default", 0.55f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1 },
};

/* keyboard */
static XkbRules xkb_rules = {
    .rules = NULL,
    .model = NULL,
    .layout = NULL,
    .variant = NULL,
    .options = NULL,
};
static const int repeat_rate = 25;
static const int repeat_delay = 600;

/* trackpad */
static LibinputConfigTrackpad trackpad_config = {
    .tap_to_click = 1,
    .tap_and_drag = 1,
    .drag_lock = 1,
    .natural_scrolling = 0,
    .disable_while_typing = 1,
    .left_handed = 0,
    .middle_button_emulation = 0,
    .scroll_method = LIBINPUT_CONFIG_SCROLL_2FG,
    .click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS,
    .send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED,
    .accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE,
    .accel_speed = 0.0,
    .button_map = LIBINPUT_CONFIG_TAP_MAP_LRM,
};

/* key definitions */
#define MODKEY WLR_MODIFIER_ALT
static const char *termcmd[] = { "alacritty", NULL };
static const char *menucmd[] = { "wmenu-run", NULL };

static const Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XKB_KEY_p, spawn,          {.v = menucmd } },
    { MODKEY,                       XKB_KEY_q, quit,           {0} },
    { MODKEY,                       XKB_KEY_Return, spawn,      {.v = termcmd } },
    { MODKEY,                       XKB_KEY_b, togglebar,      {0} },
    { MODKEY,                       XKB_KEY_j, focusstack,     {.i = +1 } },
    { MODKEY,                       XKB_KEY_k, focusstack,     {.i = -1 } },
    { MODKEY,                       XKB_KEY_h, setmfact,       {.f = -0.05f} },
    { MODKEY,                       XKB_KEY_l, setmfact,       {.f = +0.05f} },
    { MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_j, rotatestack,    {.i = +1 } },
    { MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_k, rotatestack,    {.i = -1 } },
    { MODKEY,                       XKB_KEY_u, incnmaster,     {.i = +1 } },
    { MODKEY,                       XKB_KEY_i, incnmaster,     {.i = -1 } },
    { MODKEY,                       XKB_KEY_o, togglefloating, {0} },
    { MODKEY,                       XKB_KEY_t, setlayout,      {.ui = &layouts[0] } },
    { MODKEY,                       XKB_KEY_f, setlayout,      {.ui = &layouts[1] } },
    { MODKEY,                       XKB_KEY_m, setlayout,      {.ui = &layouts[2] } },
    { MODKEY,                       XKB_KEY_space, view,       {.ui = ~0 } },
    { MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_space, toggletag,  {.ui = ~0 } },
    { MODKEY,                       XKB_KEY_comma, view,       {.ui = 1 << 7 } },
    { MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_comma, toggletag,  {.ui = 1 << 7 } },
    { MODKEY,                       XKB_KEY_period, view,      {.ui = 1 << 8 } },
    { MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_period, toggletag, {.ui = 1 << 8 } },
    /* Добавленные привязки для устранения предупреждений */
    { MODKEY,                       XKB_KEY_f, togglefullscreen, {0} }, /* Полноэкранный режим */
    { MODKEY,                       XKB_KEY_t, tag,            {.ui = 1 << 0} }, /* Переключение тэга */
    { MODKEY,                       XKB_KEY_m, tagmon,         {.i = +1} }, /* Переключение монитора */
    { MODKEY,                       XKB_KEY_c, killclient,     {0} }, /* Закрытие клиента */
    { MODKEY,                       XKB_KEY_n, focusmon,       {.i = +1} }, /* Фокус на мониторе */
    { MODKEY,                       XKB_KEY_v, chvt,           {.i = 1} }, /* Смена виртуального терминала */
    TAGKEYS(                        XKB_KEY_1, XKB_KEY_9,      1, 9 ),
};

/* button definitions */
static const Button buttons[] = {
    /* modifier                     button detail function        argument */
    { MODKEY,                       BTN_LEFT,   moveresize,     {.ui = CurMove} },
    { MODKEY,                       BTN_MIDDLE, togglefloating, {0} },
    { MODKEY,                       BTN_RIGHT,  moveresize,     {.ui = CurResize} },
};
