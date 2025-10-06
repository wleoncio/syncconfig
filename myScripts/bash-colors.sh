# Shell color and font formatting options for import

# Regular Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BLACK='\033[0;30m'

# Bold
BOLD='\033[1m'
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_MAGENTA='\033[1;35m'
BOLD_CYAN='\033[1;36m'
BOLD_WHITE='\033[1;37m'

# Underline
UNDERLINE='\033[4m'
UNDERLINE_RED='\033[4;31m'
UNDERLINE_GREEN='\033[4;32m'
UNDERLINE_YELLOW='\033[4;33m'
UNDERLINE_BLUE='\033[4;34m'
UNDERLINE_MAGENTA='\033[4;35m'
UNDERLINE_CYAN='\033[4;36m'
UNDERLINE_WHITE='\033[4;37m'

# Background Colors
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_MAGENTA='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'
BG_BLACK='\033[40m'

# Reset
RESET='\033[0m'

# Functions for easy printing
cecho() {
    # Usage: cecho "$RED" "Your message"
    local color="$1"
    shift
    echo -e "${color}$*${RESET} Back to normal"
}

cprintf() {
    # Usage: cprintf "$BOLD_GREEN" "Your message"
    local color="$1"
    shift
    printf "${color}%s${RESET} Back to normal" "$*"
    echo
}

# --- Test script for color and format options ---
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo -e "${BOLD}BOLD${RESET} | ${UNDERLINE}UNDERLINE${RESET} | ${BOLD}${UNDERLINE}BOLD+UNDERLINE${RESET}"
    echo
    echo -e "${RED}RED${RESET} | ${GREEN}GREEN${RESET} | ${YELLOW}YELLOW${RESET} | ${BLUE}BLUE${RESET} | ${MAGENTA}MAGENTA${RESET} | ${CYAN}CYAN${RESET} | ${WHITE}WHITE${RESET} | ${BLACK}BLACK${RESET}"
    echo -e "${BOLD_RED}BOLD_RED${RESET} | ${BOLD_GREEN}BOLD_GREEN${RESET} | ${BOLD_YELLOW}BOLD_YELLOW${RESET} | ${BOLD_BLUE}BOLD_BLUE${RESET} | ${BOLD_MAGENTA}BOLD_MAGENTA${RESET} | ${BOLD_CYAN}BOLD_CYAN${RESET} | ${BOLD_WHITE}BOLD_WHITE${RESET}"
    echo -e "${UNDERLINE_RED}UNDERLINE_RED${RESET} | ${UNDERLINE_GREEN}UNDERLINE_GREEN${RESET} | ${UNDERLINE_YELLOW}UNDERLINE_YELLOW${RESET} | ${UNDERLINE_BLUE}UNDERLINE_BLUE${RESET} | ${UNDERLINE_MAGENTA}UNDERLINE_MAGENTA${RESET} | ${UNDERLINE_CYAN}UNDERLINE_CYAN${RESET} | ${UNDERLINE_WHITE}UNDERLINE_WHITE${RESET}"
    echo -e "${BG_RED}BG_RED${RESET} | ${BG_GREEN}BG_GREEN${RESET} | ${BG_YELLOW}BG_YELLOW${RESET} | ${BG_BLUE}BG_BLUE${RESET} | ${BG_MAGENTA}BG_MAGENTA${RESET} | ${BG_CYAN}BG_CYAN${RESET} | ${BG_WHITE}BG_WHITE${RESET} | ${BG_BLACK}BG_BLACK${RESET}"
    echo
    cecho "$BOLD_YELLOW" "cecho: This is a bold yellow warning!"
    cprintf "$UNDERLINE_BLUE" "cprintf: This is underlined blue info!"
fi
