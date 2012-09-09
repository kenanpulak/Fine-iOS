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

@synthesize listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive, selectedProduct, realImageData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = BARTO_PINK_COLOR;
    
    self.searchBar.tintColor = BARTO_PINK_COLOR;
    self.searchBar.delegate = self;
    
    self.navigationController.navigationBar.topItem.title = @"Barto";
    
    self.view.backgroundColor = BARTO_PINK_COLOR;
    
    listContent = [[NSArray alloc] initWithObjects:
                   [Product productWithType:@"Salad" name:@"Chicken Caesar Salad" imageName:@"salad.jpeg" restaurantName:@"Cenan's Bakery" price:@"5.99" numLikes:@"22 Likes"],
                   [Product productWithType:@"Burger" name:@"Cheese Burger" imageName:@"burger" restaurantName:@"Five Guys" price:@"6.50" numLikes:@"32 Likes"],
                   [Product productWithType:@"Pizza" name:@"Pepperoni Pizza" imageName:@"pizza" restaurantName:@"Extreme Pizza" price:@"12.99" numLikes:@"18 Likes"],
                   [Product productWithType:@"Burrito" name:@"Super Burrito" imageName:@"burrito.jpeg" restaurantName:@"Iron Cactus" price:@"6.80" numLikes:@"9 Likes"],
                   [Product productWithType:@"Calzone" name:@"Cheese Calzone" imageName:@"calzone.jpeg" restaurantName:@"Paizano's" price:@"6.29" numLikes:@"25 Likes"],
                   [Product productWithType:@"Crepe" name:@"Nutella Crepe" imageName:@"crepe.jpeg" restaurantName:@"Crepe Place" price:@"4.30" numLikes:@"52 Likes"],
                   [Product productWithType:@"Taco" name:@"Doritos Loco Taco" imageName:@"taco" restaurantName:@"Taco Bell" price:@"5.20" numLikes:@"82 Likes"],
                   [Product productWithType:@"Pasta" name:@"Spaghetti w/ Vodka Sauce" imageName:@"pasta.jpeg" restaurantName:@"Olive Garden" price:@"3.40" numLikes:@"33 Likes"],
                   [Product productWithType:@"Bread" name:@"French Baguette" imageName:@"baguette.jpeg" restaurantName:@"Baker's Place" price:@"2.00" numLikes:@"71 Likes"], nil];
    
    self.realImageData = [[NSArray alloc] initWithObjects:@"burrito1.jpeg",@"Burrito2.jpeg",@"burrito3",@"burrito4.jpeg",@"burrito5.jpeg",@"burrito6.jpeg",@"burrito7.jpeg",@"burrito8.jpeg",@"burrito9.jpeg",@"burrito10",@"burrito11.jpeg",@"burrito12.jpeg",@"burrito13.jpeg",@"burrito14.jpeg",@"burrito15.jpeg", nil];
    
	
    realData = YES;
    
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
	if(realData){
        return [self.listContent count];
    }
    else{
        return [realDataArray count];
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
    
    NSString *restaurantName;
    NSString *foodName;
    NSString *numLikes;
    NSString *price;
    UIImage *image;
    
    
    Product *product = nil;
    if(realData){
        product = [self.listContent objectAtIndex:indexPath.row];
        restaurantName = product.restaurantName;
        foodName = product.name;
        price = product.price;
        numLikes = product.numLikes;
        image = [UIImage imageNamed:product.imageName];
        
    }
    else{
        restaurantName = [[realDataArray objectAtIndex:indexPath.row] objectForKey:@"place"];
        foodName = [[realDataArray objectAtIndex:indexPath.row] objectForKey:@"foodName"];
        NSNumber *likesNum = [[NSNumber alloc] initWithInt:(arc4random_uniform(400)+30)];
        price = [[realDataArray objectAtIndex:indexPath.row] objectForKey:@"foodPrice"];
        numLikes = [[likesNum stringValue]stringByAppendingString:@" Likes"];
        image = [UIImage imageNamed:[self.realImageData objectAtIndex:indexPath.row%15]];
        
    }
	
	cell.foodName.text = foodName;
    cell.restaurantName.text = restaurantName;
    cell.price.text = price;
    cell.numberLikes.text = numLikes;
    cell.imageView.image = image;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
	 If the requesting table view is the search display controller's table view, configure the next view controller using the filtered content, otherwise use the main list.
	 
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
    
    */
    
    // [[self navigationController] pushViewController:detailsViewController animated:YES];
}

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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];
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
    realDataArray = [[NSMutableArray alloc] init];
    
    for(restaurant in restaurantsInfo){
        
        NSString *place = [[restaurant objectForKey:@"venue"] objectForKey:@"name"];
        NSString *foodName = [restaurant objectForKey:@"name"];
        NSNumber *foodPrice = [restaurant objectForKey:@"price"];
        if(foodPrice == [NSNull null]){
            foodPrice = [NSNumber numberWithFloat:5.95];
        }
        
        
        NSLog(@"name:%@",foodName);
        NSLog(@"place:%@",place);
        NSLog(@"foodPrice:%@",[foodPrice stringValue]);
        
        NSMutableDictionary *realFoodItem = [[NSMutableDictionary alloc] init];
        
        [realFoodItem setObject:foodName forKey:@"foodName"];
        [realFoodItem setObject:place forKey:@"place"];
        [realFoodItem setObject:[foodPrice stringValue] forKey:@"foodPrice"];
        
        [realDataArray addObject:realFoodItem];
    }
    
    realData = NO;
    [self.tableView reloadData];
    
    
}


@end
