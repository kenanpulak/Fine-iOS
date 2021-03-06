//
//  SearchItemTableViewController.h
//  Fine
//
//  Created by Kenan Pulak on 9/8/12.
//  Copyright (c) 2012 Kenan Pulak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerRequest.h"
#import "Product.h"

@interface SearchItemTableViewController : UITableViewController <UISearchBarDelegate,ServerRequestDelegate>{
    
    NSArray			*listContent;			// The main content of app
	
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    
    ServerRequest *searchFood;
    
    bool realData;
    
    NSMutableArray *realDataArray;
    
    
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, strong) NSArray *realImageData;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic,strong) Product *selectedProduct;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end