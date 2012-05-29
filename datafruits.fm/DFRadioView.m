//
//  DFRadioView.m
//  datafruits.fm
//
//  Created by Nikolas Nyby on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DFRadioView.h"

@implementation DFRadioView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	UIImage *image = [UIImage imageNamed: @"london.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}


@end
