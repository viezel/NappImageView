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


@end
