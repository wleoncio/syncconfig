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

# Defining percentages
pctfat=$((9 * $fat * 100 / $total))
pctcarbs=$((4 * $carbs * 100 / $total))
pctfiber=$((2 * $fiber * 100 / $total))
pctprotein=$((4 * $protein * 100 / $total))

# Defining colors for output
lowcarb=15
highcarb=45
if [ $pctcarbs -le $lowcarb ]
then
	carbcolor="\e[32m"
elif [ $pctcarbs -ge $highcarb ]
then
	carbcolor="\e[31m"
else
	carbcolor="\e[33m"
fi

# Output
echo -e "\e[0mTotal energy: $total kcal"
echo "From fat:     $pctfat %"
echo -e ""$carbcolor"From carbs:   $pctcarbs %\e[0m"
if [ "$fiber" -gt 0 ]
then
	echo "From fiber:    $pctfiber %"
fi
echo "From protein: $pctprotein %"

