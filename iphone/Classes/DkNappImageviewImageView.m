/**
 * Module developed by Napp ApS
 * www.napp.dk
 * Mads Møller
 * (c) 2014 Napp ApS
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "DkNappImageviewImageView.h"

@implementation DkNappImageviewImageView

-(void)initializeState
{
    [super initializeState];
    
    if (self)
    {
        imageView = [[AsyncImageView alloc] initWithFrame:[self frame]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(imageFailed:)
                                                     name:AsyncImageLoadDidFail
                                                   object:nil];
        
        [self addSubview:imageView];
    }
}

- (void)imageFailed:(NSNotification *)notification
{
    NSURL *URL = (notification.userInfo)[AsyncImageURLKey];
    [self configureDefaultImage];
    [[AsyncImageLoader sharedLoader] cancelLoadingURL:URL];
    NSLog(@"[WARN] NappImageView :: WARN :: Loading image failed: %@", [URL absoluteString]);
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    for (UIView *child in [self subviews])
    {
        [TiUtils setView:child positionRect:bounds];
    }
    
    [super frameSizeChanged:frame bounds:bounds];
}

-(void)setImage_:(id)args
{
    //cancel loading previous image
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];
    
    NSString *url = [TiUtils stringValue:args];
    
    if([self validateUrl:url]){
        
        // add new url
        imageView.imageURL = [NSURL URLWithString:[TiUtils stringValue:args]];
    } else {
        // local
        imageView.image = [self findImage:url];
    }
    
}

-(void)setContentMode_:(id)args
{
    // Keeping the old way there for legacy reasons. Should be removed in the next release.
    if([args isKindOfClass:[NSString class]]) {
        NSLog(@"[WARN] NappImageView :: WARN :: The string argument for 'contentMode' is deprecated. Please use one of the CONTENT_MODE_* constants instead.");
        
        NSString * modestr = [TiUtils stringValue:args];
        if ([@"aspectfit" isEqualToString:modestr]) {
            contentMode = UIViewContentModeScaleAspectFit;
        }
        else if ([@"aspectfill" isEqualToString:modestr]) {
            contentMode = UIViewContentModeScaleAspectFill;
        }
        else if ([@"center" isEqualToString:modestr]) {
            contentMode = UIViewContentModeCenter;
        }
        else {
            contentMode = UIViewContentModeScaleAspectFit;
        }
        
        [imageView setContentMode:contentMode];
        return;
    }
    
    ENSURE_TYPE(args, NSNumber);
    
    [imageView setContentMode:[TiUtils intValue:args def:UIViewContentModeScaleAspectFit]];
}

-(void)setClipsToBounds_:(id)clips {
    clipsToBounds = [TiUtils boolValue:clips def:NO];
    imageView.clipsToBounds = clipsToBounds;
}

/// validate a URL
- (BOOL)validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

/// find image locally
-(UIImage *)findImage:(NSString *)imagePath
{
    if(imagePath != nil){
        UIImage *image = nil;
        
        //image from URL
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
        if(image != nil){
            return image;
        }
        
        //load remote image
        image = [UIImage imageWithContentsOfFile:imagePath];
        if(image != nil){
            return image;
        }
        
        // Load the image from the application assets
        NSString *fileNamePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imagePath];;
        image = [UIImage imageWithContentsOfFile:fileNamePath];
        if (image != nil) {
            return image;
        }
        
        //Load local image by extracting the filename without extension
        NSString* newImagePath = [[imagePath lastPathComponent] stringByDeletingPathExtension];
        image = [UIImage imageNamed:newImagePath];
        if(image != nil){
            return image;
        }
        
        [self configureDefaultImage];
    }
    return nil;
}

-(void)configureDefaultImage
{
    NSURL *defURL = [TiUtils toURL:[self.proxy valueForKey:@"defaultImage"] proxy:self.proxy];
    
    if (defURL == nil && ![TiUtils boolValue:[self.proxy valueForKey:@"preventDefaultImage"] def:NO])
    {	//This is a special case, because it IS built into the bundle despite being in the simulator.
        NSString * filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"modules/ui/images/photoDefault.png"];
        defURL = [NSURL fileURLWithPath:filePath];
    }
    
    if (defURL != nil) {
        [imageView setImageURL:defURL];
    } else {
        // Image failed and no default image existing.
    }
}


@end
