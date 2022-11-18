#! /bin/bash
# Calculates the percentage of carb calories in food

# Evaluating input
fat=$1
carbs=$2
protein=$3
fiber=$4

# Calculating total calories
if [ -z "$fiber" ]
then
	read -p "What's the total calories (enter to auto-calculate)? " total
	if [ -n "$total" ]
	then
		subtotal=$((9 * $fat + 4 * $carbs + 4 * $protein))
		fiber=$((($total - $subtotal) / 2))
		echo "Fiber content estimated: $fiber g"
	else
		fiber=0
		total=$((9 * $fat + 4 * $carbs + 4 * $protein))
	fi
else
	total=$((9 * $fat + 4 * $carbs + 4 * $protein + 2 * $fiber))
fi

echo -e "\e[0mTotal energy: $total kcal"
echo "From fat:     $((9 * $fat * 100 / $total)) %"
echo -e "\e[1;34mFrom carbs:   $((4 * $carbs * 100 / $total)) %\e[0m"
if [ "$fiber" -gt 0 ]
then
	echo "From fiber:    $((2 * $fiber * 100 / $total)) %"
fi
echo "From protein: $((4 * $protein * 100 / $total)) %"

