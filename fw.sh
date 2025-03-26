#!/bin/bash

con=1 

while [ $con -eq 1 ]
do

echo "Enter 0 to save tables and exit"
echo "Enter 1 to block incoming ips"
echo "Enter 2 to display the table"
echo "Enter 3 to delete a rule"
read -p "Enter what you would like the program to do: " input

case $input in 
    0)
        echo "Saving and exiting"
        /sbin/iptables-save
        con=0
        ;;

    1)
        echo "Enter 1 to block one ip"
        echo "Enter 2 to block a /24 range (XXX.XXX.XXX.0)"
        echo "Enter 3 to block a /16 range (XXX.XXX.0.0)"
        echo "Enter 4 to block a /8 range (XXX.0.0.0)"
        read -p "Enter your choice: " blockchoice

        case $blockchoice in
        1)
            read -p "Enter the first octet: " oct1
            read -p "Enter the second octet: " oct2
            read -p "Enter the third octet: " oct3
            read -p "Enter the fourth octet: " oct4
            echo "Blocking incoming $oct1.$oct2.$oct3.$oct4"
            iptables -A INPUT -s $oct1.$oct2.$oct3.$oct4 -j DROP
            ;;

        2)
            read -p "Enter the first octet: " oct1
            read -p "Enter the second octet: " oct2
            read -p "Enter the third octet: " oct3
            echo "Blocking incoming $oct1.$oct2.$oct3.0/24"
            iptables -A INPUT -s $oct1.$oct2.$oct3.0/24 -j DROP
            ;;

        3)
            read -p "Enter the first octet: " oct1
            read -p "Enter the second octet: " oct2
            echo "Blocking incoming $oct1.$oct2.0.0/16"
            iptables -A INPUT -s $oct1.$oct2.0.0/16 -j DROP
            ;;

        4)
            read -p "Enter the first octet: " oct1
            echo "Blocking incoming $oct1.0.0.0/8"
            iptables -A INPUT -s $oct1.0.0.0/8 -j DROP
            ;;

        *)
            echo "Not valid choice retrning to main menu"
            ;;

        esac

        ;;
    2)
        iptables -L -v -n --line-numbers
        ;;

    3)
        echo "Enter 1 to choose from INPUT"
        echo "Enter 2 to choose from OUTPUT"
        echo "Enter 3 to choose from FORWARD"
        read -p "What section would you like to delete a rule from: " chainchoice

        case $chainchoice in 
        1)
            iptables -L INPUT --line-numbers
            read -p "What is the line number you want to remove: " lnin
            iptables -D INPUT $lnin 
            ;;

        2)
            iptables -L OUTPUT --line-numbers
            read -p "What is the line number you want to remove: " lnout
            iptables -D OUTPUT $lnout
            ;;

        3)
            iptables -L FORWARD --line-numbers
            read -p "What is the line number you want to remove: " lnfw
            iptables -D FORWARD $lnfw
            ;;

        *)
            echo "You chose someything not lsited returning to main script."
            ;;

        esac
        ;;

    *)
        echo "!!-- Please choose something from the list --!!"
        ;;

esac

done