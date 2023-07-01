#!/bin/bash
i=1
finish=$(($(date +%S)+$1))
echo "вы запустили таймер на $1 секунд"
while [ $i -le $1 ]
do
echo "осталось: $(($1 - $i)) секунд. Прошло $i секунд"
((i++))
sleep 1
done
