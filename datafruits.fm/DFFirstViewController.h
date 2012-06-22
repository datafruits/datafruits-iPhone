//
//  DFFirstViewController.h
//  datafruits.fm
//
//  Created by Nikolas Nyby on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

@interface DFFirstViewController : UIViewController {
	NSURL *urlStream;
}

@property AVPlayer *player;

@end