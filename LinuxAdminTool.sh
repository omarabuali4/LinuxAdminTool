#!/bin/bash
clear -x
echo ""
echo " ░▒▓██████▓▒░ ░▒▓████████▓▒░ ░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ "
echo "░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo "░▒▓█▓▒░░▒▓█▓▒░     ░▒▓██▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo "░▒▓█▓▒░░▒▓█▓▒░   ░▒▓██▓▒░   ░▒▓████████▓▒░ ░▒▓██████▓▒░  "
echo "░▒▓█▓▒░░▒▓█▓▒░ ░▒▓██▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo "░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo " ░▒▓██████▓▒░ ░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo ""
echo ""


while true; do
#----------------------------(1)-User------------------------------

echo -e "1- User\n2- Group\n3- File\n4- Process\n5- Exit\n"
read -p "Enter your choise: " choise
case $choise in
1 )
PS1='Please enter your choice: '
options=( "Create a new user" 
"delete a user"
"change password"
"add a user to a group"
"delete a user from a group"
"list who is currently logged in"
"change permission of a user"
"list groups of a user"
"Block a User"
"Count the number of users in the system"
"Generate a strong random password for a user"
"Return to a previous menu."
 )
select opt in "${options[@]}"
do
    case $opt in
"Create a new user" )
read -p "Enter user name: " username
sudo useradd $userName
echo " $userName Added !"
;;

"delete a user" )
read -p "Enter The username: " username
echo "Are u sure ? (y/n): " delUser
if [[ $delUser == "y" ]];then
userdel -r $username
else
userdel $username
fi
echo " $username deleted !"
;;

"change password" )
read -p "Enter username u wont to change the passwd for  : " username
passwd $username
;;

"add a user to a group" )
read -p "Enter username: " username
read -p "Enter group name to add: " groupname
usermod -a -G $groupname $username
;;

"delete a user from a group" )
read -p "Enter username: " username
read -p "Enter group name to delete: " groupname
gpasswd --delete $username $groupname
echo "$username removed from $groupname successfully"
;;
"change permission of a user"  )
who
;;
"list who is currently logged in" )
read -p "Enter the file name for which you wanted to change user permissions: " filename
read -p "Enter username: " username
chown $username $filename
;;

 "list groups of a user")
read -p "Enter username: " username
groups $username
;;
 "Block a User" )
read -p "Enter username: " username
passwd -l $username
;;
"Count the number of users in the system"  )
who | wc -l
;;
"Generate a strong random password for a user")
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo
;;
"Return to a previous menu." )
clear
break
;;
* )
echo "Invalid option"
continue
;;

esac
done
;;
#----------------------------(2)-group------------------------------
2 )
PS1='Please enter your choice: '
options=( "Add a group" 
"delete a group"
"List groups"
"Add a user to a group"
"delete a user from a group"
"list members of a group"
"Return to a previous menu."
 )
select opt in "${options[@]}"
do
    case $opt in

"Add a group")
read -p "Enter group name: " groupname
groupadd $groupname
echo "Done!"
;;

"delete a group" )
read -p "Enter group name: " groupname
groupdel $groupname
echo " $groupname Deleted ! "
;;

"List groups" )
getent group | cut -d: -f1
;;

"Add a user to a group" )
read -p "Enter user name: " username
read -p "Enter group name to which you want to add user: " groupname
usermod -a -G $groupname $username
echo "User $userName added to $groupname"
;;

"delete a user from a group" )
read -p "Enter username: " username
read -p "Enter group name from which you want to delete user: " groupname
gpasswd --delete $username $groupname
echo "$username removed from $groupname successfully"
;;
"list members of a group" )
read -p "Enter group name: " groupname
cat /etc/group | grep "^$groupname" | cut -d: -f4
;;

"Return to a previous menu." )
clear
break
;;

* )
echo "Invalid option."
;;

esac
done
;;

