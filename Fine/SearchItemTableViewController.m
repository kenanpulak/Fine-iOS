//
//  SearchItemTableViewController.m
//  Fine
//
//  Created by Kenan Pulak on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import "SearchItemTableViewController.h"
#import "Product.h"

@implementation SearchItemTableViewController
@synthesize searchBar;

@synthesize listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:242.0f/255.0f green:109.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
    
    self.searchBar.tintColor = [UIColor colorWithRed:242.0f/255.0f green:109.0f/255.0f blue:162.0f/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.topItem.title = @"Barto";
        
    listContent = [[NSArray alloc] initWithObjects:
                   [Product productWithType:@"Salad" name:@"Chicken Caesar Salad"],
                   [Product productWithType:@"Burger" name:@"Cheese Burger"],
                   [Product productWithType:@"Pizza" name:@"Pepperoni Pizza"],
                   [Product productWithType:@"Burrito" name:@"Super Burrito"],
                   [Product productWithType:@"Calzone" name:@"Cheese Calzone"],
                   [Product productWithType:@"Crepe" name:@"Nutella Crepe"],
                   [Product productWithType:@"Taco" name:@"Doritos Loco Taco"],
                   [Product productWithType:@"Pasta" name:@"Spaghetti w/ Vodka Sauce"],
                   [Product productWithType:@"Bread" name:@"French Baguette"], nil];

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
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
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
	
	cell.textLabel.text = product.name;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *detailsViewController = [[UIViewController alloc] init];
    
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
	detailsViewController.title = product.name;
    
    [[self navigationController] pushViewController:detailsViewController animated:YES];
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
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


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
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


@end
