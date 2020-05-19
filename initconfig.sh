#!/bin/bash
IP=""
ENTRY=""
BASE_IP="10.147.214";
ip_dialog () {
  while ((!IP)); do
    IP=`zenity --entry --title="Número IP" --window-icon="info"`;
  done
  echo "Selected IP: $BASE_IP.$IP"
}

proxy_dialog () {
  while ((!ENTRY)); do
    ENTRY=`zenity --password --username --title="Dados Proxy" --window-icon="info"`
  done
  USERNAME=`echo $ENTRY | cut -d'|' -f1`
  echo "User Name: `echo $ENTRY | cut -d'|' -f1`"
  PASSWORD=`echo $ENTRY | cut -d'|' -f2`
  echo "Password : `echo $ENTRY | cut -d'|' -f2`"
}

main () {
  ip_dialog
  proxy_dialog
}

main
exit