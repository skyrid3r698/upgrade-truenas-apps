#!/bin/sh
upgradable=$(cli -c "app query name,update_available")
upgradable=$(echo "$upgradable" | sed 's/[-+|]//g' | sed 's/name//g' | sed 's/update_available//g' | sed 's/true//g' | sed -r '/^\s*$/d' | sed '/false/d')
echo "$upgradable"

if [ -z "$upgradable" ]
then
  echo "no updates available"
else
  echo "$upgradable" | while IFS= read -r line; do cli -c "app upgrade $line" & echo "updating $line"; done
fi
