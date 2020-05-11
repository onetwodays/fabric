
```
//创建一个名字为examplename的日志对象log
var log = logging.MustGetLogger("examplename")
//创建一个日志输出格式对象format，也就是用什么格式输出
var format = logging.MustStringFormatter(
    `%{color}%{time:15:04:05.000} %{shortfunc} ▶ %{level:.4s} %{id:03x}%{color:reset} %{message}`,
)
//创建一个日志输出对象backend，也就是日志要打印到哪儿，在此是标准错误输出
backend := logging.NewLogBackend(os.Stderr, "", 0)
//将输出格式与输出对象绑定
backendFormatter := logging.NewBackendFormatter(backend, format)
//将绑定了格式的输出对象设置为日志的输出对象
//这样log打印每一句话都会按格式输出到backendFormatter所代表的对象里，在此即是标准错误输出
logging.SetBackend(backendFormatter)
//log打印依据Info信息
log.Info("info")
//log打印一句Error信息
log.Error("err")
```