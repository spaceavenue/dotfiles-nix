''
  #!/usr/bin/env bash
  for i in {1..5}
  do
      text=$(curl -s "https://wttr.in/$1?format=1" | sed 's/[^0-9°C.-]//g')
      if [[ $? == 0 ]]
      then
          tooltip=$(curl -s "https://wttr.in/$1?format=4" | sed -E "s/\s+/ /g")
          if [[ $? == 0 ]]
          then
              echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
              exit
          fi
      fi
      sleep 2
  done
  echo "{\"text\":\"error\", \"tooltip\":\"error\"}"
''
