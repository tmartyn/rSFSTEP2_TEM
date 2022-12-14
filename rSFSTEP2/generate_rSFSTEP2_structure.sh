#!/bin/bash
#./generate_rSFSTEP2_structure.sh <R_program> <number_of_sites> <number_of_scenario>
siteid=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40) #add site ids here

for ((i=1;i<=$2;i++));do (
	cp -r $1 R_program_$i
	cd R_program_$i
	python3 assignsiteid.py $(pwd) ${siteid[$(($i-1))]} $i
	for((j=1;j<=$3;j++));do
		cp -r STEPWAT2 Stepwat.Site.$i.$j
	done
	rm -rf STEPWAT2
	cd .. ) &
done
wait
touch jobs.txt

rm -rf R_program
wait
