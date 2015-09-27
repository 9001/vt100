#!/bin/bash
#
# rainbow.sh v1.0
# Display all 256 colours
# BSD-Licensed, 2015-08-31, ed <irc.rizon.net>
# https://github.com/9001/shit
#
function ae()
{
	tmp="$(echo -ne "$2")"
	#declare $1=$tmp
	eval $1=\$tmp
}
ae dark '\033[38;5;232m'
ae lite '\033[38;5;255m'

[ "x$1" == "x" ] &&
	inv='' ||
	inv='y'

[ ! $inv ] &&
{
	echo 'No arguments, setting foreground'
	ae rest '\033[22;39m'
	t=3
} || {
	t=4
	ae rest '\033[0m'
	echo 'Got argument, setting background'
}

echo -ne "$lite\n               bright base   "
for m in {0..1}
do
	for n in {0..7}
	do
		v=$(( m + 3 ))
		echo -ne "\033[1;${v}${n}m $n "
	done
	echo -n "$rest "
	[ ! $inv ] && break
	echo -n "$lite"
done

echo -ne "$rest\n               normal base   "
for m in {0..1}
do
	for n in {0..7}
	do
		v=$(( m + 3 ))
		echo -ne "\033[${v}${n}m $n "
	done
	echo -n "$rest "
	[ ! $inv ] && break
	echo -n "$lite"
done

echo -ne "\n\n  "
for y in {0..11}
do
	fg="$lite"
	[ $y -gt 1 ] && [ $y -lt 10 ] && fg="$dark"
	for x in {0..17}
	do
						 cell=1
		[ $x -gt  5 ] && cell=2
		[ $x -gt 11 ] && cell=3
		
						   v=$(( x +  16 ))
		[ $cell -eq 2 ] && v=$(( x +  82 ))
		[ $cell -eq 3 ] && v=$(( x + 148 ))
		
		[ $y -lt 6 ] &&
			v=$(( v + 6 * y )) ||
			v=$(( v + 30 + 6 * ( 12 - y ) ))
		
		[ $x -eq 5 ] || [ $x -eq 11 ] &&
			p="$rest  " || p=''

		[ $cell -eq 1 ] &&
		{
			fg="$lite"
			[ $y -gt 2 ] && [ $y -lt 9 ] &&
			{
				[ $y -ne 8 ] || [ $x -gt 0 ] &&
					fg="$dark"
			}
		}
		[ $cell -eq 2 ] &&
		{
			fg="$lite"
			[ $y -gt 1 ] && [ $y -lt 11 ] &&
			{
				[ $y -ne 10 ] || [ $x -gt 6 ] &&
					fg="$dark"
			}
		}
		[ $cell -eq 3 ] &&
		{
			fg="$lite"
			[ $y -gt 0 ] &&
			{
				[ $y -ne 11 ] || [ $x -gt 12 ] &&
					fg="$dark"
			}
		}
		[ ! $inv ] && fg=''

		printf "%s\033[%d8;5;%dm %3d%s" "$fg" "$t" "$v" "$v" "$p"
	done
	echo -ne "$rest\n  "
done
echo -ne "\n\n   $lite"

for n in {232..255}
do
	[ $n -lt 244 ] && v=$n ||
		v=$(( 256 - ( n - 243 ) ))
	
	echo -ne "\033[${t}8;5;${v}m  $v "
	
	[ $n -eq 243 ] &&
	{
		echo -ne "$rest\n\n   "
		[ $inv ] &&
			echo -ne "$dark"
	}
done
echo -e "$rest"

