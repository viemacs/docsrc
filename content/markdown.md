---
weight: 20
title: Errors
draft: true
---

# Markdown Grammar

A First Level Header
====================
A Second Level Header
---------------------
# Level 1 Header
## Level 2 Header
### Level 3 Header
#### Level 4 Header
##### Level 5 Header
###### Level 6 Header

```
A First Level Header
====================
A Second Level Header
---------------------
# Level 1 Header
## Level 2 Header
### Level 3 Header
#### Level 4 Header
##### Level 5 Header
###### Level 6 Header
```

### Instruction
Generally, you don't need to deal with < and & in markdown as in HTML. They will be escaped automatically if they are in a HTML tag or an escaped character.
When you need to input content that has grammar meaning in markdown, it might be needed to escape certain characters with backslash '\\'.

### Paragraphs and quotes.

This is another paragraph. Empty line (empty or only spaces and tabs) devides paragraphs.

'>' creates quotes. Other markdown grammars can work inside quote.

> This is a blockquote.
> 
> This is the second paragraph in the blockquote.
>
> ### This is an H3 in a blockquote

> A single '>' leading the first
line will also work fine.
>> A nested quote.

```
> This is a blockquote.
> 
> This is the second paragraph in the blockquote.
>
> ### This is an H3 in a blockquote

> A single '>' leading the first
line will also work fine.
>> A nested quote.
```

### Emphasize

Some of these words *are emphasized*.
Some of these words _are emphasized also_.
Use two asterisks for **strong emphasis**.
Or, if you prefer, __use two underscores instead__.

```
Some of these words *are emphasized*.
Some of these words _are emphasized also_.
Use two asterisks for **strong emphasis**.
Or, if you prefer, __use two underscores instead__.
```

### List

#### ul
You can use *, +, - to create *li*, and *ul* is create automatically.

* C/C++
* Python
* JavaScript
+ Bash
+ Haskell
- Go
- Java

```
* C/C++
* Python
* JavaScript
+ Bash
+ Haskell
- Go
- Java
```

Use number followed by dot '.' to create an *ol*. The numbers do have to be in order, at least for now.
An item can contains multiple pargraphs, as long as they are indented with 4 spaces or a tab.

1. A list item.

    With multiple paragraphs.

2. Another item in the list

```
1. A list item.

    With multiple paragraphs.

2. Another item in the list
```

### Link

This is an [example of inline link](https://github.com/viemacs/blog "With a title").
```
This is an [example of inline link](https://github.com/viemacs/blog "With a title").
```

These are examples of referenced links:
[Github][1], [Google][], [StackOverflow][SO].
[1]: http://github.com/ "Github"
[Google]: <http://google.com/> 'Google'
[SO]: http://stackoverflow.com/ (stack overflow)
The definition of referenced links do not appear in DOM.

```
[Github][1], [Google][2], [StackOverflow][SO].
[1]: http://github.com/ "Github"
[Google]: <http://google.com/> 'Google'
[SO]: http://stackoverflow.com/ (stack overflow)
```

The benefit of referenced links are not writability, but readability.

#### Anchor
([Ref](http://stackoverflow.com/questions/5319754/cross-reference-named-anchor-in-markdown))

```
Take me to [pookie](#pookie)
```
should be the correct markdown syntax to jump to the anchor point named pookie.

To insert an anchor point of that name use HTML:
```
<a name="pookie"></a>
```
Markdown doesn't seem to mind where you put the anchor point. A useful place to put it is in a header. For example:

```
\### <a name="tith"></a>This is the Heading
```

Note: in html5 'id' creates a global variable, so 'name' is more friendly.


### Image
The format of image is like the link, just with an extra leading '!'.
![](https://github.com/fluidicon.png "Octocat")
```
![](https://github.com/fluidicon.png "Octocat")
```

### Code
Backquote '`' is used to quote code, and more backquotes can wrap less backquotes inside it.

Code in line `function(){}`: `` `function(){}` ``.

And ``let foo = `Das ist ${value}` ``: ``` ``let foo = `Das ist ${value}` `` ```.

Code block:
```
def foo():
    pass
```
Markdown source:
<pre><code>```
def foo():
    pass
```</code></pre>

### divide line
Divide line can be generated by repeat one of asterisk *, dash -, underscore _ more than three times. Spaces can be put between them, but other content is not allowed in the line.

* * *
---
___

```

* * *
---
___
```

### Auto Link
`<http://example.com/>`

will be translated to

`<a href="http://example.com/">http://example.com/</a>`

And e-mail address will be translated into 16-bit HTML entities to fool some email collector.

`<address@example.com>`

will be translated to

`<a href="&#x6D;&#x61;i&#x6C;&#x74;&#x6F;:&#x61;&#x64;&#x64;&#x72;&#x65;
&#115;&#115;&#64;&#101;&#120;&#x61;&#109;&#x70;&#x6C;e&#x2E;&#99;&#111;
&#109;">&#x61;&#x64;&#x64;&#x72;&#x65;&#115;&#115;&#64;&#101;&#120;&#x61;
&#109;&#x70;&#x6C;e&#x2E;&#99;&#111;&#109;</a>`

which in plain HTML is

`<a href="mailto:address@example.com">address@example.com</a>`

### Character Escape
The following characters can be escaped by '\\' and displayed as normal characters instead of special functional controller.

```
\   backslash
`   backquote
*   asterisk
_   underscore
{}  braces
[]  brackets
()  parentheses
#   hask tag
+   plus sign
-   minus sign
.   period
!   exclamation
```