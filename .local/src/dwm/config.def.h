/* My Programms */
#define BROWSER "qutebrowser"
#define TERM "st"
#define EDITOR "nvim"
#define TERM_CLASS "qutebrowser"

/* Theme */
static char normfgcolor[] = "#E5E9F0";
static char normbgcolor[] = "#2E3440";
static char normbordercolor[] = "#3B4252";
static char selfgcolor[] = "#E5E9F0";
static char selbgcolor[] = "#81A1C1";
static char selbordercolor[] = "#5E81AC";
static char block1fg[] = "#FFFFFF";
static char block2fg[] = "#FFFFFF";
static char block3fg[] = "#FFFFFF";
static char block4fg[] = "#FFFFFF";
static char block5fg[] = "#FFFFFF";
static char block6fg[] = "#FFFFFF";

/* appearance */
static unsigned int borderpx = 0; /* border pixel of windows */
static Gap default_gap = {.isgap = 1, .realgap = 10, .gappx = 20};
static unsigned int snap = 32; /* snap pixel */
static int showbar = 1;        /* 0 means no bar */
static int topbar = 1;         /* 0 means bottom bar */
static int user_bh = 36; /* 0 means that dwm will calculate bar height, >= 1
                            means dwm will user_bh as bar height */

static char *colors[][3] = {
    [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor},
    [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor},
    [SchemeBlock1] = {block1fg, normbgcolor, normbordercolor},
    [SchemeBlock2] = {block2fg, normbgcolor, normbordercolor},
    [SchemeBlock3] = {block3fg, normbgcolor, normbordercolor},
    [SchemeBlock4] = {block4fg, normbgcolor, normbordercolor},
    [SchemeBlock5] = {block5fg, normbgcolor, normbordercolor},
    [SchemeBlock6] = {block6fg, normbgcolor, normbordercolor},
};

/* Fonts */
static const char *fonts[] = {
    "Fira Code Nerd Font "
    "Mono:size=10:antialias=true:autohint=true:style=Retina",
    "JoyPixels:pixelsize=20:antialias=true:autohint=true"};

/* tagging */
static const char *tags[] = {"", "", "", "", "ﴬ", "", "ﱘ", ""};

static const Rule rules[] = {
    /* class      		instance    	title       tags mask isfloating
       monitor */
    {"librewolf", NULL, NULL, 1 << 3, 0, -1},
    {"Virt-manager", NULL, NULL, 1 << 7, 0, -1},
    {"TelegramDesktop", NULL, NULL, 1 << 5, 0, -1},
    {"Chromium", NULL, NULL, 1 << 3, 0, -1},
    {"Navigator", NULL, NULL, 1 << 3, 0, -1},
    {"obsidian", NULL, NULL, 1 << 4, 0, -1},
    {"qutebrowser", NULL, NULL, 1 << 1, 0, -1},
};

/* layout(s) */
static float mfact = 0.55;  /* factor of master area size [0.05..0.95] */
static int nmaster = 1;     /* number of clients in master area */
static int resizehints = 1; /* 1 means respect size hints in tiled resizals */
static int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
    {"normbgcolor", STRING, &normbgcolor},
    {"normbordercolor", STRING, &normbordercolor},
    {"normfgcolor", STRING, &normfgcolor},
    {"selbgcolor", STRING, &selbgcolor},
    {"selbordercolor", STRING, &selbordercolor},
    {"selfgcolor", STRING, &selfgcolor},
    {"block1fg", STRING, &block1fg},
    {"block2fg", STRING, &block2fg},
    {"block3fg", STRING, &block3fg},
    {"block4fg", STRING, &block4fg},
    {"block5fg", STRING, &block5fg},
    {"block6fg", STRING, &block6fg},
    {"borderpx", INTEGER, &borderpx},
    {"snap", INTEGER, &snap},
    {"showbar", INTEGER, &showbar},
    {"topbar", INTEGER, &topbar},
    {"nmaster", INTEGER, &nmaster},
    {"resizehints", INTEGER, &resizehints},
    {"mfact", FLOAT, &mfact},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
    {MODKEY, KEY, view, {.ui = 1 << TAG}},                                     \
        {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},             \
        {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                      \
        {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
    {                                                                          \
        .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                   \
    }

#define STATUSBAR "dwmblocks"

/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu_run", "-m", dmenumon, NULL};
static const char *termcmd[] = {TERM, NULL};

static Key keys[] = {
    /* modifier                     key        function        argument */
    {MODKEY, XK_p, spawn, {.v = dmenucmd}},
    {MODKEY, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_q, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_space, zoom, {0}},
    {MODKEY, XK_f, togglefullscr, {0}},
    {MODKEY | ShiftMask, XK_f, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8){MODKEY, XK_minus, setgaps, {.i = -5}},
    {MODKEY, XK_equal, setgaps, {.i = +5}},
    {MODKEY | ShiftMask, XK_minus, setgaps, {.i = GAP_RESET}},
    {MODKEY | ShiftMask, XK_equal, setgaps, {.i = GAP_TOGGLE}},
    {MODKEY | ShiftMask, XK_q, quit, {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument
     */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button1, sigstatusbar, {.i = 1}},
    {ClkStatusText, 0, Button2, sigstatusbar, {.i = 2}},
    {ClkStatusText, 0, Button3, sigstatusbar, {.i = 3}},
    {ClkStatusText, 0, Button4, sigstatusbar, {.i = 4}},
    {ClkStatusText, 0, Button5, sigstatusbar, {.i = 5}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
