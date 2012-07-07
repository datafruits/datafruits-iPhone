//
//  DFTwitterViewController.h
//  datafruits.fm
//
//  Created by Nikolas Nyby on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFTwitterViewController : UIViewController {
	NSArray *tweets;
}

- (void)fetchTweets;

@end
