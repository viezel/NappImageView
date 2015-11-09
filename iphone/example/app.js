var index = 0;
var win = Ti.UI.createWindow({
	backgroundColor : 'white'
});
win.open();

var NappImageView = require('dk.napp.imageview');
var contentModes = [{
	title: "Aspect Fill",
	value: NappImageView.CONTENT_MODE_ASPECT_FILL
},{
	title: "Center",
	value : NappImageView.CONTENT_MODE_CENTER
},{
	title: "Aspect Fit",
	value : NappImageView.CONTENT_MODE_ASPECT_FIT
}, {
	title: "Scale To Fit",
	value : NappImageView.CONTENT_MODE_SCALE_TO_FIT
}, {
	title: "Redraw",
	value : NappImageView.CONTENT_MODE_REDRAW
}, {
	title: "Top",
	value : NappImageView.CONTENT_MODE_TOP
}, {
	title: "Bottom",
	value : NappImageView.CONTENT_MODE_BOTTOM
}, {
	title: "Left",
	value : NappImageView.CONTENT_MODE_LEFT
}, {
	title: "Right",
	value : NappImageView.CONTENT_MODE_RIGHT
}, {
	title: "Top Left",
	value : NappImageView.CONTENT_MODE_TOP_LEFT
}, {
	title: "Top Right",
	value : NappImageView.CONTENT_MODE_TOP_RIGHT
}, {
	title: "Bottom Left",
	value : NappImageView.CONTENT_MODE_BOTTOM_LEFT
}, {
	title: "Bottom Right",
	value : NappImageView.CONTENT_MODE_BOTTOM_RIGHT
}];

var imageView = NappImageView.createImageView({
	top: 40,
	height : 160,
	width : 320,
	contentMode : NappImageView.CONTENT_MODE_ASPECT_FILL,
	clipsToBounds : true,
	// defaultImage : "/images/DefaultIcon.png",
	image : "http://designtoimprovelife.dk/wp-content/uploads/2011/03/nyhavn.jpg"
});
win.add(imageView);

var btn = Ti.UI.createButton({
	title: "contentMode: " + contentModes[index++].title,
	bottom:40
});
btn.addEventListener("click", function(){

	if(index == contentModes.length) {
		index = 0;
	}

	contentMode = contentModes[index++];

	imageView.contentMode = contentMode.value;
	btn.title = "contentMode: " + contentMode.title;
});
win.add(btn);
