#!/bin/bash

#for f in *\ *; do mv "$f" "${f// /_}"; done

for f in ./*.PDF
do
    pdftotext -layout -enc UTF-8 -q "$f" derp.txt;
    cat derp.txt | awk -F'[ \t]' 'match($0,"Navn:"){print $0}' | awk '{$1=""; print $0}' > navn.txt;
    cat derp.txt | awk -F'[ \t]' 'match($0,"CPR-nr.:"){print $0}' | awk '{$1=""; print $0}' > cpr.txt;
    cat derp.txt | awk 'match($0,"Afgivende selskab"){seen=1}seen{print $0}' | head -n 2 | tail -n 1 | awk 'sub(" A/S",""){seen=1}{print}' > afgivende.txt;
    cat derp.txt | awk -F': ' 'match($0, "selskab/pengeinstitut")' | awk '{$1=$2=$3=$4=""; print $0}' | sed 's/ //g' > policenummer.txt
    value1=`cat navn.txt | sed 's/ //'`
    value2=`cat cpr.txt`
    value3=`cat afgivende.txt`
    value4=`cat policenummer.txt`
    mv "$f" "$value1$value2 overf. fra $value3 $value4.PDF";
    
done

#rm *.txt






