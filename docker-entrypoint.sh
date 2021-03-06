#!/bin/sh

if [ -f ~/.profile ] ; then 
  source ~/.profile
fi

if [ $1 = "start" ] ; then
  if [ -z "$PASSWORD" ] || [ "$PASSWORD" == "" ] ; then
    export PASSWORD="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 15 ; echo '')"
    echo "export PASSWORD="$PASSWORD >> ~/.profile
  fi

  sed -i 's/_PASSWORD_/'"$PASSWORD"'/g' /usr/local/etc/3proxy/3proxy.cfg
  sed -i 's/_USER_/'"$USER"'/g' /usr/local/etc/3proxy/3proxy.cfg

  echo "---------------------------------------------------------------------------------"
  echo "Proxy user login:         $USER"
  echo "Proxy user password:      $PASSWORD"
  echo "---------------------------------------------------------------------------------"
  exec /usr/local/bin/3proxy /usr/local/etc/3proxy/3proxy.cfg
else 
  echo $@
fi