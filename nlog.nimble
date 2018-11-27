# Package 

version     "0.1.0"
author      "Brian Downs"
description "structure logger using JSON"
license     "BSD 3-clause"

srcDir = "src"

task test, "Runs the test suite":
    exec "nim c -r tests/tester"

task docs, "Build documentation":
    exec "nim doc --index:on -o:docs/nlog.html src/nlog.nim"

before install:
    echo "building..."
    exec("nim c src/nlog.nim")
