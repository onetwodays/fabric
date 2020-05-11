#!/usr/bin/env bash
 mkdir -p ~/pki/CA/private

 #1.CA自己签证书
 (umask 077; openssl genrsa -out ~/pki/CA/private/cakey.pem 2048)
 openssl req -new -x509 -key ~/pki/CA/private/cakey.pem -out  ~/pki/CA/cacert.pem -days 3655



# req: 生成证书签署请求
#-news: 新请求
#-x509: 专门用于生成自签署证书
#-key /path/to/keyfile: 指定私钥文件（req命令能根据私钥自动抽取出公钥）
#-out /path/to/somefile: （注意：路径和文件名不用随意修改！）
#-days n: 有效天数（一般和-x509一起使用才有意义。）
#2.初始化工作环境
cd ~/pki/CA
touch {index.txt,serial}
echo 01 > serial   #（指定序列号从那个数字开始）


#3节点申请证书
#3.1生产私钥
mkdir -p ~/pki/app/ssl
(umask 077; openssl genrsa -out ~/pki/app/ssl/httpd.key 2048)
#3.2向CA发送生成证书签署请求
openssl req -new -key ~/pki/app/ssl/httpd.key -out ~/pki/app/ssl/httpd.csr
#3.3CA签署证书
openssl ca -in  ~/pki/app/ssl/httpd.csr -out  ~/pki/app/ssl/httpd.crt -days 365
#3.4 提取公钥
openssl rsa -in ~/pki/app/ssl/httpd.key -pubout -out ~/pki/app/ssl/httpd.pubkey