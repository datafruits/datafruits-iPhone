//
//  DFRadioViewController.m
//  datafruits.fm
//
//  Created by Nikolas Nyby on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DFRadioViewController.h"
#import "DFPlayPauseView.h"

#define RADIO_LOCATION @"http://radio.datafruits.fm:8000/datafruits.mp3"

@interface DFRadioViewController () <DFPlayPauseDataSource>
@property (nonatomic, weak) IBOutlet DFPlayPauseView *playPauseView;
@end

@implementation  DFRadioViewController

@synthesize player = _player;
@synthesize playPauseView = _playPauseView;

- (bool)isPlayingForPlayPause:(DFPlayPauseView *)sender {
	return self.player.rate != 0.0;
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
	if (self.player.rate == 0.0) {
		[self.player play];
	} else {
		[self.player pause];
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
	
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

	/*NSURL *url = [NSURL URLWithString:@"http://datafruits.fm/"];
	NSString *webData = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://datafruits.fm"] encoding:NSUTF8StringEncoding error:NULL];
	if (webData != nil) {
		self.nowPlayingView.text = webData;
	}*/
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
