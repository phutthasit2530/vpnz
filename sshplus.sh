#!/bin/bash

wget https://raw.githubusercontent.com/MyGatherBk/Pandavpn/master/list > /dev/null 2>&1

clear
[[ "$EUID" -ne 0 ]] && echo -e "\033[1;33mDesculpe, \033[1;33mvocê precisa executar como root\033[0m" && rm -rf $HOME/Plus > /dev/null 2>&1 && return 1
cd $HOME
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mWAIT\033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "ยินดีต้อนรับสู่ SSH+OVPN+SSL+PROXY SOCKS ALLPLUS MANAGER" ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "             \033[1;31mATENCAO! \033[1;33mสคริปต์ของ IRA นี้!\033[0m"
echo ""
echo -e "\033[1;31m• \033[1;33mการติดตั้งชุดสคริปต์เป็นเครื่องมือ\033[0m" 
echo -e "\033[1;33m  สำหรับเครือข่ายระบบและการจัดการผู้ใช้\033[0m"
echo ""
echo -e "\033[1;32m• \033[1;32mDICA! \033[1;33mใช้ชุดรูปแบบที่มืดในเทอร์มินัลของคุณถึง\033[0m"
echo -e "\033[1;33m  ประสบการณ์ที่ดีกว่าและการมองเห็นของสิ่งเดียวกัน!\033[0m"
echo ""
echo -e "\033[1;31m≠×≠×≠×≠×≠×≠×≠×≠×[\033[1;33m • \033[1;32mSSH+OVPN+SSL+PROXY SOCKS ALLPLUS MANAGER\033[1;33m •\033[1;31m ]≠×≠×≠×≠×≠×≠×≠×≠×\033[0m"
echo ""
echo -ne "\033[1;36mสร้างเป็นคีย์ฟรี[N/S]: \033[1;37m"; read x
[[ $x = @(n|N) ]] && exit
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -ne "\033[1;36mWAIT... \033[1;32m OK !\033[1;37m "
chmod +x list ./list > /dev/null 2>&1
echo ""
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;36mตรวจสอบคีย์\033[1;35m ...\033[0m"
sleep 2
echo ""
echo -ne "\033[1;36mใส่ชื่อของคุณ:\033[1;37m "; read name
if [ -z "$name" ]; then
  echo ""
  echo -e "\033[1;31mErro \033[1;32mชื่อว่าง!\033[0m"
  rm -rf $HOME/Plus $_lsk/list > /dev/null 2>&1
  sleep 2
  clear; exit 1
fi
IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
if [[ "$IP" = "" ]]; then
  IP=$(wget -qO- ipv4.icanhazip.com)
fi
echo ""
echo -ne "\033[1;36mTo continue confirm your IP \033[1;37m"; read -e -i $IP ipdovps
if [ -z "$ipdovps" ]; then
  echo ""
  echo -e "\033[1;31mErro \033[1;32mIP ไม่ถูกต้อง!\033[0m"
  rm -rf $HOME/Plus $_lsk/list > /dev/null 2>&1
  sleep 2
  clear; exit 1
fi
if [ -f "$HOME/usuarios.db" ]
then
    clear
    echo ""
    echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"
    echo ""
	echo -e "                 \033[1;33m• \033[1;31mATTENTION \033[1;33m• \033[0m"
	echo ""
    echo -e "\033[1;33mA User Database\033[1;32m(usuarios.db) \033[1;33mFoi" 
    echo -e "Found! Do you want to keep it preserving the limit"
	echo -e "of users' Simultaneous Connections? Or Do You Want"
    echo -e "create a new database ?\033[0m"
	echo -e "\n\033[1;37m[\033[1;31m1\033[1;37m] \033[1;33mMaintain Current Database\033[0m"
	echo -e "\033[1;37m[\033[1;31m2\033[1;37m] \033[1;33mCreate a New Database\033[0m"
	echo -e "\n\033[0;34m═════════════════════════════════════════════════\033[0m"
    echo ""
    tput setaf 2 ; tput bold ; read -p "Opção ?: " -e -i 1 optiondb ; tput sgr0
else
    awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
fi
echo ""
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-18s\n' " WAIT FOR INSTALLATION" ; tput sgr0
echo ""
echo ""
echo -e "          \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mUPDATING SYSTEM \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
echo ""
echo -e "    \033[1;33mUPDATES USED TO TAKE A LITTLE TIME!\033[0m"
echo ""
fun_attlist () {
    apt-get update -y
}
fun_bar 'fun_attlist'
sleep 1
clear
echo ""
echo -e "          \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mINSTALLING PACKAGES \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "\033[1;33mSOME PACKAGES ARE EXTREMELY NECESSARY !\033[0m"
echo ""
inst_pct () {
apt-get install squid3 lsof netstat bc screen nano unzip dos2unix -y > /dev/null 2>&1
apt-get install nload -y > /dev/null 2>&1
apt-get install jq -y > /dev/null 2>&1
apt-get install curl -y > /dev/null 2>&1
apt-get install figlet -y > /dev/null 2>&1
apt-get install python3 -y > /dev/null 2>&1
apt-get install python-pip -y > /dev/null 2>&1
pip install speedtest-cli > /dev/null 2>&1
}
fun_bar 'inst_pct'
sleep 1
if [ -f "/usr/sbin/ufw" ] ; then
  ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
clear
echo ""
echo -e "              \033[1;33m[\033[1;31m!\033[1;33m] \033[1;32mFINISHING \033[1;33m[\033[1;31m!\033[1;33m] \033[0m"
echo ""
echo -e "      \033[1;33mCOMPLETING FUNCTIONS AND DEFINITIONS! \033[0m"
echo ""
cd $_lsk
fun_bar 'source list'
rm sshplus* > /dev/null 2>&1
rm list* > /dev/null 2>&1
sleep 2
clear
apt-get install lsof > /dev/null 2>&1
echo ""
echo -e "\033[0;34m═════════════════════════════════════════════════\033[0m"
echo -e "        \033[1;33m • \033[1;32mINSTALLATION COMPLETED\033[1;33m • \033[0m"
echo ""
echo -e "\033[1;31m● \033[1;33mOpenSSH rolling on ports 22 by default\033[0m"
echo -e "\033[1;31m● \033[1;33mInstalled user management script\033[0m"
echo -e "\033[1;31m● \033[1;33mAvailable commands Execulte \033[1;32mmenu \033[1;33mou \033[1;32majuda\033[0m"
echo -e "\033[0;34m═════════════════════════════════════════════════\033[0m"
echo ""
sed -i "126d" /etc/ssh/sshd_config > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
cd $HOME
if [[ "$optiondb" = '2' ]]; then
  awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
fi
echo "$ipdovps" >/etc/IP
