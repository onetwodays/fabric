1、internals.go：
定义了一组接口，每个接口对应bccsp接口中的一个函数，internals.go中的接口简化了bccsp的实现.

2、fileks.go：与密钥存储和读取相关

3、impl.go：sw的主文件，通过调用6中的函数来实现bccsp的各个接口。

4、以算法名字开头的：密码算法实现相关。

5、以算法名字+key开头的: 定义该算法密钥的具体数据结构，并实现Key接口

6、以bccsp接口函数名开头的：包含了bccsp接口各个函数的具体实现代码。