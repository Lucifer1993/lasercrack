# lasercrack-可扩展的Ruby多线程暴力破解框架

![language][1]
![Support][2]
![license][3]
![release][4]

[1]:https://img.shields.io/badge/Language-Ruby-blue.svg
[2]:https://img.shields.io/badge/Support-linux%2Fmac%2Fwindows-green.svg
[3]:https://img.shields.io/badge/License-GPL--3.0-yellow.svg
[4]:https://img.shields.io/badge/Release-v1.0-orange.svg


# 运行环境
支持系统：linux/Mac/windows，windows需要安装ruby devKit环境同时安装mysys2库。

支持语言：Ruby 2.2.2及以后的版本

# 支持爆破模块
ftp

ssh

telnet

smb

mysql

mssql

oracle

redis

mongo

vnc


# 安装
bundle install（如果tiny_tds模块安装不上可能是缺少系统组件，先安装freetds）

kali系统使用apt-get install freetds-dev 命令安装

# 使用
![image](./images/laser.png)

# 爆破方式
![image](./images/crack.png)
1. IP以及IP列表(例如192.168.1.1-192.168.1.100或者CIDR格式)

2. 单个IP,载入用户名字典

3. 单个IP,载入密码字典

[ * ] 如果需要重新利用需要设置个别参数为nil


# 特别说明
1.此工具仅限于漏洞验证，如若使用者引起相关的法律责任请自负，开发者不承担连带责任。

2.感谢@小葵师傅的指点。
