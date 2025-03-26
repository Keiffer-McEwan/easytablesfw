con=1 
clear
echo "This script is for me so that i dont need to remeber iptables commands"
while [ $con -eq 1 ]
do
echo "Enter 0 to save tables and exit"
echo "Enter 1 to block incoming ips"
echo "Enter 2 to display the table"

read -p "Enter what you would like the program to do: " input

case $input in 
    0)
        echo "saving and exiting"
        /sbin/iptables-save
        con=0
        ;;
    1)
        echo "Enter 1 to block one ip"

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
        *)
            clear
            echo "no valid choice retrning to main menu"
            ;;
        esac
        ;;
    2)
        clear
        iptables -L -v -n --line-numbers
        ;;
    *)
        clear
        echo "!!-- please choose something from the list --!!"
        ;;
esac
done