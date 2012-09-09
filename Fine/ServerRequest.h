//
//  ServerRequest.h
//
//  Created by Chillcamp LLC
//  Copyright Chillcamp LLC 
//

#import <Foundation/Foundation.h>

@protocol ServerRequestDelegate;

@interface ServerRequest : NSObject{
    
    NSMutableData *receivedData;
    NSString      *receivedString;
    NSDictionary  *json;
    NSString *username;
    NSString *password;
    NSString *urlName;
    NSString *requestType;
    NSString *parameters;
    NSString *identifier; 
    bool debugMode;
    
    id<ServerRequestDelegate> _serverRequestDelegate;
    
}

@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *receivedString;
@property (nonatomic, retain) NSDictionary *json;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *urlName;
@property (nonatomic, retain) NSString *requestType;
@property (nonatomic, retain) NSString *parameters;
@property (nonatomic, retain) NSString *identifier;

@property(nonatomic, retain) NSURLConnection* urlConnection;

@property(strong, nonatomic) id<ServerRequestDelegate> delegate;


-(void)sendRequest;
-(NSDictionary *)sendSynchronousRequest;

- (id)initWithDelegate:(id<ServerRequestDelegate>)delegate;


@end

@protocol ServerRequestDelegate <NSObject>

- (void)requestDidFinishLoading; 



@end
