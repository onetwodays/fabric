# 介绍
Fabric的密码算法模块BCCSP

1. bccsp.go
<br>主要接口声明的文件，比如BCCSP、Key、各种Opts等， 
其中BCCSP接口包含了Sign Verify Encrypt Decrypt Hash KeyGen KeyDerive等

2. sw
<br>bccsp的纯软件实现，内部实现通过调用go原生支持的密码算法，
并且提供了一个keystore来保存密钥，密钥默认保存在/tmp目录下

3. pkcs11
<br>bccsp的pkcs11实现，通过调用pkcs11接口来实现相关的密码操作，
仅支持ecdsa、rsa以及aes算法。密钥保存在pkcs11通过pin口令保护的数据库或者硬件设备中。

4. utils
<br>工具包，密钥编码转换等

5. signer
<br>实现了go的crypto.signer接口

6. factory
<br>
factory是bccsp的一个工厂，可以通过这个工厂返回一个具体的bccsp实例，
比如上面说的sw或者pkcs11，如果添加了自己的bccsp实现，也要讲该bccsp添加到factory中。

7. ECC椭圆曲线加密算法：ECDH 和 ECDSA
```
SW介绍
SW是国际标准加密的软实现插件，它包含了ECDSA算法、RSA算法、AES算法，以及SHA系列的摘要算法。

BCCSP接口定义了以下方法，其实对密码学中的函数进行了一个功能分类：

KeyGen：密钥生成，包含对称和非对称加密
KeyDeriv：密钥派生
KeyImport：密钥导入，从文件、内存、数字证书中导入
GetKey：获取密钥
Hash：计算摘要
GetHash：获取摘要计算实例
Sign：数字签名
Verify：签名验证
Encrypt：数据加密，包含对称和非对称加密
Decrypt：数据解密，包含对称和非对称加密
SW要做的是，把ECDSA、RSA、AES、SHA中的各种函数，对应到以上各种分类中

1、internals.go：定义了一组接口，每个接口对应bccsp接口中的一个函数，internals.go中的接口简化了bccsp的实现。

2、fileks.go：与密钥存储和读取相关

3、impl.go：sw的主文件，通过调用6中的函数来实现bccsp的各个接口。

4、以算法名字开头的：密码算法实现相关。

5、以算法名字+key开头的: 定义该算法密钥的具体数据结构，并实现Key接口

6、以bccsp接口函数名开头的：包含了bccsp接口各个函数的具体实现代码。
```