---
title: JS
weight: 20
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

### 继承对象

```javascript
function Record() { this.title = "Record" }
function Personnel(name, dept) { this.name = name; this.dept = dept; }
```
对象间继承的方法。

- 绑定构造函数  
  使用 apply / call 将父对象的构造函数绑定到子对象上。子对象中需要显式地加入绑定语句。  
  `function Personnel(name, dept) { ...; Record.apply(this, arguments); }`

- prototype  
  将子类的 prototype 指向父类的一个实例，使所有子类实例继承父类。  
  `Personnel.prototype = new Record();`  
  `Personnel.prototype.constructor = Personnel;`  
  首先是将 Personnel.prototype 替换为指向 Record实例。这时 Personnel.prototype.constructor 指向了 Record 的构造函数，即 `Personnel.prototype.constructor == Record`，由 Personnel 创建的实例也是如此。所以要将 Personnel.prototype 重新指向 Personnel 的构造函数。

- 继承 prototype  
  JS 的函数对象可以将不变属性放在 prototype 中，对于只使用不变量的子类，可以直接继承父类的 prototype。  
  `function Record() {}`  
  `Record.prototype.title = "Record";`  
  `Personnel.prototype = Record.prototype;`  
  `Personnel.prototype.constructor = Personnel;`  
  这种方法不需要创建父类的实例，效率更高一些。  
  直接继承 prototype 有一个问题，子类和父类的 prototype 指向了同一个对象，对子类 prototype 的修改会影响父类的 prototype。  
  `Record.prototype.constructor == Personnel;`

- via 空对象  
  利用空对象占用内存空间较小这点，通过空对象实例完成继承。
  `let F = function() {};`  
  `F.prototype = Record.prototype;`  
  `Personnel.prototype = new F();`  
  `Personnel.prototype.constructor = Personnel;`  


```javascript
// YUI extend function
function extend(Child, Parent) {
    let F = function() {};
    F.prototype = Parent.prototype;
    Child.prototype = new F();
    Child.prototype.constructor = Child;
    Child.uber = Parent.prototype;
}
extend(Personnel, Record);
```
  可以对这个方式进行封装。如 YUI 库实现继承的方法。

- copy  
  就是将所有父类的属性和方法在子类中复制一份。

```javascript
function Record() {}
Record.prototype.title = "Record";
function extend(Child, Parent) 
    for (let i in Parent.prototype)
        Child.prototype[i] = Parent.prototype[i];
    Child.prototype.uber = Parent.prototype;
}
```
----

### 一般对象继承
无构造函数的普通对象的继承。
`let Record = {title: "Record"};`

- 通过 object 函数

```javascript
function object(obj) {
    function F() {}
    F.prototype = obj;
    return new F();
}
let Personnel = object(Record);
```

- 浅复制

```javascript
function extend(obj) {
    let c = {};
    for (let i in obj)
        c[i] = obj[i];
    c.uber = obj;
    return c;
}
let Personnel = extend(Record);
```
浅复制在父对象的成员也是对象时，会把对象地址复制给子类，造成子类可以修改父类。

- 深复制

```javascript
function deepCopy(Parent, Child) {
    let Child = Child || {};
    for (let i in Parent) {
        if (typeof Parent[i] === "object") {
            Child[i] = (Parent[i].constructor === Array) ? [] : {};
            deepCopy(Parent[i], Child[i]);
        } else {
            Child[i] = Parent[i];
        }
    }
    return Child;
}
```
