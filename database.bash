#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob

DATABASE_FOLDER="./DatabaseFolder"

# Ensure the database folder exists
mkdir -p "$DATABASE_FOLDER"

echo Welcome to our SQL Database

select key in "CreateDB" "ListDB" "ConnectDB" "DropDB" "Exit"
do
case $key in
"CreateDB")
    read -p "Create Database name " DBname
    case $DBname in
    +([a-zA-Z_]))
        if [ -e "$DATABASE_FOLDER/$DBname" ]
        then
        echo  "$DBname Already Created"
        else
        mkdir "$DATABASE_FOLDER/$DBname"
        echo welcome $DBname
        fi
        ;;
        *)
    echo Choose a suitable name
    ;;
    esac
    ;;
"ListDB")
    ls -F "$DATABASE_FOLDER" | grep /$
    ;;
"ConnectDB")
    read -p "write the name of the DB to connect " DBname
    case $DBname in
    +([a-zA-Z_]))
        if [ -e "$DATABASE_FOLDER/$DBname" ]
        then
        echo Connected to $DBname
        export DBname
        sh ./TableScript
        else
        echo wrong Database name
        fi
        ;;
        *)
    echo wrong format
    ;;
    esac
    ;;
"DropDB")
    read -p "write the name of the DB to Delete " DBname
    case $DBname in
    +([a-zA-Z_]))
        if [ -e "$DATABASE_FOLDER/$DBname" ]
        then
        rm -r "$DATABASE_FOLDER/$DBname"
        echo $DBname removed
        else
        echo wrong Database name
        fi
        ;;
        *)
    echo wrong format
    ;;
    esac
    ;;
"Exit")
    break;
    ;;

esac
done