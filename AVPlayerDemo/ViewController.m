//
//  ViewController.m
//  AVPlayer
//
//  Created by apple on 13-5-19.
//  Copyright (c) 2013年 iMoreApp Inc. All rights reserved.
//

#import "ViewController.h"
#import "MovieInfosViewController.h"


@interface ViewController () {
    NSArray *_files;
    NSArray *_networkfiles;
}

@end

@implementation ViewController

- (void)reloadFiles
{
    // Local files
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSLog(@"Document path: %@", docPath);
    
    NSArray *files = [[NSFileManager defaultManager]
                      contentsOfDirectoryAtPath:docPath error:NULL];
    
    NSMutableArray *mediaFiles = [NSMutableArray array];
    for (NSString *f in files) {
        NSString *extname = [[f pathExtension] lowercaseString];
        if ([@[@"avi",@"dat",@"vob",@"mts",@"rm",@"rmvb",@"ts",@"flv",@"mkv",@"wmv",@"swf",@"ogg",@"mpg",@"wma", @"aac",@"asx"] indexOfObject:extname] != NSNotFound) {
            [mediaFiles addObject:[docPath stringByAppendingPathComponent:f]];
        }
    }
    _files = mediaFiles;
    
    // Network files
    _networkfiles = @[
                      @{@"url":@"",@"title":@"Test 1"},
                      
                      @{@"url":@"http://bbcmedia.ic.llnwd.net/stream/bbcmedia_intl_lc_radio3_p?s=1385969411&e=1385983811&h=d556876111f0fae74dde82be40057bb6%20Title1=No%20Title%20Length1=-1%20File2=http://bbcmedia.ic.llnwd.net/stream/bbcmedia_intl_lc_radio3_q?s=1385969411&e=1385983811&h=9ed565df61985a3a49e9fe7144ece7ce%20Title2", @"title":@"BBC radio 3"},
                      
                      @{@"url":@"http://savevideo.me/download/?url=http%253A%252F%252Fr16---sn-cxg7en7d.c.youtube.com%252Fvideoplayback%253Fip%253D31.131.252.26%2526cp%253DU0hWRVJSU19HTUNONl9KTFdFOkhCVGg5UTRYNEdy%2526itag%253D22%2526key%253Dyt1%2526mt%253D1370250560%2526fexp%253D914060%25252C916612%25252C900352%25252C924605%25252C928201%25252C901208%25252C929123%25252C929915%25252C929906%25252C925714%25252C929919%25252C929119%25252C931202%25252C932802%25252C928017%25252C912512%25252C912518%25252C911416%25252C906906%25252C904476%25252C904830%25252C930807%25252C919373%25252C906836%25252C933701%25252C912711%25252C929606%25252C910075%2526ms%253Dau%2526ipbits%253D8%2526ratebypass%253Dyes%2526expire%253D1370275423%2526upn%253DeSzNGSOTx3w%2526id%253Dc41ccf8a8a61f022%2526sparams%253Dcp%25252Cid%25252Cip%25252Cipbits%25252Citag%25252Cratebypass%25252Csource%25252Cupn%25252Cexpire%2526mv%253Dm%2526sver%253D3%2526source%253Dyoutube%2526newshard%253Dyes%26fallback_host%3Dtc.v19.cache3.c.youtube.com%26quality%3Dhd720%26signature%3D3DE5ACEB68A491F18C13910730D93E9B0039460E.0D6FC07FEFE2DB102A0F929A99F0E3E6963847A6", @"title":@"Test 3"},
                      
                      @{@"url":@"http://savevideo.me/download/?url=http%253A%252F%252Fr1---sn-cxg7en7d.c.youtube.com%252Fvideoplayback%253Fmt%253D1370251939%2526itag%253D45%2526ratebypass%253Dyes%2526upn%253DL4AQIUcdtLU%2526ip%253D31.131.252.26%2526key%253Dyt1%2526cp%253DU0hWRVJSVF9FUUNONl9KTFhFOmtWNWlRQnNZd0FC%2526ms%253Dau%2526ipbits%253D8%2526mv%253Dm%2526source%253Dyoutube%2526sparams%253Dcp%25252Cid%25252Cip%25252Cipbits%25252Citag%25252Cratebypass%25252Csource%25252Cupn%25252Cexpire%2526expire%253D1370276407%2526id%253D0bfb6ddecc6d92f6%2526newshard%253Dyes%2526sver%253D3%2526fexp%253D923420%25252C929206%25252C916624%25252C901473%25252C900352%25252C924605%25252C928201%25252C901208%25252C929123%25252C929915%25252C929906%25252C925714%25252C929919%25252C929119%25252C931202%25252C932802%25252C928017%25252C912512%25252C912518%25252C911416%25252C906906%25252C904476%25252C930807%25252C919373%25252C906836%25252C933701%25252C926403%25252C912711%25252C929606%25252C910075%26quality%3Dhd720%26signature%3D4E4D2D336DD4E980369F9C593587A1244DADAD3C.C4CD99630311171E744A1F09E07AC4CBA82D0119%26fallback_host%3Dtc.v12.cache6.c.youtube.com", @"title":@"Test 4"}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reloadFiles];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _networkfiles.count;
        case 1:
            return _files.count;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileTableCell" forIndexPath:indexPath];
    
    NSString *file = nil;
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [_networkfiles objectAtIndex:indexPath.row][@"title"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            file = [_files objectAtIndex:indexPath.row];

            cell.textLabel.text = [file lastPathComponent];
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Kanaler";
       
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMoviePlayer"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        
        UIViewController *controller = segue.destinationViewController;
        if ([controller isKindOfClass:[AVPlayerViewController class]]) {
            AVPlayerViewController *playerController = (AVPlayerViewController *)controller;
            
            switch (indexPath.section) {
                case 0:
                    playerController.mediaPath = [_networkfiles objectAtIndex:indexPath.row][@"url"];
                    break;
                case 1:
                    playerController.mediaPath = [_files objectAtIndex:indexPath.row];
                    break;
            }
        }
    }
    else if ([segue.identifier isEqualToString:@"showMovieInfos"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];

        UIViewController *controller = segue.destinationViewController;
        if ([controller isKindOfClass:[MovieInfosViewController class]]) {
            MovieInfosViewController *infosController = (MovieInfosViewController *)controller;
            
            switch (indexPath.section) {
                case 0:
                    break;
                case 1:
                    infosController.moviePath = [_files objectAtIndex:indexPath.row];
                    break;
            }
        }
    }
}

- (IBAction)refresh:(id)sender {
    
    [self reloadFiles];
    [self.tableView reloadData];
}
@end

