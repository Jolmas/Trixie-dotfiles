#!/bin/bash
# ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮
# │ R ││ A ││ D ││ I ││ O ││ N │
# ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯
#A bash script written by Christos Angelopoulos, October 2023, under GPL v2

function random_station
{
 rand_max_lim=$(grep -v -E ^$ "$1"|grep -v -E ^// |wc -l)
 rand_station_index=$((1 + $RANDOM % $rand_max_lim))
 STATION=$(grep -v -E ^$ "$1"|grep -v -E ^// |head -$rand_station_index|tail +$rand_station_index|awk '{print $2}'|sed 's/-/ /g;s/~//g')
 STATION_URL="$(grep ~${STATION// /-}~ "$1"|awk '{print $1}')"

}

function keybindings ()
{
 echo -e "  ${B}╭─────┬──────────╮"
 echo -e "  ${B}│${M}  ␣  ${B}│${C}    Pausa ${B}│"
 echo -e "  ${B}├─────┼──────────┤"
 echo -e "  ${B}│${M} 9 0 ${B}│${C}   ↑↓ Vol ${B}│"
 echo -e "  ${B}├─────┼──────────┤"
 echo -e "  ${B}│${M}  m  ${B}│${C}     Silencio ${B}│"
 echo -e "  ${B}├─────┼──────────┤"
 echo -e "  ${B}│${M} ← → ${B}│${C} Saltar 10\"${B} │"
 echo -e "  ${B}├─────┼──────────┤"
 echo -e "  ${B}│${M} ↑ ↓ ${B}│${C} Saltar 60\"${B} │"
 echo -e "  ${B}├─────┼──────────┤"
 echo -e "  ${B}│${M}  q  ${B}│${R}     Salir ${B}│"
 echo -e "  ${B}╰─────┴──────────╯${M}"
}

function play_station ()
{
 clear
 print_logo
 if [[ $SHOW_MPV_KEYBINDINGS == "yes" ]]; then keybindings;fi
 echo -e "${B}ESTACION: ${Y}$STATION${n}"
 echo -e "${B}URL    : ${C}$STATION_URL${n}"
 mpv $STATION_URL
}

function print_logo ()
{
 echo -e "${B}    ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮"
 echo -e "    │ ${Y}R ${B}││ ${Y}A ${B}││ ${Y}D ${B}││ ${Y}I ${B}││ ${Y}O ${B}││ ${Y}N ${B}│"
 echo -e "    ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯${n}"
}

function load_config ()
{
 if [[ "$OSTYPE" == "darwin"* ]]; then
  URL_OPENER="open"
 else
  URL_OPENER="xdg-open"
 fi
 PREF_SELECTOR="$(grep 'Preferred_selector' $HOME/.config/radion/radion.conf|awk '{print $2}')";
 FZF_FORMAT="$(grep 'fzf_format' $HOME/.config/radion/radion.conf|sed 's/fzf_format//;s/|//')";
 ROFI_FORMAT="$(grep 'rofi_format' $HOME/.config/radion/radion.conf|sed 's/rofi_format//;s/|//')";
 DMENU_FORMAT="$(grep 'dmenu_format' $HOME/.config/radion/radion.conf|sed 's/dmenu_format//;s/|//')";
 PREF_EDITOR="$(grep 'Preferred_editor' $HOME/.config/radion/radion.conf|sed 's/Preferred_editor//')";
 if [[ $PREF_SELECTOR == "rofi" ]]
 then PREF_SELECTOR_STR="$ROFI_FORMAT"
 elif [[ $PREF_SELECTOR == "fzf" ]]
 then PREF_SELECTOR_STR="$FZF_FORMAT"
 elif [[ $PREF_SELECTOR == "dmenu" ]]
 then PREF_SELECTOR_STR=""$DMENU_FORMAT""
 fi;
 PROMPT_TEXT="$(grep 'Prompt_text' $HOME/.config/radion/radion.conf|sed 's/Prompt_text//;s/|//')";
 SHOW_MPV_KEYBINDINGS="$(grep 'Show_mpv_keybindings' $HOME/.config/radion/radion.conf|awk '{print $2}')";
 SHOW_EMOJIS="$(grep 'Show_emojis' $HOME/.config/radion/radion.conf|awk '{print $2}')";
 if [[ $SHOW_EMOJIS == "yes" ]];then J_STAR="⭐";J_TAG="";J_PREF="";J_EDIT="📋";J_FIND="🔍";J_QUIT="";J_BACK="👈";PAD="";else J_STAR="";J_TAG="";J_PREF="";J_EDIT="";J_FIND="";J_QUIT="";J_BACK="";PAD="  ";fi;
 main
}

function read_select_station ()
{
 LOOP2=0
 ABORT=0
 while [[ $LOOP2 -eq 0 ]]
 do
 clear
  print_logo
  echo -e "${Y}$TAG${n}"

  LINE=1
  LINEMAX=$(cat /tmp/radion_select_tag.txt|wc -l)
  echo -e "   ${B}╭─────────────────────Estaciones─╮"
  RAND_LINE="   │ ${M}0${G} Aleatoria ${Y}"${TAG//#/}"${G} Estación                      "
  echo -e "${RAND_LINE:0:76}${B}│"
  while [[ $LINE -le $LINEMAX ]]
  do
   PRINT_LINE="   │ ${M}$LINE ${C}$(head -$LINE /tmp/radion_select_tag.txt|tail +$LINE|awk '{print $2"                          "}'|sed 's/-/ /g;s/~//g')"
   echo -e "${PRINT_LINE:0:56}${B}│"
   ((LINE++))
  done
  echo -e "   ├────────────────────────────────┤"
  echo -e "   │${M} X${R}  "${J_BACK}" Atrás     $PAD               ${B}│"
  echo -e "   │${M} Q${R}  "${J_QUIT}" Salir      $PAD               ${B}│"
  echo -e "   ├────────────────────────────────┤"
  echo -e "   │${G} Teclée el número de estación: ${B} │"
  echo -e "   ╰────────────────────────────────╯${M}"

  read  INDEX
  INDEX_NUM="$(echo $INDEX|sed 's/[[:cntrl:]]//g;s/[a-z]//g;s/[A-Z]//g;s/[[:punct:]]//g;s/ //g')"
  if [[ $INDEX == "Q" ]]||[[ $INDEX == "q" ]];then clear;exit
  elif [[ $INDEX == "X" ]]||[[ $INDEX == "x" ]];then LOOP2=1;ABORT=1
  elif [[ -n $INDEX_NUM ]]&&[[ $INDEX_NUM -gt 0 ]]&&[[ $INDEX_NUM -le $LINEMAX ]]&&[[ $ABORT -eq 0 ]]
  then
   STATION_URL="$(awk '{print NR" "$0}' /tmp/radion_select_tag.txt|grep -E "^$INDEX_NUM "|awk '{print $2}')"
   STATION="$(awk '{print NR" "$0}' /tmp/radion_select_tag.txt|grep -E "^$INDEX_NUM "|awk '{print $3}'|sed 's/-/ /g;s/~//g')"
   play_station
   LOOP2=1
  elif [[ -n $INDEX_NUM ]]&&[[ $INDEX_NUM -eq 0 ]]
  then
  random_station "/tmp/radion_select_tag.txt"
  play_station
  LOOP2=1
  fi
 done
}

function read_select_tag ()
{
 LOOP1=0
 while [[ $LOOP1 -eq 0 ]]
 do
  clear
  print_logo
  TAGS=( $(sed 's/ /\n/g' $HOME/.config/radion/stations.txt |grep "#"|grep -v "#Favoritas"|sort|uniq|sed 's/#//g') )
  FAVS=( $(grep "#Favoritas" $HOME/.config/radion/stations.txt|grep -v -E ^$|grep -v -E ^//|awk {'print $2'}|sed 's/~//g') )
  f=0
  t=0
  echo -e "   ${B}╭────────────────────Estaciones─╮"
  echo -e "   │   "${M}"0"${G}" Estaciones aleatorias     "${B}"│"
  while [[ $f -lt ${#FAVS[@]} ]]
  do
  FAVLINE="   │  ${M} $((t+f+1))${Y} ${FAVS[f]//-/ }                                  "
  echo -e "${FAVLINE:0:55}${B}│"
   ((f++))
 done

  echo -e "${B}   ├─────────────────────Etiquetas─┤"
  while [[ $t -lt ${#TAGS[@]} ]]
  do
   TAGLINE="   │  ${M} $((t+f+1))${C} ${TAGS[t]}                                  "
   echo -e "${TAGLINE:0:55}${B}│"
   ((t++))
  done
  echo -e "   ├──────────────────────Acciones─┤"
  echo -e "   │   ${M}A${G}  "${J_STAR}" Todas las Estaciones $PAD ${B}│"
  echo -e "   │   ${M}E${G}  "${J_EDIT}" Editar Estaciones    $PAD ${B}│"
  echo -e "   │   ${M}P${G}  "${J_PREF}" Preferencias          $PAD ${B}│"
  echo -e "   │   ${M}D${G}  "${J_FIND}" Buscar Estaciones    $PAD ${B}│"
  echo -e "   │   ${M}Q${R}  "${J_QUIT}" Salir                 $PAD ${B}│"
  echo -e "   ├───────────────────────────────┤"
  echo -e "   │${G} Teclée número/letra:          ${B}│"
  echo -e "   ╰───────────────────────────────╯${M}"
  read TAG_INDEX
  TAG_INDEX_NUM="$(echo $TAG_INDEX|sed 's/[[:cntrl:]]//g;s/[a-z]//g;s/[A-Z]//g;s/[[:punct:]]//g;s/ //g')"
  if [[ $TAG_INDEX == "E" ]]||[[ $TAG_INDEX == "e" ]];then eval $PREF_EDITOR $HOME/.config/radion/stations.txt
  elif [[ $TAG_INDEX == "P" ]]||[[ $TAG_INDEX == "p" ]];then eval $PREF_EDITOR $HOME/.config/radion/radion.conf;load_config
  elif [[ $TAG_INDEX == "Q" ]]||[[ $TAG_INDEX == "q" ]];then clear;exit
  elif [[ $TAG_INDEX == "A" ]]||[[ $TAG_INDEX == "a" ]]||[[ $TAG_INDEX == "" ]];then  TAG=":"; echo -e "${Y} "${J_STAR}" Todas las Estaciones${n}";grep -v -E ^$ $HOME/.config/radion/stations.txt|grep -v -E ^// >/tmp/radion_select_tag.txt;LOOP1=1
  elif [[ $TAG_INDEX == "D" ]]||[[ $TAG_INDEX == "d" ]];then $URL_OPENER "https://www.radio-browser.info/tags" ;echo -e "${R}NOTICE:\n${B}Presione una tecla para continuar con radion.${n}";read -sn 1 d
  elif [[ -n $TAG_INDEX_NUM ]]&&[[ $TAG_INDEX_NUM -eq 0 ]]
  then
   random_station "$HOME/.config/radion/stations.txt"
   play_station
  elif [[ -n $TAG_INDEX_NUM ]]&&[[ $TAG_INDEX_NUM -gt 0 ]]&&[[ $TAG_INDEX_NUM -le $f ]]
  then
  STATION=${FAVS[$(($TAG_INDEX_NUM-1))]}
  STATION_URL="$(grep ~${STATION// /-}~ $HOME/.config/radion/stations.txt|awk '{print $1}')"
  play_station
  elif [[ -n $TAG_INDEX_NUM ]]&&[[ $TAG_INDEX_NUM -gt $f ]]&&[[ $TAG_INDEX_NUM -le $(($t+$f)) ]]
  then
   TAG="#${TAGS[$(($TAG_INDEX_NUM-$f-1))]}"
   grep $TAG $HOME/.config/radion/stations.txt >/tmp/radion_select_tag.txt
   LOOP1=1
  fi
 done
}

function select_tag ()
{
 LOOP1=0
 while [[ $LOOP1 -eq 0 ]]
 do
 clear
  print_logo
  if [[ $PREF_SELECTOR == fzf ]]
  then
   TAG_INDEX="$(echo -e "${B}──────────────────────  "${J_STAR}" Favoritas\n${G}Estación Aleatoria\n${Y}$(grep "#Favoritas" $HOME/.config/radion/stations.txt|grep -v -E ^$|grep -v -E ^//|awk {'print $2'}|sed 's/-/ /g;s/~//g')"${n}"\n${B}──────────────────────  "${J_TAG}" Etiquetas\n${C}$(sed 's/ /\n/g' $HOME/.config/radion/stations.txt |grep "#"|grep -v "#Favoritas"|sort|uniq|sed 's/#//g;s/$//g')${n}\n${B}──────────────────────  "${J_PREF}" Acciones\n${G} "${J_STAR}" Todas las Estaciones\n "${J_EDIT}" Editar Estaciones\n "${J_PREF}" Preferencias\n "${J_FIND}" Buscar Estaciones\n${R} "${J_QUIT}" Salir${n}"|eval "$PREF_SELECTOR_STR""\"$PROMPT_TEXT\"" )"
  elif [[ $PREF_SELECTOR == "dmenu" ]]||[[ $PREF_SELECTOR == "rofi" ]]
  then
   TAG_INDEX="$(echo -e "──────────────────────  "${J_STAR}" Favoritas\nEstación Aleatoria\n$(grep "#Favoritas" $HOME/.config/radion/stations.txt|grep -v -E ^$|grep -v -E ^//|awk {'print $2'}|sed 's/-/ /g;s/~//g')""\n──────────────────────  "${J_TAG}" Tags\n$(sed 's/ /\n/g' $HOME/.config/radion/stations.txt |grep "#"|grep -v "#Favoritas"|sort|uniq|sed 's/#//g;s/$//g')\n──────────────────────  "${J_PREF}" Acciones\n "${J_STAR}" Todas las Estaciones\n "${J_EDIT}" Editar Estaciones\n "${J_PREF}" Preferencias\n "${J_FIND}" Buscar Estaciones\n "${J_QUIT}" Salir"|eval "$PREF_SELECTOR_STR""\"$PROMPT_TEXT\"" )"
  fi
  if [[ $TAG_INDEX == " "${J_EDIT}" Edit Stations" ]];then eval $PREF_EDITOR $HOME/.config/radion/stations.txt
  elif [[ $TAG_INDEX == "Estación Aleatoria" ]];then random_station "$HOME/.config/radion/stations.txt";play_station
  elif [[ $TAG_INDEX == " "${J_PREF}" Preferencias" ]];then eval $PREF_EDITOR $HOME/.config/radion/radion.conf;load_config
  elif [[ $TAG_INDEX == " "${J_QUIT}" Salir" ]];then clear;exit
  elif [[ $TAG_INDEX == " "${J_STAR}" Todas las Estaciones" ]]||[[ $TAG_INDEX == "" ]];then  TAG=":"; echo -e "${Y} "${J_STAR}" Todas las Estaciones${n}";LOOP1=1
  elif [[ $TAG_INDEX == " "${J_FIND}" Buscar Estaciones" ]];then $URL_OPENER "https://www.radio-browser.info/tags" ;echo -e "${R}NOTICE:\n${B}Presione una teclaa para continur con radion.${n}";read -sn 1 d
  elif [[ $TAG_INDEX == *"────────────"* ]];then LOOP1=0
  #echo -e "${C}Congratulations.\nYou selected the separator line.\nA wise choise.\n${B}Press any key to continue.${n}";read -sn 1 d
  elif [[ -n $(grep "~${TAG_INDEX// /-}~" $HOME/.config/radion/stations.txt|awk '{print $1}') ]]
  then
  STATION=$TAG_INDEX
  STATION_URL="$(grep ~${STATION// /-}~ $HOME/.config/radion/stations.txt|awk '{print $1}')"
  play_station
  else TAG="#$TAG_INDEX";echo -e "${Y}$TAG${n}";LOOP1=1;fi
 done
}

function select_station ()
{
 if [[ $PREF_SELECTOR == fzf ]]
 then
  STATION="$(echo -e "${G}Estación Aleatoria\n${Y}$(grep "$TAG" $HOME/.config/radion/stations.txt|grep -v -E ^$|grep -v -E ^//|awk {'print $2'}|sed 's/-/ /g;s/~//g')\n${B}────────────────────────\n${G} "${J_BACK}" Atrás\n "${J_QUIT}" Salir"|eval "$PREF_SELECTOR_STR""\"Seleccionar ${TAG//#/} Estación \"")"
 elif [[ $PREF_SELECTOR == "dmenu" ]]||[[ $PREF_SELECTOR == "rofi" ]]
 then
  STATION="$(echo -e "Estación Aleatoria\n$(grep "$TAG" $HOME/.config/radion/stations.txt|grep -v -E ^$|grep -v -E ^//|awk {'print $2'}|sed 's/-/ /g;s/~//g')\n────────────────────────\n "${J_BACK}" Atrás\n "${J_QUIT}" Salir"|eval "$PREF_SELECTOR_STR""\"Seleccionar ${TAG//#/} Estación \"")"
 fi
 #STATION="$(echo -e "$(grep "$TAG" $HOME/.config/radion/stations.txt|grep -v -E ^$|grep -v -E ^//|awk {'print $2'}|sed 's/-/ /g;s/~//g')\n────────────────────────\n "${J_BACK}" Go Back\n "${J_QUIT}" Quit Radion"|eval "$PREF_SELECTOR_STR""\"Select $TAG Station \"")"
 if [[ $STATION == " "${J_QUIT}" Salir" ]];then clear;exit
 elif [[ $STATION == " "${J_BACK}" Atrás" ]];then STATION=""
 elif [[ $STATION == "Estación Aleatoria" ]]
 then
  rand_max_lim=$(grep "$TAG" $HOME/.config/radion/stations.txt|grep -v -E ^$|grep -v -E ^//|wc -l)
  rand_station_index=$((1 + $RANDOM % $rand_max_lim))
  STATION=$(grep -v -E ^$ $HOME/.config/radion/stations.txt|grep -v -E ^//|grep "$TAG" |head -$rand_station_index|tail +$rand_station_index|awk '{print $2}'|sed 's/-/ /g;s/~//g')
  STATION_URL="$(grep ~${STATION// /-}~ "$HOME/.config/radion/stations.txt"|awk '{print $1}')"
  play_station
 else
  STATION_URL="$(grep ~${STATION// /-}~ $HOME/.config/radion/stations.txt|awk '{print $1}')"
  play_station
 fi
}

function main ()
{
 while true
 do
  if [[ $PREF_SELECTOR == "read" ]]
  then
   read_select_tag
   read_select_station
  else
   select_tag
   select_station
  fi
  clear
 done
}
###############################################

B="\x1b[38;5;242m" #Grid Color
Y="\033[1;33m"     #Yellow
G="\033[1;32m"     #Green
I="\e[7m"          #Invert
R="\033[1;31m"     #Red
M="\033[1;35m"     #Magenta
C="\033[1;36m"     #Cyan
n=`tput sgr0`      #Normal
export B Y G I R M C n #in order to work with fzf
if [[ -e $HOME/.config/mpv/icyhistory.log ]]&&[[ $(cat $HOME/.config/mpv/icyhistory.log|wc -l) -gt 1000 ]]
 then
  tail -500 $HOME/.config/mpv/icyhistory.log >/tmp/icytemp.log&&mv /tmp/icytemp.log $HOME/.config/mpv/icyhistory.log
 fi #keep icyhistory.log under 1000 at each start.
load_config
