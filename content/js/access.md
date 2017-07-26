---
weight: 20
title: JS
draft: false
---

# Javascript


## Thoughts

### Why JavaScript

I use JavaScript to develop products because it seems faster and easier.
Use web browsers as JVM, use DOM to build UI, and sue JS to implement business logic.

### React

React provides a different way of organize frontend codes. And I like it very much.

Before writing WebApp, my programming practice uses Cpp mostly.
So class and components are very handy, and very easy to understand.
Different from the noodle of Vanilla JS in complex application,
React divides the system to proper components, and makes the data flow in one direction only.

Since more services are moved to Cloud, there are more business-oriented applications
which are more complex than client/consumer oriented apps.
React can make some real differences in these fields.

### Vanilla JS
Some time it seems Vanilla JS is not important, bacause lib like jQuery wrapped up many things.
During the early stage of developing an app, you might need to find certain libs to solve the problems you are facing.
When you put those codes together, you might encounter problems, and to handle those problems, Vanilla JS is very helpful in locating the problem and finger out what's wrong.

Another thing is if you need to glue some modules together, sometimes you need to use Vanilla JS to do the job, instead of find another lib to glue modules.

### React createClass vs Component
ES6 class might be just a syntactic sugar instead of real class, but things are headed towards this way.
I choose to write my code the ES6 way when it's convenient.
As to Component, it's neater than createClass.
No trailing comma, less extra parentheses, and easier to read.

[Ref](https://reactjsnews.com/composing-components "React.Component vs React.createClass")


## Introduction

### Approaches to Create Objects

```javascript
let str = 'direct assigned';
let newstr = new String("String instance initialization")
let fn = new Function("arg_name", "console.log(arg_name)");
let obj = new Object();
```
- Inner Object
JS has two types of inner object:
    - original object, eg: `Function, Object, String`
    - run-time object / host object, eg: `window, document`

```javascript
let foo = {k:'record', v:[1,2,3]}
let bar = new Object();
bar.k = 'record';
```
- JSON Object
JS can creates objects via JSON objects.  
And JS can turn Object instance to JSON object.

```javascript
function Foo() { this.k = 'record'; this.v = 1234; }
function Bar() {}
Bar.prototype.k = 'record';
Bar.prototype.v = 1234;
```
- Customized Object
`Function` can be used to create customized object.
    - use `this`  
      the attributes and methods are initialized for every instance
    - use `prototype`  
      the attributes and methods are only references on every instance


## Number

### Integer
> 环境 64位 Linux, nodejs v7.2.1

- 16位数 可以正确显示
- 17位数 17位上开始失准; 然后归双; 然后舍入, 17位为0
- 18-22位数 16位后直接丢失, 变为0
- 23位以上, 变为浮点数, 进行 parseInt() 会出错

## *delete* operator in JS
[Ref](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/delete#section_5)

The **delete** operator removes a property from an object.

```
delete expression
```

where `expression` should evaluate to a property reference.

```
delete object.property
delete object['property']
```

Parameters

**object** The name of an object, or an expression evaluating to an object.

**property** The property to delete.


N.B., the **delete** operator has **nothing** to do with directly freeing memory.
Memory management is done indirectly via breaking references.

- *delete* will return *true* on successful deletion, or it will *false* or raises a SyntaxError or ReferenceError in strict mode.
- Notice that *delete* will also return *true* if the target property does not exist and *delete* has no effect.
- Delete can only remove own properties. If the prototype chain has a property with the same name, then the object will use it.
- An property declared with *var* cannot be deleted from global/function scope.
- *function* can only be deleted if it's a part of an object.
- An property declared with *let* or *const* cannot be deleted from their scope.
- Non-configurable properties cannot be *deleted*, which includes properties of built-in objects like *Math*, *Array*, *Object*, and properties created by Objects.defineProperty().


## Array
### Array Loop

```javascript
let arr = [];

for (let i in arr) ;

for (let i of arr) ;

arr.forEach((e) => {});

arr.map((e) => {return e});

arr.every((e) => {return e});

arr.some((e) => {return e});
```
