#!/bin/bash
# Calculates dates

increment="$1 $2"

# Calculate date
date=$4
if [ -z $date ]; then
  dateymd=\"$(date "+%Y-%m-%d")\"
else
  dateymd=\"$date\"
fi

# format $date as yyyy-mm-dd, if necessary

operation=$(qalc $dateymd + $increment)
echo "Operation: $operation"
echo ""

# Trimming out quotation marks
new_date=$(echo $operation | cut --delimiter="=" --fields=2 | tr -d '"')
dateymd=$(echo $dateymd | tr -d '"')

# Retrieve month and year from new date
year_date=$(echo $dateymd | cut --delimiter="-" --fields=1)
month_date=$(echo $dateymd | cut --delimiter="-" --fields=2)
year_date_new=$(echo $new_date | cut --delimiter="-" --fields=1)
month_date_new=$(echo $new_date | cut --delimiter="-" --fields=2)

# Display date on calendar
ncal -wH $dateymd $month_date $year_date
echo ""
ncal -wH $new_date $month_date_new $year_date_new
