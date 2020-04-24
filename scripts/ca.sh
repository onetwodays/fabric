 mkdir -p pki/CA/private
 (umask 077; openssl genrsa -out ~/pki/CA/private/cakey.pem 2048)
 openssl req -new -x509 -key ~/pki/CA/private/cakey.pem -out  ~/pki/CA/cacert.pem -days 3655

# req: 生成证书签署请求
#-news: 新请求
#-x509: 专门用于生成自签署证书
#-key /path/to/keyfile: 指定私钥文件（req命令能根据私钥自动抽取出公钥）
#-out /path/to/somefile: （注意：路径和文件名不用随意修改！）
#-days n: 有效天数（一般和-x509一起使用才有意义。）

