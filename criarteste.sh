#!/bin/bash
IP=$(cat /etc/IP)
if [ ! -d /etc/SSHPlus/userteste ]; then
mkdir /etc/SSHPlus/userteste
fi
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-15s\n' "สร้างผู้ใช้ทดสอบ" ; tput sgr0
echo ""
[ "$(ls -A /etc/SSHPlus/userteste)" ] && echo -e "\033[1;32mการทดสอบที่ใช้งานอยู่!\033[1;37m" || echo -e "\033[1;31mไม่มีการทดสอบที่ใช้งานอยู่!\033[0m"
echo ""
for testeson in $(ls /etc/SSHPlus/userteste |sort |sed 's/.sh//g')
do
echo "$testeson"
done
echo ""
echo -ne "\033[1;32mชื่อผู้ใช้\033[1;37m: "; read nome
if [[ -z $nome ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "ชื่อว่างหรือไม่ถูกต้อง." ; echo "" ; tput sgr0
	exit 1
fi
awk -F : ' { print $1 }' /etc/passwd > /tmp/users 
if grep -Fxq "$nome" /tmp/users
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "ผู้ใช้รายนี้มีอยู่แล้ว." ; echo "" ; tput sgr0
	exit 1
fi
echo -ne "\033[1;32mรหัสผ่าน\033[1;37m: "; read pass
if [[ -z $pass ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "รหัสผ่านว่างเปล่าหรือไม่ถูกต้อง." ; echo "" ; tput sgr0
	exit 1
fi
echo -ne "\033[1;32mจำกัด\033[1;37m: "; read limit
if [[ -z $limit ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "ขีด จำกัด ว่างเปล่าหรือไม่ถูกต้อง." ; echo "" ; tput sgr0
	exit 1
fi
echo -ne "\033[1;32mนาที \033[1;33m(\033[1;31mใส่จำนวนวัน ทดสอบ: \033[1;37m60\033[1;33m)\033[1;37m: "; read u_temp
if [[ -z $limit ]]
then
echo ""
tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "ขีด จำกัด ว่างเปล่าหรือไม่ถูกต้อง." ; echo "" ; tput sgr0
	exit 1
fi
useradd -M -s /bin/false $nome
(echo $pass;echo $pass) |passwd $nome > /dev/null 2>&1
echo "$pass" > /etc/SSHPlus/senha/$nome
echo "$nome $limit" >> /root/usuarios.db
echo "#!/bin/bash
pkill -f "$nome"
userdel --force $nome
grep -v ^$nome[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
rm /etc/SSHPlus/senha/$nome > /dev/null 2>&1
rm -rf /etc/SSHPlus/userteste/$nome.sh
exit" > /etc/SSHPlus/userteste/$nome.sh
chmod +x /etc/SSHPlus/userteste/$nome.sh
at -f /etc/SSHPlus/userteste/$nome.sh now + $u_temp min > /dev/null 2>&1
clear
echo -e "\E[44;1;37m     สร้างผู้ใช้ทดสอบแล้ว     \E[0m"
echo ""
echo -e "\033[1;32mIP:\033[1;37m $IP"
echo -e "\033[1;32mUsuario:\033[1;37m $nome"
echo -e "\033[1;32mSenha:\033[1;37m $pass"
echo -e "\033[1;32mLimite:\033[1;37m $limit"
echo -e "\033[1;32mValidade:\033[1;37m $u_temp Minutos"
echo ""
echo -e "\033[1;33mหลังจากเวลาที่กำหนดผู้ใช้"
echo -e "\033[1;32m$nome \033[1;33mจะถูกตัดการเชื่อมต่อและลบออกทันที.\033[0m"
exit
