#!/bin/bash
echo "Player x,Player o,"> results.csv
for (( c=1; c<=100; c++ ))
do  
   swipl ../othello.pl<game.txt > result.txt
   grep "Player . --" result.txt | cut -d ":" -f 2 | tr '\n' ',' >> results.csv
   printf '\n' >> results.csv
done
