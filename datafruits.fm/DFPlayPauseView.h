//
//  DFPlayPauseView.h
//  datafruits.fm
//
//  Created by Nikolas Nyby on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFPlayPauseView;

@protocol DFPlayPauseDataSource
- (bool)isPlayingForPlayPause:(DFPlayPauseView *)sender;
@end

@interface DFPlayPauseView : UIView

@property (nonatomic, weak) IBOutlet id <DFPlayPauseDataSource> dataSource;

@end
