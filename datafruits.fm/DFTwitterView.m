//
//  DFTwitterView.m
//  datafruits.fm
//
//  Created by Nikolas Nyby on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DFTwitterView.h"

@implementation DFTwitterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
	 UIImage *image = [UIImage imageNamed: @"twitterbg.png"];
	 [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}


@end
