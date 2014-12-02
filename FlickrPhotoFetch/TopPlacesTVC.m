//
//  TopPlacesTVC.m
//  FlickrPhotoFetch
//
//  Created by LuQuan Intrepid on 12/1/14.
//  Copyright (c) 2014 LuQuanTan. All rights reserved.
//

#import "TopPlacesTVC.h"
#import "LQFlickrPlace.h"

#import "TopPlacesModel.h"
#import "FlickrWebService.h"

@interface TopPlacesTVC ()
@property (nonatomic, strong) NSArray *topPlaces;
@property (nonatomic, strong) NSSet *uniqueCountries;
@property (nonatomic) NSInteger numberOfUniqueCountries;
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
        self.topPlaces = results; NSLog(@"Top Places updated");
        [self.refreshControl endRefreshing]; NSLog(@"end refresh");
        
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)setTopPlaces:(NSArray *)topPlaces
{
    _topPlaces = topPlaces;
    [self countriesInTopPlaces];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numberOfUniqueCountries;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopPlacesTableViewCell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Helper Methods
- (void)countriesInTopPlaces
{
    NSArray *countries = [self.topPlaces valueForKey:LQFlickrPlaceCountryPropertyKey];
    self.uniqueCountries = [NSSet setWithArray:countries];
    self.numberOfUniqueCountries = [self.uniqueCountries count];
}



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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
