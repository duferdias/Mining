#!/bin/sh
clear
# --------------------------
#      LIMITADOR DE CPU
# --------------------------
# Script por Devtechm

#-----------------
bash=$(echo $BASH)

if [ "$bash" = "/bin/bash" ]
then
exit 0
fi

cpulimite=$1
cpulimit_ex=50

if [ "$1" = ""  ]
then
echo "        \033[41;1;37m Limitando o uso da CPU com CPULIMIT \033[0m"
sleep
echo "\033[34mForma de uso:\033[0m"
echo "sudo sh $0 \033[31m Porcentagem de Uso\033[32m \n"
echo "\033[34mExemplo:\033[0m"
echo "sudo sh $0 \033[31m $cpulimit_ex\033[32m \n"
exit 0
fi

echo "        \033[41;1;37m Limitando o uso da CPU com CPULIMIT \033[0m"	
sleep 1
echo "LIMITADOR DE CPU CONFIGURADO (%):\033[01;32m $cpulimite\033[0m \n"
sleep 3
clear
sudo apt-get install aptitude -y > /dev/null
sudo aptitude install cpulimit -y > /dev/null

echo "\033[37;41mAbrindo sessão, aguarde...\033[0m"
sleep 3
sudo screen -dmS cpu cpulimit -e cpuminer -l $cpulimite
sleep 2
clear

echo "\033[37;41m Uso da CPU limitado em $cpulimite% para o processo cpuminer.\033[01;0m \n"
sleep 1
sudo rm cpulimit.sh
