//
//  DFTwitterViewController.h
//  datafruits.fm
//
//  Created by Nikolas Nyby on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFTwitterViewController : UIViewController {
}

- (void)fetchTweets;
- (BOOL)userHasAccessToTwitter;

@property (nonatomic) ACAccountStore *accountStore;
@property (nonatomic) NSDate *lastTwitterRequest;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextView *tweetView1;
@property (weak, nonatomic) IBOutlet UITextView *tweetView2;
@property (weak, nonatomic) IBOutlet UITextView *tweetView3;
@property (weak, nonatomic) IBOutlet UITextView *tweetView4;

@end
