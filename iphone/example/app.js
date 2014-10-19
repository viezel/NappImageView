var win = Ti.UI.createWindow({
	backgroundColor : 'white'
});
win.open();

var NappImageView = require('dk.napp.imageview');

var imageView = NappImageView.createImageView({
	top: 40,
	height : "160dp",
	width : "320dp",
	contentMode : 'aspectfill',
	clipsToBounds : true,
	image : "http://designtoimprovelife.dk/wp-content/uploads/2011/03/nyhavn.jpg"
});
win.add(imageView);

var contentMode = "aspectfill";
var btn = Ti.UI.createButton({
	title: "contentMode: " + contentMode,
	bottom:40
});
btn.addEventListener("click", function(){
	
	if(contentMode == "aspectfill"){
		contentMode = 'center';
		
	} else if(contentMode == "center"){
		contentMode = 'aspectfit';
		
	} else if(contentMode == "aspectfit"){
		contentMode = 'aspectfill';
	}
	
	imageView.contentMode = contentMode;
	btn.title = "contentMode: " + contentMode;
});
win.add(btn);