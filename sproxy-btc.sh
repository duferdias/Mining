#!/bin/sh -
clear
# Stratum Proxy by Stratehm & malthraxcrypto
# Script by darkstilo & 8TH
# Editado por duferdias

# [ PROXY STRATUM METHOD FOR LINUX ]

# O Stratum Proxy by Stratehm suporta até 256 mineradores e vários
# algorítimos de mineração. Dentre eles os algorítimos: SHA256, Scrypt
# e Yescrypt.

# Com o script "sproxy-btc" é possível instalar, configurar e executar
# o stratum proxy com o arquivo de configuração stratum-proxy-yescrypt
# para receber mineradores de BITCOIN e redirecioná-los para a zpool.ca.

# -------------
# [ VARIABLES ]
carteira=
usuario=
senha=

# [ SCRIPT ]
# Obtém a carteira de Bitcoin
if [ -z "${carteira-}" ]; then
  echo
  read -p "Entre com a carteira de Bitcoin: " carteira
fi
# Obtém o nome de usuário para o Stratum-Proxy
if [ -z "${usuario-}" ]; then
  echo
  read -p "Entre com um nome de usuário para o Stratum-Proxy: " usuario
fi
# Obtém a senha para o usuário do Stratum-Proxy
if [ -z "${senha-}" ]; then
  echo
  read -p "Entre com uma senha para o usuário do Stratum-Proxy: " senha
fi

# [ Install JDK, Extras, Packages and Dependencies ]
sudo apt-get update
sudo apt-get install screen -y
sudo apt-get install gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils libxext6 -y
sudo apt-get install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev nano -y
sudo apt-get install autotools-dev -y
sudo apt-get install libcurl3 libcurl4-gnutls-dev -y
sudo apt-get install software-properties-common -y
sudo apt-get install default-jre -y
sudo apt-get install default-jdk -y
sudo apt-get install nodejs -y
sudo apt-get install maven -y

# [ Install Stratum Proxy ]
wget https://github.com/duferdias/stratum-proxy/archive/v0.8.1.tar.gz -O v0.8.1.tar.gz
tar -xzvf v0.8.1.tar.gz
cd stratum-proxy-0.8.1
mvn clean package
cd target

wget https://github.com/duferdias/stratum-proxy/releases/download/v0.8.1/stratum-proxy-yescrypt.conf -O stratum-proxy-yescrypt.conf

# Convert format dos2unix
# awk '{printf "%s\r\n", $0}' stratum-proxy-yescrypt.conf
# Insere as variáveis
sed -i 's/XMY/BTC/g' stratum-proxy-yescrypt.conf
sed -i "s/\"user\" :.*/\"user\" \: \"${carteira}\"\,/" stratum-proxy-yescrypt.conf
sed -i "s/\"apiUser\":.*/\"apiUser\"\: \"${usuario}\"\,/" stratum-proxy-yescrypt.conf
sed -i "s/\"apiPassword\":.*/\"apiPassword\"\: \"${senha}\"\,/" stratum-proxy-yescrypt.conf

echo "\033[01;32mInstalação e configuração concluídas com sucesso."
sleep 3
clear

echo "\033[44;1;37m      O Stratum Proxy iniciará em uma nova sessão.      \033[0m "
echo "\033[44;1;37m          NÃO FECHE A JANELA DO CONSOLE AGORA!          \033[0m "
echo "\033[44;1;37m      Fechar console somente após a inicialização.      \033[0m \n"
sleep 2
echo " - Acompanhe o trabalho de seus mineradores no stratum proxy em seu navegador web!"
echo " - Acesso com as opções: https://seudominio-proxy:8888 ou https://seuIP-proxy:8888."
echo " - Para autorizar o acesso entre com seu usuário e senha."
sleep 18
clear

# [ Run Stratum Proxy ]
echo "\033[37;41mAbrindo sessão, aguarde...\033[0m "
sleep 3
sudo screen -dmS sproxy java -jar stratum-proxy-0.8.1-malthraxcrypto.jar --conf-file=stratum-proxy-yescrypt.conf
sleep 2
clear
echo "\033[37;41mStratum Proxy em execução. Para visualizar digite o comando abaixo:\033[01;0m \n"
echo "\033[37;41mCOMANDO [screen -x sproxy]\033[0m"
sleep 1
