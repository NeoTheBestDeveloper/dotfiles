/* user and group to drop privileges to */
static const char *user  = "oleg";
static const char *group = "oleg";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#5E81AC",   /* during input */
	[FAILED] = "#BF616A",   /* wrong password */
};


/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* time in seconds before the monitor shuts down */
static const int monitortime = 5;

/* Enable blur */
#define BLUR

/* Set blur radius */
static const int blurRadius = 15;

/* Enable Pixelation */
// #define PIXELATION

/* Set pixelation radius */
static const int pixelSize = 0;

/* default message */
static const char *message = "Don't touch my pc.";

/* text color */
static const char *text_color = "#ECEFF4";

/* text size (must be a valid size) */
static const char *font_name = "Fira Code Nerd Font:size:pixelsize=48:antialias=true:autohint=true:style=Retina";
