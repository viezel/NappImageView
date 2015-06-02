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
        [self addSubview:imageView];
    }
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
    
    // add new url
    imageView.imageURL = [NSURL URLWithString:[TiUtils stringValue:args]];
}

-(void)setContentMode_:(id)args
{
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
    
    imageView.contentMode = contentMode;
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
        NSLog(@"NappImageView :: ERROR :: image not found");
    }
    return nil;
}


@end
