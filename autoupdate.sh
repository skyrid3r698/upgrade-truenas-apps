#!/bin/sh
upgradable=$(cli -c "app query name,upgrade_available" | grep true)
upgradable=$(echo "$upgradable" | sed 's/[| ]//g' | sed 's/true//g')
echo "updates available for: $upgradable"

if [ -z "$upgradable" ]
then
  echo "no updates available"
else
  echo "$upgradable" | while IFS= read -r line; do 
    echo "updating $line"
    cli -c "app upgrade \"$line\"" 
  done
fi
