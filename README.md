# nlog

nlog is a simple logging library that provides a JSON logger to be used in any kind of application. nlog can log to the console or a file.

## Examples

Log to the console:

```nim
let logOpts: LogOpts = LogOpts(name: "my_service", output: stdout)
let log: Log = newLogger(logOpts)
```

Log to a file:

```nim
var f: File = open("application.log", fmWrite)
let logOpts: LogOpts = LogOpts(name: "my_service", output: f)
let log: Log = newLogger(logOpts)
f.close()
```

```nim
log.info("this is the message")
log.debug("this is the message too", field("integer", 7))
log.trace("this is also a message", field("float", 99.99))
log.error("something went horribly wrong", field("definitely?", true))
log.info("multiple fields", field("field1", "value1"), field("field2", 2))
```

Sample Output:

```sh
{"timestamp":1543325555.508735,"level":"INFO","env":"","msg":"this is the message"}
{"timestamp":1543325555.508803,"level":"DEBUG","env":"","msg":"this is the message","integer":7}
{"timestamp":1543325555.508824,"level":"TRACE","env":"","msg":"this is the message","float":99.98999999999999}
{"timestamp":1543325555.508838,"level":"ERROR","env":"","msg":"soemthing went horribly wrong","bool":true}
{"timestamp":1543325555.508853,"level":"INFO","env":"","msg":"multiple fields","field1":"value1","field2":2}
```

## Contributing

Please feel free to open a PR!

## License

nlog source code is available under the BSD 3 clause [License](/LICENSE).

## Contact

[@bdowns328](http://twitter.com/bdowns328)
