#Script per l'apertura di un file di testo specificato dall'utente
#!/bin/bash
echo "Hi! with this script you are able to do some operation about a tex file"
echo "please choose you operation"

function copyFile {
	echo "put the destionation directory"
		read directory
		cp $fileName $directory
		if [ $? == 0 ]; then
		#there are no errors
		echo "$fileName copied"
	fi
}

function checkFile {
	checkResult=0
	if [ ! -f $1 ]; then
		if [ $2 == false ]; then
			echo "the specified file not exist. Do you want to create it? Y/N"
			read response
			positive="Y"
			if [ $response == $positive ]; then 
				> $1
				echo "$1 created"
				checkResult=1
			else
				echo "file not created"
				echo "File non created. Copy operation stopped" >> report.txt
				echo "I write down this anomaly into the report file. Do you want to see it? Y/N"
				read response
				if [ $response == $positive ]; then
					gedit report.txt &
					wmctrl -a gedit
				fi
			fi
		fi
	else
		echo "The file already exist"
		checkResult=1
	fi
	return $checkResult
}

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
		checkFile $fileName
		fileExist=$?
		if [  $fileExist == 1 ]; then
			copyFile
		else
			echo "Not able to copy file"
		fi;;
		3)
		echo "put the current file name"
		read oldName
		checkFile $oldName
		chekResult=$?
		if [ $chekResult == 1 ]; then
			echo "put the new file name"
			read newName
			mv $oldName $newName
			if [ $? == 0 ]; then
				echo "file name updated"
			fi
		else
			echo "Not able to rename file"
		fi;;
		4)
		echo "put the file name you want remove"
		read fileName
		removeOperation=true
		checkFile $fileName $removeOperation
		chekResult=$?
		if [ $checkResult == 1 ]; then
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
			fi
		else
			echo "The specified file not exist. I'm not able to delete it"
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
