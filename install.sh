echo "欢迎使用mailx自动配置脚本 ver0.0.2 by SJZ 2018-7-24（修正小bug）"
echo "请确认在使用本脚本前没有使用过其他类似的脚本"
echo "否则请重置配置文件再运行本脚本 按回车键继续"
read temp
sver1=`cat /etc/issue | grep CentOS`
sver2=`cat /etc/issue | grep Debian`
sver3=`cat /etc/issue | grep Ubuntu`
if [ "$sver1" != "" ] ; then
	echo "CentOS"
	sys=1
	dir=mail.rc
elif [ "$sver2" != "" ] ; then
	echo "Debian"
	sys=2
	dir=nail.rc
elif [ "$sver3" != "" ] ; then
	echo "Ubuntu"
	sys=3
	dir=s-nail.rc
else
	echo "unknow"
	sys=0
	exit
fi

case $sys in
1) yum -y install mailx && cd /
   bak1=`find | grep ./mail.rc.bak`
   if [ "$bak1" != "" ] ; then
	cp /etc/mail.rc.bak /etc/mail.rc
   else
	cp /etc/mail.rc /etc/mail.rc.bak
   fi

   ;;

2) apt-get install heirloom-mailx -y && cd /
   bak2=`find | grep ./nail.rc.bak`
   if [ "$bak2" != "" ] ; then
	cp /etc/nail.rc.bak /etc/nail.rc
   else
	cp /etc/nail.rc /etc/nail.rc.bak
   fi

   ;;
3) apt-get install heirloom-mailx -y && cd /
   bak3=`find | grep ./s-nail.rc.bak`
   if [ "$bak3" != "" ] ; then
	cp /etc/s-nail.rc.bak /etc/s-nail.rc
   else
	cp /etc/s-nail.rc /etc/s-nail.rc.bak
   fi

   ;;

esac

echo "mailx 安装完成 现在进行mailx配置" 

echo "请选择您所使用的邮箱"
echo ""
echo "1.新浪邮箱（推荐）"
echo ""
echo "2.163邮箱（推荐）"
echo ""
echo "3.gmail（国内邮箱时常收不到消息请选择此，注意开启gmail smtp服务）"
echo ""
echo "4.qq邮箱（不推荐，smtp登陆密码不等于qq登陆密码注意！！）"
read temp
case $temp in
1) echo "set smtp=smtp.sina.com" >> /etc/$dir
   
   ;;

2) echo "set smtp=smtp.163.com" >> /etc/$dir

   ;;

3) echo "set smtp=smtp.gmail.com" >> /etc/$dir

   ;;

4) echo "set smtp=smtp.qq.com" >> /etc/$dir

   ;;

esac

echo "请输入邮箱账号"
read temp
echo "set from=$temp" >> /etc/$dir
echo "set smtp-auth-user=$temp" >> /etc/$dir
echo "请输入邮箱密码"
read temp
echo "set smtp-auth-password=$temp" >> /etc/$dir
echo "set smtp-auth=login" >> /etc/$dir
echo "邮箱配置完成，下面发送测试邮件"
echo "请输入要接收测试邮件的邮箱地址"
read temp
cd /var && echo "收到这封邮件说明mailx配置成功" > attach_test.txt
echo "收到这封邮件说明mailx配置成功" | mail -s "这是一封测试邮件" -a /var/attach_test.txt $temp
echo "请检查是否收到测试邮件 谢谢使用 bye"
