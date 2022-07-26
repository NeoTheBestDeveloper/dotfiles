static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */

static const char *fonts[] = {
    "Fira Code Nerd Font Mono:size=12:antialias=true:autohint=true:style=Retina",
	"JoyPixels:pixelsize=20:antialias=true:autohint=true",
};

static char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static char normfgcolor[] = "#E5E9F0";
static char normbgcolor[] = "#2e3440";
static char selfgcolor[]  = "#E5E9F0";
static char selbgcolor[]  = "#81A1C1";
static char normhgfgcolor[] = "#d8dee9";
static char normhgbgcolor[] = "#2e3440";
static char selhgfgcolor[]  = "#3B4252";
static char selhgbgcolor[]  = "#EBCB8B";

static char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { normfgcolor, normbgcolor },
	[SchemeSel] = { selfgcolor, selbgcolor },
	[SchemeOut] = { "#000000", "#00ffff" },
	[SchemeNormHighlight] = { normhgfgcolor, normhgbgcolor },
    [SchemeSelHighlight] = { selhgfgcolor, selhgbgcolor },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/* -h option; minimum height of a menu line */
static unsigned int lineheight = 22;
static unsigned int min_lineheight = 8;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 0;

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
	{ "normfgcolor", STRING, &normfgcolor },
	{ "normbgcolor", STRING, &normbgcolor },
	{ "normhgfgcolor", STRING, &normhgfgcolor },
	{ "normhgbgcolor", STRING, &normhgbgcolor },
	{ "selfgcolor",  STRING, &selfgcolor },
	{ "selbgcolor",  STRING, &selbgcolor },
	{ "selhgfgcolor",  STRING, &selhgfgcolor },
	{ "selhgbgcolor",  STRING, &selhgbgcolor },
};
