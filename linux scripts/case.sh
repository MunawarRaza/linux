#!/bin/bash

function1(){
echo "Apple is very energatic"
}
function2(){

echo "KiWI is not more energatict"
}

read -p "Enter Fruit Name:  " FRUIT
#FRUIT="kiwi"

case "${FRUIT}" in

apple) function1
;;
kiwi) echo "kiwi is not energatic"
;;
esac