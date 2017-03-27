#!/bin/bash
s='trunk'
d='applerelease'

promptValue() {
    read -p "$1:" input </dev/tty
    echo $input
}

function cmd_CPR
{
    echo "Do you want to move the file $1 > $2? (Y/N) (default: Y) __"
    YN=$(promptValue "Enter Y/N")
    if [[ $YN == y ]]; then
        cp -rf $1 $2
    fi
}

function cmd_CP
{
    echo "Do you want to move the file $1 > $2? (Y/N) (default: Y) __"
    YN=$(promptValue "Enter Y/N")
    if [[ $YN == y ]]; then
        echo "CMD>> mv $1 $2"
        rm $2 && cp $1 $2
    else
        echo 'NO'
    fi
}

while IFS='' read -r line || [[ -n "$line" ]]; do
    case $line in
        *apple-release* )
            f=${line:33}
            ;;
        *trunk* )
            f=${line:16}
            ;;
    esac
    l=$s/$f r=$d/$f
    if [[ -e $l ]] && [[ -e $r ]]; then
        file_type=${l#*.}
        if [[ $file_type == 'cs' ]]; then
            echo "CMD>> BCompare $s/$f $d/$f"
            BCompare $s/$f $d/$f
        elif [[ $file_type == 'prefab' ]]; then
            cmd_CP $l $r
        fi
    elif [[ -ne $r ]] && [[ -e $l ]]; then
        if [[ -d $l ]]; then
            cmd_CPR $l $r
        else
            cmd_CPR $l $r
        fi
    else
        echo "**Error No Source File [$l] **"
    fi
done < ./tmp
