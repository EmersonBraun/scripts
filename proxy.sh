#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

SERVER='proxy01.pmpr.parana'
PORT='8080'

function proxy_dialog () {
  ENTRY=`zenity --password --username --title="Dados Proxy" --window-icon="info"`
  USERNAME=`echo $ENTRY | cut -d'|' -f1`
  PASSWORD=`echo $ENTRY | cut -d'|' -f2`
}

function export_variables () {
  PROXY="$USERNAME:$PASSWORD@$SERVER:$PORT"
  export http_proxy=$PROXY
  export https_proxy=$PROXY
  export ftp_proxy=$PROXY
  echo -e "${GREEN}http_proxy, https_proxy and ftp_proxy configured${NC}"
}

function remove_variables () {
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  echo -e "${GREEN}http_proxy, https_proxy and ftp_proxy removed${NC}"
}

function main () {
  echo -e "${GREEN}Config proxy variables${NC}"
  if [ $1 = "on" ]; then
    proxy_dialog
    export_variables
  elif [ $1 = "off" ]; then
    remove_variables
  else
      echo -e "$1 ${RED}it's an invalid option${NC}"
      echo -e "$1 ${RED}type 'on' or 'off'${NC}"
      exit 1
  fi
}

main
exit