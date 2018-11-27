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

## Features

* Color Output
* Non structured log messages

## Contributing

Please feel free to open a PR!

## License

nlog source code is available under the BSD 3 clause [License](/LICENSE).

## Contact

[@bdowns328](http://twitter.com/bdowns328)
