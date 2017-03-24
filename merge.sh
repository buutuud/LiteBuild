#!/bin/bash
s='trunk'
d='applerelease'

promptValue() {
    read -p "$1:" input </dev/tty
    echo $input
}

function cmd_A
{
    echo "Do you want to move the file $1 > $2? (Y/N) (default: Y) __"
    YN=$(promptValue "Enter Y/N")
    if [[ $YN == Y ]]; then
        cp $1 $2
    fi
}

function cmd_MV
{
    echo "Do you want to move the file $1 > $2? (Y/N) (default: Y) __"
    YN=$(promptValue "Enter Y/N")
    if [[ $YN == Y ]]; then
        echo "CMD>> mv $1 $2"
        rm $2 && cp $1 $2
    else
        echo 'NO'
    fi
}

while IFS='' read -r line || [[ -n "$line" ]]; do
    f=${line:16}
    l=$s/$f r=$d/$f
    if [[ -e $l ]] && [[ -e $r ]]; then
        file_type=${l#*.}
        if [[ $file_type == 'cs' ]]; then
            echo "CMD>> BCompare $s/$f $d/$f"
            BCompare $s/$f $d/$f
        elif [[ $file_type == 'prefab' ]]; then
            cmd_MV $l $r
        fi
    elif [[ -ne $r ]] && [[ -e $l ]]; then
        cmd_A $l $r
    else
        echo "**Error No Source File [$l] **"
    fi
done < ./tmp
