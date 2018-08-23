#!/bin/bash

mail_addr=`sed -n "1p" /etc/mail_addr.conf`
echo "      欢迎使用Mailx管理脚本      "
echo "*********************************"
echo "          1.发送邮件             "
echo "          2.修改邮箱地址         "
echo "          3.退出                 "
echo "*********************************"
read temp

case $temp in
1) echo "        发送邮件选项        "
   echo "****************************"
   echo "    1.发送不带附件的邮件    "
   echo "    2.发送带有附件的邮件    "
   echo "****************************"
   read temp
   if [ $temp -eq "1" ] ; then
		echo "请输入邮件主题 输入错误请按ctrl+backspace删除"
		read subject
		echo "请输入邮件内容 输入错误请按ctrl+backspace删除"
		read body
		echo "正在发送邮件 ………………………………"
		echo $body | mail -s $subject  $mail_addr
		echo "邮件发送成功"
   elif [ $temp -eq "2" ] ; then
		echo "请输入邮件主题 输入错误请按ctrl+backspace删除"
		read subject
		echo "请输入邮件内容 输入错误请按ctrl+backspace删除"
		read body
		echo "请输入附件存放地址 输入错误请按ctrl+backspace删除"
		read dir
		echo "正在发送邮件 ………………………………"
		echo $body | mail -s $subject -a $dir $mail_addr
		echo "邮件发送成功"
   else
		echo "请输入正确的数字 （不要调戏程序！）"
		exit
   fi

   ;;
   
2) echo "原来的邮箱地址为" $mail_addr
   echo "请输入新的邮箱地址 输入错误请按ctrl+backspace删除"
   read mail_addr
   echo "您输入的是" $mail_addr
   echo "正在修改邮箱"
   rm -f /etc/mail_addr.conf
   echo $mail_addr >> /etc/mail_addr.conf
   echo "邮箱地址修改完成"
   

   ;;
   
3) exit

   ;;
   
esac 

