#!/bin/bash
echo "номер строки "
read number
resolt=$(sed -n "$number"p /var/log/nginx/access.log | tr -d '\n' | wc -m)

echo "количество символов = $resolt"

