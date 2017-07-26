---
weight: 20
title: JS
---
## Practice of JavaScript Performance

Since JavaScript becomes a fullstack programming language, in certain cases the performance of JS is critical. Here are some practice of JS, with some understanding of JS implementation.

### Data Store
How a variable is create will effect its performance.
- Use *{}* instead of *new Object*, use *[]* instead of new Array, use plain string instead of an object.
- Use local temporary variable to store variable deep upon the data-chain, and values require many calculation.
- dot-present has a similar performance as member operator, and it's faster in Safari. object.name vs object[name], object.name is always faster.

### Loop
In Chromium v54, `for-in` is slower, and `for (var i = 0; i < length; ++i)`, `[].forEach(()=>{})` have similar performance. forEach is much faster than it was in earlier browser.

### Event Delegate
It will cause too much loads and occupy too many memory binding the same event to massive elements in the page.
It better to bind event to the outer layer, and deal with all events of its child elements.

```
document.getElementById('content').addEventListener('click', function(evt) {
    evt = evt || window.event;
    let target = evt.target || evt.srcElement;
    if (target.nodeName.toLowerCase() !== 'a')
        return;
    console.log(target.href);
});
```

### Re-Render
The source files create 2 trees in browser: DOM tree and Render tree.
Render tree deal with DOM geometry attributions. When the style of DOM changes, browser re-render the DOM.
```
bodystyle = document.body.style; 
bodystyle.color = red; 
bodystyle.height = 1000px; 
bodystyke.width = 100%;
```
Three times of modification will cause 3 re-renders. Under certain circumstances, reduce the times of modification will improve rendering performance.
```
bodystyle = document.body.style; 
bodystyle.cssText 'color:red;height:1000px;width:100%';
```

### JavaScript Load
\<script\> tag might block something from downloading, so it's a good practice to put more script tag at the bottom of DOM, to avoid the time of empty page displayed to users.

### JavaScript Deployment
Reduce the number of requirements and the file sizes will accelerate the page loading speed.
For example, use *webpack* and *uglify*.

### Cache JS Files
Cached files will improve the speed of page loading. Web servers use "Expires HTTP Resonse Header" to tell browser how long a resource should be cached. To avoid the problem of using old version of file, you can change the filename of static resource, like bundle-201612242359.js, using a timestamp to force browser to load the new js file.

