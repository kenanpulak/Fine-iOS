//
//  ServerRequest.m
//
//  Created by Chillcamp LLC
//  Copyright Chillcamp LLC 
//

#import "ServerRequest.h"
#import "AppDelegate.h"

@implementation ServerRequest

@synthesize urlConnection;
@synthesize receivedData;
@synthesize receivedString;
@synthesize json;
@synthesize username;
@synthesize password;
@synthesize urlName;
@synthesize requestType;
@synthesize parameters;
@synthesize identifier;
@synthesize delegate = _delegate;


#pragma mark - View lifecycle

- (id)initWithDelegate:(id<ServerRequestDelegate>)delegate {
    self = [super init];
    debugMode = true;
    
    if(self){
        self.delegate = delegate;
    }
    return self;
}

-(void) setValues: (NSString *)usernameString:(NSString *)passwordString:(NSString *)urlnameString:(NSString *)requestypeString:(NSString *)parametersString{
    
    username = usernameString;
    password = passwordString;
    urlName = urlnameString;
    requestType = requestypeString;
    parameters = parametersString;
    
}

-(void)sendRequest{
    NSURL *url = [NSURL URLWithString:urlName];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:requestType];
    
    NSString *postString = parameters;
    
    [urlRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(NSDictionary *)sendSynchronousRequest{
    NSURL *url = [NSURL URLWithString:urlName];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:requestType];
    
    NSString *postString = parameters;
    
    [urlRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse* response;
    NSError* error = nil;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSData* result = [NSURLConnection sendSynchronousRequest:urlRequest  returningResponse:&response error:&error];
        
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSDictionary* tempJson;
    
    tempJson = [NSJSONSerialization 
                JSONObjectWithData:result
                options:kNilOptions 
                error:&error];
    
    return tempJson;
}



- (void)connection:(NSURLConnection *)connection 
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSString* usernameCredential;
    NSString* passwordCredential;
    
    if ([challenge previousFailureCount] > 1)
    {
        
    }
    else 
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        usernameCredential = username;
        passwordCredential = password;
        
        // Answer the challenge
        NSURLCredential *cred = [[NSURLCredential alloc] initWithUser:usernameCredential password:passwordCredential persistence:NSURLCredentialPersistenceNone];
        
        [[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
    }
}


#pragma mark NSURLConnection delegate methods
- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse {
    return request;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    receivedData = [[NSMutableData alloc] initWithBytes:0 length:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
 	[receivedData appendData:data];
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSMutableDictionary *errorJson = [[NSMutableDictionary alloc] init];
    
    json = errorJson;
    NSLog(@"ERROR with %@ request %@, %@ server response:", self.identifier, self,json);
    [self.delegate requestDidFinishLoading];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    json = [NSJSONSerialization 
            JSONObjectWithData:receivedData //1
            
            options:kNilOptions 
            error:&error];
    
    NSLog(@"Server Output %@", json);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [self.delegate requestDidFinishLoading];
}

@end
