#!/bin/bash
# Provides official UiO colors + some effects

# Effects
reset="\033[0m"
bold="\033[1m"
dim="\033[2m"
underlined="\033[4m"

# UiO Colors from https://www.uio.no/om/designmanual/profilelementer/fargepalett/index.html
svart="\033[38;2;0;0;0m"
svart_bg="\033[48;2;0;0;0m"
graa="\033[38;2;178;179;183m"
graa_bg="\033[48;2;178;179;183m"
blaa="\033[38;2;62;49;214m"
blaa_bg="\033[48;2;62;49;214m"
lysblaa="\033[38;2;134;164;247m"
lysblaa_bg="\033[48;2;134;164;247m"
blaatone="\033[38;2;230;236;255m"
blaatone_bg="\033[48;2;230;236;255m"
groenn="\033[38;2;46;196;131m"
groenn_bg="\033[48;2;46;196;131m"
lysgroenn="\033[38;2;108;225;171m"
lysgroenn_bg="\033[48;2;108;225;171m"
groenntone="\033[38;2;206;255;223m"
groenntone_bg="\033[48;2;206;255;223m"
roed="\033[38;2;222;0;0m"
roed_bg="\033[48;2;222;0;0m"
lysroed="\033[38;2;251;102;102m"
lysroed_bg="\033[48;2;251;102;102m"
roedtone="\033[38;2;254;224;224m"
roedtone_bg="\033[48;2;254;224;224m"
oransje="\033[38;2;254;161;27m"
oransje_bg="\033[48;2;254;161;27m"
lysoransje="\033[38;2;253;203;135m"
lysoransje_bg="\033[48;2;253;203;135m"
oransjetone="\033[38;2;255;232;212m"
oransjetone_bg="\033[48;2;255;232;212m"
gul="\033[38;2;255;254;167m"
gul_bg="\033[48;2;255;254;167m"

# Extra colors
hvit="\033[38;2;255;255;255m"
hvit_bg="\033[48;2;255;255;255m"

# Demo (works when running the script directly instead of sourcing it)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	colors=("$graa $blaa $lysblaa $blaatone $groenn $lysgroenn $groenntone $roed $lysroed $roedtone $oransje $lysoransje $oransjetone $gul")
	colors_bg=("$graa_bg $blaa_bg $lysblaa_bg $blaatone_bg $groenn_bg $lysgroenn_bg $groenntone_bg $roed_bg $lysroed_bg $roedtone_bg $oransje_bg $lysoransje_bg $oransjetone_bg $gul_bg")
	for fg in $colors; do
		echo -e ${fg}Universitetet i Oslo $reset
	done
	for bg in $colors_bg; do
		echo -e ${svart}${bg}Universitetet i Oslo $reset
	done
fi
