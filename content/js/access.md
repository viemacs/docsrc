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


## Number

### Integer
> 环境 64位 Linux, nodejs v7.2.1

- 16位数 可以正确显示
- 17位数 17位上开始失准; 然后归双; 然后舍入, 17位为0
- 18-22位数 16位后直接丢失, 变为0
- 23位以上, 变为浮点数, 进行 parseInt() 会出错