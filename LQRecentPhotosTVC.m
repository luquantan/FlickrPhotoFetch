//
//  LQRecentPhotosTVC.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/6/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "LQRecentPhotosTVC.h"
#import "LQApplicationSettings.h"
#import "LQTopPlacesPhoto.h"
#import "ImageViewController.h"

static NSString * const LQRecentPhotosTVCCellReuseIdentifier = @"LQRecentPhotosTVC Cell";

@interface LQRecentPhotosTVC ()
@property (nonatomic, strong) NSArray *recentPhotos;
@end

@implementation LQRecentPhotosTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self recentPhotos];
    [self.tableView reloadData];
}

- (NSArray *)recentPhotos
{
    _recentPhotos = [LQApplicationSettings sharedSettings].recentPhotos;
    return _recentPhotos;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recentPhotos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LQRecentPhotosTVCCellReuseIdentifier forIndexPath:indexPath];
    LQTopPlacesPhoto *photo = self.recentPhotos[indexPath.row];
    cell.textLabel.text = [photo tableViewDescriptionForPhoto];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *index = [self.tableView indexPathForCell:sender];
            ImageViewController *ivc = segue.destinationViewController;
            ivc.photo = self.recentPhotos[index.row];
        }
    }
}

@end
