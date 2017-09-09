---
title: Agile
weight: 20
---

## Unit Test

### Questions

- C 语言的单元测试工具

### About Unit Test

#### WHAT
对一个明确的功能/函数, 测试其在给定条件下的工作是否正确.

Unit test > Integration test > Automated Gui-tesst > Manual Test

Unit, Components:  成本低, 效率高, 缺陷晚定位
Acceptance, API
User Interface, Manual: 反映真实需求, 接近业务


#### WHY
- 验证每一项功能的正确性, 为后续开发提供支撑
- 回归性. 避免代码修改影响原有功能
- 思考设计. Test-First, 要把程序设计成易调用, 可测试, 低耦合的结构
- 本身是可工作的文档. A working/functional document, 展示函数/类/接口的功能的使用方法

**Value**

- 要了解功能和函数行为, 才能写好单元测试
- 写单元测试是用现在的时间换将来的时间
- 单元测试是白盒测试

#### HOW

- 测试工具
- 断言 assert
- Mock @Runwith @Mock @Test

Java: JUnit, Hamcrest, Mockito

### Test

单元测试要点: Fast, Isolated, Repeatable, Self-verifying, Timely

**Given, When, Then** 模式

**One test, One function**, 一个测试测一个方法

### Mock

适用于所 mock 的对象

- 难以创建
- 难以触发
- 响应缓慢
- 用户界面
- 尚未存在


## TDD, Test Driven Developing

一种增量式软件开发方法

实践: If tests pass, write no codes.
