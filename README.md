# OpenCCSwift

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![license](http://img.shields.io/github/license/mashape/apistatus.svg)]()

A swift wrapper of [OpenCC](https://github.com/BYVoid/OpenCC). 

### What it is

OpenCCSwift is a swift framework that import the [C++  OpenCC](https://github.com/BYVoid/OpenCC) code as a submodule and then build the dependencies direct from source.

### installation

* CMake is required in order to build the OpenCC from source.

* To integrate OpenCCSwift into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your Cartfile:

```
github "MichaelRow/OpenCC"
```

### Usage

The swift API is really easy. Two ways to use.

```
let opt = [.traditionalize, .taiwanStandard]
let converter = ChineseConverter(opt)
let result = converter.convert(string: "操作系统")

// or you can use it this way.
let converter2 = ChineseConverter(Simplize.taiwanStandard)
let result2 = converter2.convert(string: "操作系统")
```