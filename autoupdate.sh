#!/bin/sh
upgradable=$(cli -c "app query name,upgrade_available" | grep true)
upgradable=$(echo "$upgradable" | sed 's/[|]//g' | cut -c 2- | sed 's/true//g')
echo "$upgradable"

if [ -z "$upgradable" ]
then
  echo "no updates available"
else
  echo "$upgradable" | while IFS= read -r line; do cli -c "app upgrade \"$line\"" & echo "updating $line"; done
fi
