---
layout: post
title: Push Page Footer to Window Bottom by Pure CSS
date: '2010-01-06 15:53:57'
tags:
- tech
- coding
- css
---

Push Page Footer to Window Bottom by Pure CSS
=============================================

First comes my html structure.

```HTML
<body>
  <div id="hd"></div>
  <div id="bd">
    <div class="layout"></div>
  </div>
  <div id="ft"></div>
</body>
```

- - -
Then css

```CSS
html,body {
  /* required,or div#bd could not expand to full page height */
  height:100%; 
}
#hd {
  height:50px;
  /* use negative margin-bottom of #hd instead of negative margin-top of #bd */
  margin-bottom:-50px; 
}
#bd {
  /* doesn't work under fucking IE6,write JS for it */
  min-height:100%; 
}
#bd .layout {
  /* 50px on top for header and 50px on bottom for footer */
  padding:50px 0 50px 0;
}
#ft {
  /* I didn't use -50px curz I like to leave some while in the page bottom edge */
  margin-top:-30px; 
}
```
