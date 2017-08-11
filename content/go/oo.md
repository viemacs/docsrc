---
title: Golang
weight: 20
---

## Object Orientation

Golang 中没有 `class`。它的面向对象的实现，可以用 `struct` 来做。

```go
type Record struct {
    Title string
    Dept string
    value int
}
```
Golang 中变量和函数首字母大写相当于 `public`， 小写相当于 `private`，在包和结构体中都是如此。

```go
func (r Record) Publish() { fmt.Println(r.Title) }
func (r *Record) setTitle(s string) { r.Title = s }
```
Golang 中结构体的方法声明与众不同，是普通函数的方式，并在 `func` 后加上函数操作的对象，对象加 `*` 则传指针，不加时传值。

```go
record := &Record{}
record.Title = "New Time"
record2 := &Record{Title: "Two"}
record3 := new(Record)
record3.Title = "Three"
record4 := Record{}
record4.Title = "Four"
record5 := Record{Title: "Five"}
```
对象实例化。加 `&` 和 `new` 时，生成指针对象。一般当对象较小时，传值较好；对象较大时，传指针较好。

```go
func NewRecord(param string, p ...interface{}) *Record
func NewRecord(title string) (r *Record) {
    r = &Record{}
    r.Title = title
    return
}
record := NewRecord("Initialized")
```
Golang 并没有构造函数，一般也不要用。如果想在初始化时额外做些事的话，要自己写方法来生成实例。

```go
type Record struct {
    Title string
    Dept string
    value int
}
type Archive struct {
    Record
    Dept string
    Location string
}
archive := &Archive{}
archive.Title = "Archive"
archive.Dept = "A-20"
archive.Record.Dept = "Center"
// partial print
&{{ Center } A-20 }
```
Golang 的继承/组合，cmoposition。在属性冲突时，使用 `Archive` 中的，而 `Record` 中的用 `archive.Record.Dept` 访问。

Golang 不支持重载，重载属于 `redeclared` 错误，但可以使用不定参数来处理不同参数调用。  
`func (r *Record) bar(args ...interface{}) { fmt.Println(args) }`

**接口**

TBC
