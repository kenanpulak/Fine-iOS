//
//  SearchItemTableViewController.m
//  Fine
//
//  Created by Kenan Pulak on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import "SearchItemTableViewController.h"
#import "Product.h"
#import "SearchItemCell.h"
#import "detailViewController.h"

@implementation SearchItemTableViewController
@synthesize searchBar;

@synthesize listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive, selectedProduct;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = BARTO_PINK_COLOR;
    
    self.searchBar.tintColor = BARTO_PINK_COLOR;
    
    self.navigationController.navigationBar.topItem.title = @"Barto";
    
    self.view.backgroundColor = BARTO_PINK_COLOR;
    
    listContent = [[NSArray alloc] initWithObjects:
                   [Product productWithType:@"Salad" name:@"Chicken Caesar Salad" imageName:@"test" restaurantName:@"Cenan's Bakery" price:@"5.99" numLikes:@"22 Likes"],
                   [Product productWithType:@"Burger" name:@"Cheese Burger" imageName:@"test" restaurantName:@"Five Guys" price:@"6.50" numLikes:@"32 Likes"],
                   [Product productWithType:@"Pizza" name:@"Pepperoni Pizza" imageName:@"test" restaurantName:@"Extreme Pizza" price:@"12.99" numLikes:@"18 Likes"],
                   [Product productWithType:@"Burrito" name:@"Super Burrito" imageName:@"test" restaurantName:@"Iron Cactus" price:@"6.80" numLikes:@"9 Likes"],
                   [Product productWithType:@"Calzone" name:@"Cheese Calzone" imageName:@"test" restaurantName:@"Paizano's" price:@"6.29" numLikes:@"25 Likes"],
                   [Product productWithType:@"Crepe" name:@"Nutella Crepe" imageName:@"test" restaurantName:@"Crepe Place" price:@"4.30" numLikes:@"52 Likes"],
                   [Product productWithType:@"Taco" name:@"Doritos Loco Taco" imageName:@"test" restaurantName:@"Taco Bell" price:@"5.20" numLikes:@"82 Likes"],
                   [Product productWithType:@"Pasta" name:@"Spaghetti w/ Vodka Sauce" imageName:@"test" restaurantName:@"Olive Garden" price:@"3.40" numLikes:@"33 Likes"],
                   [Product productWithType:@"Bread" name:@"French Baguette" imageName:@"test" restaurantName:@"Baker's Place" price:@"2.00" numLikes:@"71 Likes"], nil];
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
	
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	
	[self.tableView reloadData];
	self.tableView.scrollEnabled = YES;
    
    self.searchBar.delegate = self;
    
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
    self.filteredListContent = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.listContent count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//static NSString *kCellID = @"searchItemCell";
	
	SearchItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchItemCell"];
    
	if (cell == nil)
	{
		cell = [[SearchItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchItemCell"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
	
	/*
	 If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
	 */
	Product *product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        product = [self.listContent objectAtIndex:indexPath.row];
    }
    
	
	cell.foodName.text = product.name;
    cell.restaurantName.text = product.restaurantName;
    cell.price.text = product.price;
    cell.numberLikes.text = product.numLikes;
    cell.imageView.image = [UIImage imageNamed:product.imageName];
    cell.contentView.backgroundColor = BARTO_CELL_COLOR;
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 */
	Product *product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        product = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        product = [self.listContent objectAtIndex:indexPath.row];
    }
    
    self.selectedProduct = product;
    
    
    
    // [[self navigationController] pushViewController:detailsViewController animated:YES];
}


#pragma mark -
#pragma mark Content Filtering
/*
 - (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
 {
 
 
 [self.filteredListContent removeAllObjects]; // First clear the filtered array.
 
 for (Product *product in listContent)
 {
 if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope])
 {
 NSComparisonResult result = [product.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
 if (result == NSOrderedSame)
 {
 [self.filteredListContent addObject:product];
 }
 }
 }
 }
 
 #pragma mark UISearchDisplayController Delegate Methods
 
 - (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
 {
 
 if ([searchString isEqualToString:@"\n"] ) {
 
 NSLog(@"searchString %@",searchString);
 
 }
 NSLog(@"searchString %@",searchString);
 
 
 [self filterContentForSearchText:searchString scope:
 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
 
 // Return YES to cause the search result table view to be reloaded.
 
 return YES;
 }
 
 
 - (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
 {
 
 [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
 
 // Return YES to cause the search result table view to be reloaded.
 return YES;
 }
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    /*
     When a row is selected, the segue creates the detail view controller as the destination.
     Set the detail view controller's detail item to the item associated with the selected row.
     */
    if ([[segue identifier] isEqualToString:@"toFoodDetail"]) {
        
        detailViewController *detailsViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"];
        
        
        // NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        detailsViewController = [segue destinationViewController];
        
        detailsViewController.title = self.selectedProduct.name;
        detailsViewController.restaurantName.text = self.selectedProduct.restaurantName;
        detailsViewController.imageView.image = [UIImage imageNamed:self.selectedProduct.imageName];
        detailsViewController.price.text = self.selectedProduct.price;
        detailsViewController.numLikes.text = self.selectedProduct.numLikes;
        
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    NSString *searchString = self.searchBar.text;
    
    searchFood = [[ServerRequest alloc] initWithDelegate:self];
    searchFood.identifier = @"searchForFood";
    searchFood.urlName = [[@"http://api.locu.com/v1_0/menu_item/search/?api_key=2e33fbeb9ba685f9a60913076b95ee924608cdd8&location=37.771666,-122.403488"                        stringByAppendingString:@"&name="]
                          stringByAppendingString:searchString];
    searchFood.requestType = @"GET";
    searchFood.username = @"";
    searchFood.parameters = @"";
    searchFood.password = @"";
    
    [searchFood sendRequest];
}

-(void)requestDidFinishLoading{
    
    NSArray *restaurantsInfo = [searchFood.json objectForKey:@"objects"];
    NSDictionary *restaurant;
    
    for(restaurant in restaurantsInfo){
        
        NSString *place = [[restaurant objectForKey:@"venue"] objectForKey:@"name"];
        NSString *foodName = [restaurant objectForKey:@"name"];
        
        NSLog(@"name:%@",foodName);
        NSLog(@"place:%@",place);
    }
}


@end
