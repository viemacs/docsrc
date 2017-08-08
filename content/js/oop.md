---
weight: 20
title: JS
---

## Object-Oriented Programming of Javascript
notes of
[1](http://www.ruanyifeng.com/blog/2010/05/object-oriented_javascript_encapsulation.html)
[2](http://www.ruanyifeng.com/blog/2010/05/object-oriented_javascript_inheritance.html)
[3](http://www.ruanyifeng.com/blog/2010/05/object-oriented_javascript_inheritance_continued.html)

### JS 的对象

JS 本身是基于对象的语言，在 JS 中所操作的基本都是对象。但在 ES2015 之前它又没有 class 的类。

如果要从原型对象生成实例对象，要把属性和方法封装到对象里。properties and methods

- 对象实例

```javascript
let record = { name: "", nation: "" };
```
Schema 规格

```javascript
let record1 = { name: "Alpha", nation: "China" };
let record2 = { name: "Beta, nation: "Denmark" };
```
给对象赋予属性和方法

这可以看作最简单的封装，但原型和实例间并不存在内在联系。

```javascript
function Record(name, nation) {
    return {
        name: name,
        nation: nation,
    };
}
let record1 = Record("Alpha", "China");
let record2 = Record("Beta", "Denmark");
```
用函数调用返回对象方式可以在原型和实例间建立一定联系，但两个实例间没有内在联系。

- 构造函数模式

```javascript
function Record(name, nation) {
    this.name = name;
    this.nation = nation;
}
let record1 = new Record("Alpha", "China");
let record2 = new Record("Beta", "Denmark");
```
Javascript 提供了 Constructor 构造函数模式。构造函数是使用了 this 变量的普通函数，在使用 new 运算符生成实例时，this 会绑定到对象实例上，使 `foo.constructor == Foo`。JS 中的 instanceof 运算符可以验证原型与实例对象间的关系，`(foo instanceof Foo) == true`。

- 原型模式 prototype

```javascript
function Record(name, nation) { this.name = name; this.nation = nation; }
Record.prototype.species = "human";
Record.prototype.greet = function() { console.log("hello") };
let record1 = new Record("Alpha", "China"); // with `species` and `greet()`
let record2 = new Record("Beta", "Denmark");
```
构造函数模式的问题在于原型中的属性和方法在每个实例中都要创建。其中重复的内容就额外地占用的资源。JS 中每个构造函数都有 prototype 属性，指向另一个对象；所指向对象的属性和方法都被构造函数继承。

这样，不变的属性和方法可以直接定义在 prototype 对象上。在例子中，所有实例的 species 和 greet() 方法都指向相同的地址，即 prototype 对象。

JS 中有一些对应 prototype 模式的方法

- `isPrototypeOf()` 判断 prototype 对象和实例间的关系  
    `Record.prototype.isPrototypeOf(record1)`

- `hasOwnProperty()` 由实例判断一个属性是本地的还是继承的  
    `record1.hasOwnProperty("name") == true`  
    `record1.hasOwnProperty("species") == false`

- `in` 可以遍历一个对象的所有属性，或一个实例是否含有某个属性  
    `for (let prop in record) console.log(prop);`  
    `"name" in record1 == true`
