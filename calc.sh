#!/bin/bash

x="Addition"
y="Sub"
m="multiply"
d="divide"

echo "Enter Operation (Add, Sub, Mul, Div):"
read val

case "$val" in
	#case 1
	"Add") echo $(($1 + $2)) ;;

	#case 2
	"Sub") echo $(($1 - $2)) ;;

	#case 3
	"Mul") echo $(($1 * $2)) ;;

	#case 4
	"Div") 
		if [ $2 -ne 0 ]; then
			echo $(($1 / $2))

		else
			echo "Lavde glt hai!!!"

		fi
		;;
	#default
      	*)echo "Kuch bhi mt likh C***** 😡!!! Sahi operation daal (Add, Sub, Mul, Div)." ;;

esac