3 )
#----------------------------(3)-File-------Done----------------------
PS2='Please enter your choice: '
options=( "count words of a file" 
"count characters of a file"
"compute word average length by dividing the number of characters by the number of words in a file."
"count lines of a file."
"display set of rows from the beginning of a file."
"change permission for a file"
"Return to a previous menu."
 )
select opt in "${options[@]}"
do
    case $opt in

"count words of a file" )
read -p "Enter file name: " filename
echo "Number of words in file $filename is: $(wc -w $filename | cut -d" " -f1)"
;;

"count characters of a file" )
read -p "Enter file name: " filename
echo "Number of characters in file $filename is: $(wc -c $filename | cut -d" " -f1)"
;;

"compute word average length by dividing the number of characters by the number of words in a file." )
read -p "Enter file name: " filename
chars=$(wc -c $filename | cut -d" " -f1)
words=$(wc -w $filename | cut -d" " -f1)
echo "Word average length for file $filename is: $(echo $chars $words | awk '{print $1/$2}')"
;;

"count lines of a file." )
read -p "Enter file name: " filename
echo "Number of lines: $(wc -l $filename | cut -d' ' -f1)"
;;

"display set of rows from the beginning of a file." )
read -p "Enter file name: " filename
read -p "Enter range of lines to show (eg. (1,4)): " range
eval sed -n "${range}p" $fileName
;;

"change permission for a file" )
read -p "Enter file name to which you wanted to change permissions: " filename
read -p "Enter permissions you wanted to change to file: " permissions
chmod $permissions $fileName
;;

"Return to a previous menu." )
clear
break
;;

* )
echo "Invalid option."
;;
esac
done
;;

4 )
#----------------------------(3)-Process----------Done--------------------
PS3='Please enter your choice: '
options=( "Run a program in the foreground." 
"Run a program in the background."
"Run a program with a specific priority."
"Change the priority of a program (process)."
"Kill a program (process)."
"display the status of some program (process)."
"Return to a previous menu."
 "Quit")
select opt in "${options[@]}"
do
    case $opt in
# --------------------------1--------------------------------------

        "Run a program in the foreground.")
echo -e "\e[1;31m !--------Warning dont try the commands insid the terminal bcz we have problems with running it here just look at the commands you want to use alone by open the secript using any text editor------! \e[0m "
# the command ./secript.sh &
;;

        "Run a program in the background.")
echo -e "\e[1;31m !--------Warning dont try the commands insid the terminal bcz we have problems with running it here just look at the commands you want to use alone by open the secript using any text editor------! \e[0m "
# ./secript.sh &
;;

        "Run a program with a specific priority.")
echo -e "\e[1;31m !--------Warning dont try the commands insid the terminal bcz we have problems with running it here just look at the commands you want to use alone by open the secript using any text editor------! \e[0m "
#command
;;

        "Change the priority of a program (process).")
echo -e "\e[1;31m !--------Warning dont try the commands insid the terminal bcz we have problems with running it here just look at the commands you want to use alone by open the secript using any text editor------! \e[0m "
#read -p "Enter process ID: " ProcessID
#renice -n 5 -p $ProcessID 32
;;
        "Kill a program (process).")
echo -e "\e[1;31m !--------Warning dont try the commands insid the terminal bcz we have problems with running it here just look at the commands you want to use alone by open the secript using any text editor------! \e[0m "
#  pkill -n
#  ./secript.sh  & 
# jobs
# read -p "Enter process ID: " IDDD
# kill -9 $IDDD


;;
        "display the status of some program (process).")
echo -e "\e[1;31m !--------Warning dont try the commands insid the terminal bcz we have problems with running it here just look at the commands you want to use alone by open the secript using any text editor------! \e[0m "
# ps -aux
# sleep 2
# sudo ps -a
;;

        "Return to a previous menu.")
clear
break
;;

        "Quit")
exit
;;        
* )
echo "Invalid option."
;;
esac
done
;;


5 )
clear
exit
;;


* )
echo "Invalid option"
continue
;;
esac

done