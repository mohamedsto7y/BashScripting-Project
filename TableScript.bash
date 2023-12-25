#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob

cd ./DatabaseFolder/$DBname
echo you are connected to $DBname Database

select Tkey in "Create Table" "List Tables" "Drop Tables" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Exit to Databases Menu"
do
case $Tkey in
"Create Table")
	read -p "Create Table name " TableName
	case $TableName in
	+([a-zA-Z_]))
		if [ -e ./$TableName ]
		then
		echo $TableName Already Created
		else
		touch $TableName
		echo $TableName Created Successfuly
		
		
		read -p "write the number of columns " number
		i=1
		while [[ $i -lt  $number ]]
		do
		read -p "write the name of the column " col
		echo -n $col: >> $TableName
		
		i=$i+1
		done

		while [[ $i -eq  $number ]]
		do
		read -p "write the name of the column " col
		echo $col >> $TableName
		i=$i+1
		done
		
		i=1

		while [[ $i -lt  $number ]]
		do
		select key in "INTEGAR" "STRING"
		do
		case $key in
			"INTEGAR")
			echo -n INTEGAR: >> $TableName
			echo Choose the next DataType
			break;
				;;
			"STRING")
			echo -n STRING: >> $TableName
			echo Choose the next DataType
			break;
				;;
				*)
			echo Uncorrect choice
			;;
		esac
		done
		i=$i+1
		done

		while [[ $i -eq  $number ]]
		do
		select key in "INTEGAR" "STRING"
		do
		case $key in
			"INTEGAR")
			echo INTEGAR >> $TableName
			echo DataTypes Added
			break;
				;;
			"STRING")
			echo STRING >> $TableName
			echo DataTypes Added
			break;
				;;
				*)
			echo Uncorrect choice
			;;
		esac
		done
		i=$i+1
		done
		fi
		;;
		*)
	echo Choose a suitable name
	;;
	esac
;;


"List Tables")
	ls -F 
;;
"Drop Tables")
	read -p "write the name of the Table to Delete " TableName
	case $TableName in
	+([a-zA-Z_]))
		if [ -e ./$TableName ]
		then
		rm -i ./$TableName
		else
		echo wrong Table name
		fi
		;;
		*)
	echo wrong format
	;;
	esac
;;
"Insert into Table")
	read -p "write the name of the Table to insert " TableName
	case $TableName in
	+([a-zA-Z_]))
		if [ -e ./$TableName ]
		then
		number=($(head -1 $TableName | sed 's/[^:]//g' | wc -c))
		i=1
		while [[ $i -lt  $number ]]
		do
		read -p "insert Data " ins
		echo -n $ins: >> $TableName
		
		i=$i+1
		done

		while [[ $i -eq  $number ]]
		do
		read -p "insert Data " ins
		echo $ins >> $TableName
		i=$i+1
		echo "Data inserted"
		done
		fi
		;;
		*)
	echo wrong format
	;;
	esac
;;
"Select From Table")
	select TSelect in "Select by column" "Select All" "Return"
	do
	case $TSelect in
	"Select by column")
		read -p "Enter the name of the Table u want to select " TableName
		case $TableName in
		+([a-zA-Z_]))
		if [ -e ./$TableName ]
		then
			read -p "Enter the Column Name " ColW
			awk '
			BEGIN{
				FS = ":"; 
			}
			{	
				i=1;
				while (i <= NF){
				if($i=="'$ColW'"){
				j=i
				}
				i=i+1;
				}
				print $j
			}
			END{
			}
			' $TableName
		else
		echo wrong Table name
		fi
		;;
		*)
	echo wrong format
	;;
	esac
	;;
	"Select All")
	read -p "Enter the name of the Table u want to select " TableName
	case $TableName in
	+([a-zA-Z_]))
		if [ -e ./$TableName ]
		then
			cat $TableName
		else
		echo wrong Table name
		fi
		;;
	*)
	echo wrong format
	;;
	esac
	;;
	"Return")
	break;
	;;
	esac
	done	
;;

"Delete From Table")
    select TDelete in "Specific Delete" "Delete All inserted Data" "Return"
    do
        read -p "Enter the name of the Table you want to delete from: " TableName
        case $TDelete in
        "Specific Delete")
            read -p "Enter the number of the Row: " RowN
            sed -i "${RowN}d" "$TableName"
            ;;
        "Delete All inserted Data")
            sed -i '3,$d' "$TableName"
            ;;
        "Return")
            break
            ;;
        esac
    done
;;
"Update Table")
	select TUpdate in "Update all the same words" "Return"
	do
	read -p "Enter the name of the Table do u want to Update " TableName
	case $TUpdate in
	"Update all the same words")
	read -p "Enter the name of the word u want to change " SrcReplace
	read -p "Edited word " DesReplace
	sed -i 's/'$SrcReplace'/'$DesReplace'/g' $TableName
	break;
	;;
	"Return")
	cd ..																	
	break;
	;;
	esac
	done
;;
"Exit to Databases Menu")
break;
;;
esac
done