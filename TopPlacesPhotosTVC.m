//
//  TopPlacesPhotosTVC.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/3/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "TopPlacesPhotosTVC.h"
#import "LQTopPlacesPhoto.h"
#import "ImageViewController.h"
#import "FlickrWebService.h"
#import "LQApplicationSettings.h"

static int const LQMaxNumberOfResultsToDisplay = 50;
static NSString * const LQTopPlacePhotosTVCCellReuseIdentifier = @"TopPlacesPhotosTVC Cell";

@interface TopPlacesPhotosTVC ()
@property (nonatomic, strong) NSArray *arrayOfPhotoInfo;
@property (nonatomic, strong) NSArray *photoDicts;
@end

@implementation TopPlacesPhotosTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [FlickrWebService getTopPlacesWithPlaceId:self.topPlacesPlaceId withMaxResult:LQMaxNumberOfResultsToDisplay withBackgroundCompletion:^(NSArray *results, NSError *error) {
        self.arrayOfPhotoInfo = results;
        
        [self.tableView reloadData];
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfPhotoInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LQTopPlacePhotosTVCCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.arrayOfPhotoInfo[indexPath.row] tableViewDescriptionForPhoto];
    return cell;
}

#pragma mark - UITableViewDelegate
//Send didSelectRowAtIndex to DetailViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self postNotificationWithObject:self.arrayOfPhotoInfo[indexPath.row]];
        [self savePhoto:self.arrayOfPhotoInfo[indexPath.row]];
}

- (void)postNotificationWithObject:(LQTopPlacesPhoto *)photo
{
    NSString *notificationName = @"selectedPhotoInRowNotification";
    NSString *key = @"photoSelected";
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:photo forKey:key];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:dictionary];
}

#pragma mark - Navigation 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = segue.destinationViewController;
        if ([sender isKindOfClass:[UITableViewCell class]]) sender = (UITableViewCell *)sender;
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        [self savePhoto:self.arrayOfPhotoInfo[index.row]];
        ivc.photo = self.arrayOfPhotoInfo[index.row];
    }
}

#pragma mark - Saving Photos
- (void)savePhoto:(LQTopPlacesPhoto *)photo
{
    NSMutableArray *recentPhotos = [[LQApplicationSettings sharedSettings].recentPhotos mutableCopy];
    [recentPhotos insertObject:photo atIndex:0];
    [LQApplicationSettings sharedSettings].recentPhotos = recentPhotos;
}

@end
