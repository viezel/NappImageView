/**
 * Module developed by Napp ApS
 * www.napp.dk
 * Mads Møller
 * (c) 2014 Napp ApS
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import <UIKit/UIKit.h>
#import "TiBase.h"
#import "TiUIView.h"
#import "AsyncImageView.h"

@interface DkNappImageviewImageView : TiUIView {

@private
    UIViewContentMode contentMode;
    bool clipsToBounds;
    AsyncImageView *imageView;
}

-(void)setImage_:(id)args;
-(void)setContentMode_:(id)args;
-(void)setClipsToBounds_:(id)clips;

@end
