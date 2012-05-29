//
//  DFPlayPauseView.m
//  datafruits.fm
//
//  Created by Nikolas Nyby on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DFPlayPauseView.h"

@implementation DFPlayPauseView

@synthesize dataSource = _dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawPlayIcon:(CGContextRef)context withMidPoint:(CGPoint)midPoint{
	UIGraphicsPushContext(context);
	
	CGContextMoveToPoint(context, midPoint.x - 14, midPoint.y - 18);
	CGContextAddLineToPoint(context, midPoint.x + 10, midPoint.y);
	CGContextStrokePath(context);

	CGContextMoveToPoint(context, midPoint.x + 10, midPoint.y);
	CGContextAddLineToPoint(context, midPoint.x - 14, midPoint.y + 18);
	CGContextStrokePath(context);
	
	UIGraphicsPopContext();
}

- (void)drawPauseIcon:(CGContextRef)context withMidPoint:(CGPoint)midPoint {
	UIGraphicsPushContext(context);
	
	CGFloat w = 12;
	CGFloat h = 24;

	[[UIColor whiteColor] setStroke];
	CGContextMoveToPoint(context, midPoint.x - w+2, midPoint.y - h+4);
	CGContextAddLineToPoint(context, midPoint.x - w+2, midPoint.y + h+4);
	CGContextStrokePath(context);
	
	CGContextMoveToPoint(context, midPoint.x + w+2, midPoint.y - h+4);
	CGContextAddLineToPoint(context, midPoint.x + w+2, midPoint.y + h+4);
	CGContextStrokePath(context);

	[[UIColor redColor] setStroke];
	CGContextMoveToPoint(context, midPoint.x - w, midPoint.y - h);
	CGContextAddLineToPoint(context, midPoint.x - w, midPoint.y + h);
	CGContextStrokePath(context);
	
	CGContextMoveToPoint(context, midPoint.x + w, midPoint.y - h);
	CGContextAddLineToPoint(context, midPoint.x + w, midPoint.y + h);
	CGContextStrokePath(context);
	
	UIGraphicsPopContext();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGPoint midPoint;
	midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
	
	CGFloat size = self.bounds.size.width / 2;
	if (self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height / 2;
	size *= 0.9;

	CGContextSetLineWidth(context, 5.0);
	[[UIColor whiteColor] setStroke];
	CGContextAddArc(context, midPoint.x+2, midPoint.y+4, size, 0, 2*M_PI, YES);
	CGContextStrokePath(context);

	CGContextSetLineWidth(context, 10.0);
	if (![self.dataSource isPlayingForPlayPause:self]) {
		[[UIColor greenColor] setStroke];
		[self drawPlayIcon:context withMidPoint:midPoint];
	} else {
		[[UIColor redColor] setStroke];
		[self drawPauseIcon:context withMidPoint:midPoint];
	}

	CGContextSetLineWidth(context, 5.0);
	//CGContextBeginPath(context);
	CGContextAddArc(context, midPoint.x, midPoint.y, size, 0, 2*M_PI, YES);
	CGContextStrokePath(context);
}

@end
