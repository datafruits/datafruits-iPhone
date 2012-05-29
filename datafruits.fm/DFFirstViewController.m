//
//  DFFirstViewController.m
//  datafruits.fm
//
//  Created by Nikolas Nyby on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DFFirstViewController.h"
#import "DFPlayPauseView.h"

#define RADIO_LOCATION @"http://radio.sub.fm:8529"

@interface DFFirstViewController () <DFPlayPauseDataSource>
@property (nonatomic, weak) IBOutlet DFPlayPauseView *playPauseView;
@end

@implementation  DFFirstViewController {
	CFReadStreamRef stream;
}

@synthesize isPlaying = _isPlaying;
@synthesize player = _player;
@synthesize playPauseView = _playPauseView;

- (bool)isPlayingForPlayPause:(DFPlayPauseView *)sender {
	return self.isPlaying;
}

- (void)setPlayPauseView:(DFPlayPauseView *)playPauseView {
	_playPauseView = playPauseView;
	[self.playPauseView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePlayPauseTap:)]];
	self.playPauseView.dataSource = self;
}

- (void)handlePlayPauseTap:(UITapGestureRecognizer *)gesture {
	[self changePlaying];
	[self.playPauseView setNeedsDisplay];
}

- (void)changePlaying {
	if (!self.isPlaying) {
	 	[self.player play];
		self.isPlaying = YES;
	} else {
		[self.player pause];
		self.isPlaying = NO;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	urlStream = [NSURL URLWithString:RADIO_LOCATION];   
	self.player = [AVPlayer playerWithURL:urlStream];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
