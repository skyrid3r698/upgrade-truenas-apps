#!/bin/sh
upgradable=$(cli -c "app query name,upgrade_available" | grep true)
upgradable=$(echo "$upgradable" | sed 's/[| ]//g' | sed 's/true//g')
echo "updates available for: $upgradable"

if [ -z "$upgradable" ]
then
  echo "no updates available"
else
  echo "$upgradable" | while IFS= read -r line; do 
    state=$(cli -c "app query name,state" | grep $line | awk '{print $4}')
    if [ "$state" = "STOPPED" ]; then
      echo "skipping $line. Stopped apps cannot be updated!"
    else
      echo "updating $line"
      cli -c "app upgrade \"$line\""
    fi       
done

echo "All updates finished!"
fi
