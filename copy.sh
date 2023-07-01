#!/bin/bash
mkdir /root/home/
cp /etc/shadow /root/home/neshadow
res=$(grep root* /root/home/neshadow)
echo "$res"
