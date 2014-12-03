//
//  TopPlacesTVC.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "TopPlacesTVC.h"
#import "LQTopPlaceModel.h"
#import "LQTopPlacesTableViewSection.h"

#import "FlickrWebService.h"
#import "TopPlacesPhotosTVC.h"

@interface TopPlacesTVC ()
@property (nonatomic, strong) NSArray *topPlacesSections;
@end

@implementation TopPlacesTVC
- (void)viewDidLoad {
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
        [self.refreshControl endRefreshing]; NSLog(@"end refresh");
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.topPlacesSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LQTopPlacesTableViewSection *sectionOb = self.topPlacesSections[section];
    return sectionOb.associatedPlaces.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopPlacesTVC Cell" forIndexPath:indexPath];
 
    LQTopPlacesTableViewSection *section = self.topPlacesSections[indexPath.section];
    LQTopPlaceModel *place = section.associatedPlaces[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", place.province, place.state];
    return cell;
}

#pragma mark - Table View Delegate Methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    LQTopPlacesTableViewSection *sectionOb = self.topPlacesSections[section];
    return sectionOb.countryName;
}
#pragma mark - Helper Methods
- (void)setupTableViewSectionsWithRawTopPlaces:(NSArray *)rawTopPlaces
{
    NSMutableDictionary *sectionsDict = [NSMutableDictionary dictionary];
    for (LQTopPlaceModel *place in rawTopPlaces) {
        LQTopPlacesTableViewSection *section = sectionsDict[place.country];
        if (!section) {
            section = [LQTopPlacesTableViewSection new];
            section.countryName = place.country;
            sectionsDict[place.country] = section;
        }
        [section.associatedPlaces addObject:place];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"countryName" ascending:YES];
    self.topPlacesSections = [[sectionsDict allValues] sortedArrayUsingDescriptors:@[sortDescriptor]];

    [self.tableView reloadData];
    
//    NSArray *countries = [self.topPlaces valueForKey:LQFlickrPlaceCountryPropertyKey];
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
//    NSSet *uniqueNames = [NSSet setWithArray:countries];
//    self.uniqueCountries = [[uniqueNames allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]];
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


#pragma mark - other tableview related methods
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Extra Code

//- (void)setupTableViewSectionsWithSortedTopPlaces:(NSArray *)sortedTopPlaces
//{
//    NSMutableArray *topPlacesSections = [NSMutableArray array];
//    for (LQFlickrPlace *place in sortedTopPlaces) {
//        LQTopPlacesTableViewSection *section = [topPlacesSections lastObject];
//        if (!section) {
//            section = [LQTopPlacesTableViewSection new];
//            section.countryName = place.country;
//            [section.associatedPlaces addObject:place];
//            [topPlacesSections addObject:section];
//        } else if ([section.countryName isEqualToString:place.country]) {
//            [section.associatedPlaces addObject:place];
//        } else {
//            LQTopPlacesTableViewSection *newSection = [LQTopPlacesTableViewSection new];
//            newSection.countryName = place.country;
//            [newSection.associatedPlaces addObject:place];
//            [topPlacesSections addObject:newSection];
//        }
//    }
//    self.topPlacesSections = topPlacesSections;
//
//    [self.tableView reloadData];
//    //    NSArray *countries = [self.topPlaces valueForKey:LQFlickrPlaceCountryPropertyKey];
//    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
//    //    NSSet *uniqueNames = [NSSet setWithArray:countries];
//    //    self.uniqueCountries = [[uniqueNames allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]];
//}


@end
