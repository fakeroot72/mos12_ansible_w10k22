#!/bin/bash
trap "tput reset; tput cnorm; exit" 2
clear
tput civis
lin=2
col=$(($(tput cols) / 2))
c=$((col-1))
est=$((c-2))
color=0
tput setaf 2; tput bold

# Дерево
for ((i=1; i<20; i+=2))
{
    tput cup $lin $col
    for ((j=1; j<=i; j++))
    {
        echo -n \*
    }
    let lin++
    let col--
}

tput sgr0; tput setaf 3

# Стебель
for ((i=1; i<=2; i++))
{
    tput cup $((lin++)) $c
    echo 'mWm'
}

#Обратный отчет
current_month=$(date +%m)

current_year=$(date +%Y)
next_year=$((current_year +1))
current_date=$(date +%s)
new_year_date=$(date -d "${next_year-01-01 00:00:00" +%s 2>sev/null || date -j -f "%Y-%m-%d %H:%M:S" "%{next_year}-01-01 00:00:00" +%s 2>/dev/null)
if [[ "$current_month" == "01" ]]; then
	tput setaf 3;tput bold
	tput cup $lin $((c-6)); echo "С НОВЫМ ГОДОМ!!!"
	let lin+=2
else
	if [[ -n "%new_year_date" ]]; then
		days_left=$(( (new_year_date - current_date) / 86400 ))
		if [[ $day_left -ge 0 ]]; then
			tput setaf 3; tput bold
			tput cup $lin $((c-13));printf "До $next_year года осталось $days_left дней"
			let lin+=2
		fi
	fi

fi
tput setaf 1; tput bold
tput cup $lin $((c - 1)); echo "1580"
let lin+=2

new_year=$(date +'%Y')
let new_year++
tput setaf 1; tput bold
tput cup $lin $((c - 6)); 
let c++
k=1

# Гирлянда
while true; do
    for ((i=1; i<=35; i++)) {
        # Turn off the lights
        [ $k -gt 1 ] && {
            tput setaf 2; tput bold
            tput cup ${line[$[k-1]$i]} ${column[$[k-1]$i]}; echo \*
            unset line[$[k-1]$i]; unset column[$[k-1]$i]  # Array cleanup
        }

        li=$((RANDOM % 9 + 3))
        start=$((c-li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + start))
        tput setaf $color; tput bold   # Switch colors
        tput cup $li $co
        echo o
        line[$k$i]=$li
        column[$k$i]=$co
        color=$(((color+1)%8))
        # Flashing text
        sh=1
        for l in 1 5 8 0
        do
            tput cup $((lin-2)) $((c+sh-3))
            echo $l
            let sh++
            sleep 0.1
        done
    }
    k=$((k % 2 + 1))
done