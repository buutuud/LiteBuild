#!/bin/bash
s='trunk'
d='applerelease'

function cmd_A
{
    unset dorm
    echo "Do you want to move the file $1 > $2? (Y/N) (default: Y) __"
    read dorm
    echo $dorm
    dorm=${dorm:=Y}
    if [[ $dorm -eq Y ]]; then
        cp $1 $2
    fi
}

while IFS='' read -r line || [[ -n "$line" ]]; do
    f=${line:16}
    l=$s/$f r=$d/$f
    if [[ -e $l ]] && [[ -e $r ]]; then
        echo "BCompare $s/$f $d/$f"
        BCompare $s/$f $d/$f
    elif [[ -ne $r ]] && [[ -e $l ]]; then
        cmd_A $l $r
    else
        echo "**Error No Source File [$l] **"
    fi
done < ./tmp
