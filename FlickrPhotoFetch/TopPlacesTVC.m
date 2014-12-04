//
//  TopPlacesTVC.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "TopPlacesTVC.h"
#import "LQTopPlaceModel.h"
#import "LQTopPlaceTableViewSection.h"

#import "FlickrWebService.h"
#import "TopPlacesPhotosTVC.h"

static NSString * const LQTopPlacesTVCCellReuseIdentifier = @"TopPlacesTVC Cell";

@interface TopPlacesTVC ()
@property (nonatomic, strong) NSArray *topPlacesSections;
@end

@implementation TopPlacesTVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRefreshControl];
    [self updateTopPlaces];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateTopPlaces
{
    [FlickrWebService getTopPlacesInBackgroundWithCompletion:^(NSArray *results, NSError *error) {
        if (results.count > 0) [self setupTableViewSectionsWithRawTopPlaces:results];
        [self.refreshControl endRefreshing];
        NSLog(@"end refresh");
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[TopPlacesPhotosTVC class]]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            if (indexPath) {
                if ([segue.identifier isEqualToString:@"Show Top 50 Places"]) {
                    TopPlacesPhotosTVC *vc = segue.destinationViewController;
                    LQTopPlaceModel *model = [[self.topPlacesSections[indexPath.section] associatedPlaces] objectAtIndex:indexPath.row];
                    vc.topPlacesPlaceId = model.placeId;
                }
            }
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.topPlacesSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LQTopPlaceTableViewSection *sectionOb = self.topPlacesSections[section];
    return sectionOb.associatedPlaces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LQTopPlacesTVCCellReuseIdentifier forIndexPath:indexPath];
    LQTopPlaceTableViewSection *section = self.topPlacesSections[indexPath.section];
    LQTopPlaceModel *place = section.associatedPlaces[indexPath.row];
    NSMutableString *displayString = [[NSMutableString alloc] init];
    if (place.province) [displayString appendString:[NSString stringWithFormat:@"%@, ", place.province]];
    [displayString appendString:[NSString stringWithFormat:@"%@", place.state]];
    cell.textLabel.text = displayString;
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    LQTopPlaceTableViewSection *sectionOb = self.topPlacesSections[section];
    return sectionOb.countryName;
}

#pragma mark - Helper Methods
- (void)setupTableViewSectionsWithRawTopPlaces:(NSArray *)rawTopPlaces
{
    NSMutableDictionary *sectionsDict = [NSMutableDictionary dictionary];
    for (LQTopPlaceModel *place in rawTopPlaces) {
        LQTopPlaceTableViewSection *section = sectionsDict[place.country];
        if (!section) {
            section = [LQTopPlaceTableViewSection new];
            section.countryName = place.country;
            sectionsDict[place.country] = section;
        }
        [section.associatedPlaces addObject:place];
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"countryName" ascending:YES];
    self.topPlacesSections = [[sectionsDict allValues] sortedArrayUsingDescriptors:@[sortDescriptor]];
    [self.tableView reloadData];
}

#pragma mark - RefreshControl
- (void)addRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControlPulledDown:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)refreshControlPulledDown:(UIRefreshControl *)sender
{
    [self updateTopPlaces];
}

#pragma mark - Note to myself
/*
 Could there be a way to combine LQFlickrPlace and LQTopPlacesTableViewSection into one class. 
 Or at least, have TopPlacsTVC send the array from FlickrWebSerivce to only one location and return the information (self.topPlacesSection)
 How do I make it better?
*/

@end
