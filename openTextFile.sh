#Script per l'apertura di un file di testo specificato dall'utente
#!/bin/bash
echo "Hi! with this script you are able to do some operation about a tex file"
echo "please choose you operation"

loop=true

while [ $loop == true ];
do
	echo "1 - open & modify text file"
	echo "2 - copy a text file"
	echo "3 - rename a text file"
	echo "4 - delete text file"
	read operation
	case $operation in 
		1)
		echo "put the file name please:"
		read fileName
		echo "opening $fileName"
		gedit $fileName &
		wmctrl -a gedit;;
		2)
		echo "put the file name:"
		read fileName
		echo "put the destionation directory"
		read directory
		cp $fileName $directory
		if [ $? == 0 ]; then
			#there are no errors
			echo "$fileName copied"
		fi;;
		3)
		echo "put the current file name"
		read oldName
		echo "put the new file name"
		read newName
		mv $oldName $newName
		if [ $? == 0 ]; then
			echo "file name updated"
		fi;;
		4)
		echo "put the file name you want remove"
		read fileName
		echo "You are deleting this file: $fileName"
		echo "Are you sure? Y/N"
		read response
		pos="Y"
		if [ $response == $pos ]; then
			rm $fileName
			if [ $? == 0 ]; then
				echo "file removed"
			fi
		else
			echo "operation cancelled"
		fi;;
		*)
		echo "Your choose is not available";;
	esac
	echo "Do you want continue? - Y/N"
	read response
	neg="N"
	if [ $response == $neg ]; then
		loop=false;
		echo "application closed"
	fi
done
