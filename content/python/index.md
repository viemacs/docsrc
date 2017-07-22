---
title: "Index"
date: 2017-07-22T11:51:17+08:00
draft: false
---

# Python

## Class 自带函数
```python
class Foor(object):
    def __init__(self, *args, **kwargs):
        print('init')
        super(Bar, self).__init__(*args, **kwargs)
    
    def __new__(cls, *args, **kwargs):
        print('new')
        return super(Bar, cls).__new__(cls, *args, **kwargs)

    def __call__(self, *args, **kwargs):
        print('call')
        
foo = Bar()
foo()

# Result:
new
init
call
```

- `__init__(self, *args, **kwargs)`  
  在对象创建完成后调用，对当前对象实例进行初始化，无返回值。

- `__new__(cls, *args, **kwargs)`  
  创建对象时调用，返回当前对象的一个实例。

- `__call__(self, *args, **kwargs)`  
  重载括号运算符。类实现了call方法，则其对象可当作函数使用。

## 用自带函数实现单例
```python
class MySingleton(object):
    def __new__(cls, *args, **kwargs):
        if not '_instance' in vars(cls):
        cls._instance = super(MySingleton, cls).__new__(cls, *args, **kwargs)
    return cls._instance
```
