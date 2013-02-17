//
//  DFTwitterViewController.m
//  datafruits.fm
//
//  Created by Nikolas Nyby on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "DFTwitterViewController.h"

@interface DFTwitterViewController ()

@end

@implementation DFTwitterViewController

@synthesize accountStore = _accountStore;
@synthesize lastTwitterRequest = _lastTwitterRequest;
@synthesize activityIndicator = _activityIndicator;
@synthesize tweetView1 = _tweetView1;
@synthesize tweetView2 = _tweetView2;
@synthesize tweetView3 = _tweetView3;
@synthesize tweetView4 = _tweetView4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

	NSDate *fiveMinutesAgo = [[NSDate date] dateByAddingTimeInterval:-300];
	if (self.lastTwitterRequest == nil
		|| [self.lastTwitterRequest compare:fiveMinutesAgo] == NSOrderedAscending
	) {
		//NSLog(@"refreshing tweets");
		//NSLog(@"fiveMinutesAgo: %@", fiveMinutesAgo);
		//NSLog(@"lastTwitterRequest: %@", self.lastTwitterRequest);
		self.tweetView1.text = @"";
		self.tweetView2.text = @"";
		self.tweetView3.text = @"";
		self.tweetView4.text = @"";
		[self.activityIndicator startAnimating];
		[self fetchTweets];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.accountStore = [[ACAccountStore alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)userHasAccessToTwitter
{
	return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}

- (void)fetchTweets
{
	if ([self userHasAccessToTwitter]) {
		//  Step 1:  Obtain access to the user's Twitter accounts
		ACAccountType *twitterAccountType = [self.accountStore
											 accountTypeWithAccountTypeIdentifier:
											 ACAccountTypeIdentifierTwitter];

		[self.accountStore
		 requestAccessToAccountsWithType:twitterAccountType
		 options:nil
		 completion:^(BOOL granted, NSError *error) {
			 if (granted) {
				 //  Step 2:  Create a request
				 NSArray *twitterAccounts =
				 [self.accountStore accountsWithAccountType:twitterAccountType];

				 NSURL *url =
				 [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
				 NSDictionary *params = @{@"screen_name" : @"datafruits",
							  @"include_rts" : @"1",
							  @"trim_user" : @"1",
							  @"count" : @"4"};

				 SLRequest *request =
				 [SLRequest requestForServiceType:SLServiceTypeTwitter
									requestMethod:SLRequestMethodGET
											  URL:url
									   parameters:params];

				 //  Attach an account to the request
				 [request setAccount:[twitterAccounts lastObject]];

				 //  Step 3:  Execute the request
				 [request performRequestWithHandler:^(NSData *responseData,
													  NSHTTPURLResponse *urlResponse,
													  NSError *error) {
					 if (responseData) {
						 if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
							 NSError *jsonError;
							 NSArray *timelineData =
							 [NSJSONSerialization
							  JSONObjectWithData:responseData
							  options:NSJSONReadingAllowFragments error:&jsonError];

							 if (timelineData) {
								 self.lastTwitterRequest = [NSDate date];

								 NSInteger count = [timelineData count];
								 for (int i = 0; i < count; i++) {
									 NSDictionary *tweet = [timelineData objectAtIndex:i];
									 NSString *tweetText = [tweet valueForKey:@"text"];

									 UITextView *tweetView = [self valueForKey:
															  [@"tweetView" stringByAppendingString:
															   [NSString stringWithFormat:@"%d", i+1]]];

									 dispatch_async(dispatch_get_main_queue(), ^{
										 tweetView.text = tweetText;
										 [self.activityIndicator stopAnimating];
									 });
								 }
							 }
							 else {
								 // Our JSON deserialization went awry
								 NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
							 }
						 }
						 else {
							 // The server did not respond successfully... were we rate-limited?
							 NSLog(@"The response status code is %d", urlResponse.statusCode);
						 }
					 }
				 }];
			 } else {
				 // Access was not granted, or an error occurred
				 NSLog(@"%@", [error localizedDescription]);
				 dispatch_async(dispatch_get_main_queue(), ^{
					 [self.activityIndicator stopAnimating];
					 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Accounts found"
																	 message:@"Add a Twitter account in Settings!"
																	delegate:nil
														   cancelButtonTitle:@"OK"
														   otherButtonTitles:nil];
					 [alert show];
				 });
			 }
		 }];
	}
}

@end
