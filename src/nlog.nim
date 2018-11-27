# Copyright (C) Brian J. Downs. All rights reserved.
# BSD License. Look at LICENSE for more info.

##
## nlog is a package that provides easy to use structured logging 
## in the gform of JSON. It's meant to be as simple as possible.
##

import json
import os
import times

type
    Log* = ref object
        ## Log contains the state for the current logger instance
        name: string
        output: File
        env: string

    Level = enum
        ## Level represents a log level
        INFO, WARN, ERROR, DEBUG, TRACE, FATAL

    LogOpts* = object
        ## LogOpts holds the options that are given to construct
        ## the logger instance
        name*: string
        output*: File
        env*: string

type
    Field* = tuple
        ## Field represents an entry in the JSON log and is used
        ## with any type that JSON supports
        k: string
        v: json.JsonNode

type 
    LogOptsValidationException* = object of Exception

proc validOpts(logOpts: LogOpts): string = 
    ## validOpts validates the options passed into the 
    ## newLogger procedure
    if logOpts.name == "":
        result = "missing name field"
    if logOpts.output.isNil:
        result = "error: missing output destination"
    result = ""

proc newLogger*(logOpts: LogOpts): Log {.raises: LogOptsValidationException.} = 
    ## newLogger creates a new instance of Log. It will check if the passed in 
    ## logOpts value isn't value, it will raise the LogOptsValidationException
    ## exception.
    let err: string = validOpts(logOpts)
    if err != err:
        raise newException(LogOptsValidationException, err)
    var log: Log = new(Log)
    log.name = logOpts.name
    log.output = logOpts.output
    result = log

proc field*(key, value: string): Field = 
    ## field creates and returns a tuple with a string key and 
    ## a JSON node containing a string value.
    result = (key, json.newJString(value))

proc field*(key: string, value: int): Field =
    ## field creates and returns a tuple with a string key and 
    ## a JSON node containing an int value. 
    result = (key, json.newJInt(value))

proc field*(key: string, value: bool): Field = 
    ## field creates and returns a tuple with a string key and 
    ## a JSON node containing a bool value.
    result = (key, json.newJBool(value))

proc field*(key: string, value: float): Field = 
    ## field creates and returns a tuple with a string key and 
    ## a JSON node containing a float value.
    result = (key, json.newJFloat(value))

proc write(log: Log, message: string, level: Level, fields: varargs[Field]) = 
    ## write takes the given input, formats the log entry, and 
    ## writes it to the configured output.
    var msg = %* {
        "timestamp": epochTime(),
        "level": level, 
        "env": log.env, 
        "msg": message
    }
    if len(fields) > 0:
        for f in fields:
            json.add(msg, f[0], f[1])
    writeLine(log.output, msg)

proc info*(log: Log, message: string, fields: varargs[Field]) = 
    ## info logs the given message and fields with the INFO level
    log.write(message, INFO, fields)

proc warn*(log: Log, message: string, fields: varargs[Field]) = 
    ## warn logs the given message and fields with the WARN level
    log.write(message, WARN, fields)

proc error*(log: Log, message: string, fields: varargs[Field]) = 
    ## error logs the given message and fields with the ERROR level
    log.write(message, ERROR, fields)

proc debug*(log: Log, message: string, fields: varargs[Field]) = 
    ## debug logs the given message and fields with the DEBUG level
    log.write(message, DEBUG, fields)

proc trace*(log: Log, message: string, fields: varargs[Field]) = 
    ## trace logs the given message and fields with the TRACE level
    log.write(message, TRACE, fields)
