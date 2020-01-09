function fish_prompt
  echo (tput bold)(tput setaf 1)\[(tput setaf 3)(whoami)(tput setaf 2)\@(tput setaf 4)(hostname)\ (tput setaf 5)(pathalias)(tput setaf 1)\](tput setaf 7)\$\ (tput sgr0)
  #echo $PS1
end

function fish_greeting
end
