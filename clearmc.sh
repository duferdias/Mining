#!/bin/bash
while : ; do
  # Usa um arquivo de lock para impedir execução simultânea,
  # caso a execução leve muito tempo.
  if [[ ! -e /tmp/lockfile ]]; then
    touch /tmp/lockfile
    {
      sync; echo 3 > /proc/sys/vm/drop_caches
      # sysctl -w vm.drop_caches=3
      rm /tmp/lockfile
    } & # Note o "&" para execução em background.
  fi
  sleep 360
done
