# NappImageView

## Description

The Napp imageView Module extends the Appcelerator Titanium Mobile framework. 
It exposes the iOS UIViewContentMode for imageView - supporting fill, fit and center modes. 

It also uses AsyncImageView https://github.com/nicklockwood/AsyncImageView for loading the image async.

## Download

Go to the `dist` folder. It has the newest version of the module.


## API

### ContentMode

Supporting: `aspectfill` `aspectfit` `center`
	

## Example usage
```javascript
var NappImageView = require('dk.napp.imageview');

var imageView = NappImageView.createImageView({
	height : "160dp",
	width : "320dp",
	contentMode : 'aspectfill',
	image : "http://designtoimprovelife.dk/wp-content/uploads/2011/03/nyhavn.jpg"
});
win.add(imageView);
```

### Another example

Using a local image path

```javascript
var NappImageView = require('dk.napp.imageview');

var imageView = NappImageView.createImageView({
	height : Ti.UI.FILL,
	width : Ti.UI.FILL,
	contentMode : 'aspectfit',
	image : "/images/background.png"
});
win.add(imageView);
```


## Changelog

**v1.0.2**
Added support for local image path 

**v1.0.1**
Added 64 bit support  
 
**v1.0**
Initial implementation. 


## Author

**Mads Møller**  
web: http://www.napp.dk  
email: mm@napp.dk  
twitter: @nappdev  


## License

    Copyright (c) 2010-2014 Napp ApS

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.