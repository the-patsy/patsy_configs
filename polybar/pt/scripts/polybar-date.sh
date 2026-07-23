#!/usr/bin/env bash
 
day=$(date +%-d)
 
case $day in
  1|21|31) suffix="st" ;;
  2|22)    suffix="nd" ;;
  3|23)    suffix="rd" ;;
  *)       suffix="th" ;;
esac
 
date +"%B ${day}${suffix}, %Y %H:%M:%S" 
