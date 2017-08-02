---
weight: 20
title: GO
---

# Golang

## The Design

Go 看上去是 C 而不是 C++。我自己在学习和项目使用时，并没有很在意 C 和 C++ 的区别，但看到 Go 时，发现了许多不同。

```go
package foobar

type Bar struct {
    n int
}

func (b *Bar) foo() int {
    return b.n
}
```
Go 语言在设计中的感觉是**追求显式表达，避免隐式表达**。

```python
class Bar(object):
    n = "a local variable"
    def __init__(self):
        self.n = 0
    def foo(self):
        pass
```
Python 中也有相似的地方，在类中显式地写出`self`，对`self`的操作才是对对象的操作。  
但 Go 中向对象增加方法`method`也要显式地写出对象。  

Go 中不支持参数默认值，函数重载。C 也不支持，是 C++ 支持。  
参数默认值其实是一种隐式表达。调用者仅看名字，不去查看默认参数时，有时会遇到参数默认值导致问题，给调试带来不少麻烦。

一个表达的意义应该是唯一的，没有二义性。凡是可能导致二义性的行为都应是禁止或尽量避免的。比如函数默认参数，比如类的默认拷贝构造函数。还有一个书写方便但让项目更难调试的功能：自动类型转换。

进一步，一种表达的写法也应尽可能是唯一的。在 Go 语言的写法中，就没有单行 `if` 语句要不要加括号/braces 这样的问题。`if else` 中 `else` 的位置也是固定的。另一方面，你可以用无条件的 `switch` 来更清楚地表达 `if-then-else`。

引用某匿名用户的话：“语法糖好吃不一定有益。”
