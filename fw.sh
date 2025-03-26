con=1 
clear
echo "This script is for me so that i dont need to remeber iptables commands"
while [ $con -eq 1 ]
do
echo "Enter 0 to save tables and exit"

read -p "Enter what you would like the program to do: " input

case $input in 
    0)
        echo "saving and exiting"
        echo "/sbin/iptables-save <remove in final>"
        con=0
        ;;
    *)
        clear
        echo "!!-- please choose something from the list --!!"
        ;;
esac
done