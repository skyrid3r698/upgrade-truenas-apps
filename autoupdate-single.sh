#!/bin/sh
app=plex

function exists_in_list() {
    LIST=$1
    VALUE=$2
    echo $LIST | grep -F -q "$VALUE"
}

upgradable=$(cli -c "app chart_release query name,update_available")
upgradable=$(echo "$apps" | sed 's/[-+|]//g' | sed 's/name//g' | sed 's/update_available//g' | sed '/strue//g' | sed -r '/^\s*$/d' | sed '/false/d')
echo -e "$upgradable"

if exists_in_list "$upgradable" "$app"; then
    echo "updating $app"
    cli -c "app chart_release upgrade release_name=$app"
else
    echo "no updates available for $app"
fi

