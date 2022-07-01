// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", "echo ' 📻 '$(status_radio)", 5, 16},
    {"", "echo $(status_mpc)", 5, 15},
    {"", "status_time", 60, 13},
    {"", "echo $(status_volume)'  '", 1, 14},
};

// sets delimeter between status commands. NULL character ('\0') means no
// delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
