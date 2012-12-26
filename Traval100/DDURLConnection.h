//
//  AppDelegate.h
//  Traval100
//
//  Created by admin on 12-12-17.
//  Copyright (c) 2012年 admin. All rights reserved.
//

/*
 Usage demo:
 
 #import "DDURLConnection.h"
 
	....
 
// BASED Usage
 
- (void)yourMethod {
	
	NSString *url = ...;

	DDURLConnection *connection = [DDURLConnection connectionWithDelegate:self];
	
	[connection connectToURL:url];
 
	// then implement DDURLConnectionDelegate Method  for your delegate , 
}
 
// When request success, delegate would invoke the two methods, you can pick one to implement in your class 

- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingJSONValue:(NSDictionary *)json {
	
	// Now Do whatever you want for the DATA here  
	// It's a JSON Dicionary (NSDictionary);

}

// When request failed 
- (void)dURLConnection:(DDURLConnection *)connection didFailWithError:(NSError *)error {
	// Handle the error

}

//////////////////////////////////////////////////////////////////////////////////
//ADVANCED Usage
- (void)yourMethod {
 
	NSString *url = ...;
 
	DDURLConnection *connection1 = [DDURLConnection connectionWithDelegate:self connectionTag:DDURLConnectionTagDefault];
	DDURLConnection *connection2 = [DDURLConnection connectionWithDelegate:self connectionTag:DDURLConnectionTagFirst];
 
	[connection1 connectToURL:url];
	[connection2 connectToURL:url];
 
	// then implement DDURLConnectionDelegate Method  for your delegate , 
}
 
// When request success, delegate would invoke the two methods, you can pick one to implement in your class 

- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingJSONValue:(NSDictionary *)json {
 
	// Now Do whatever you want for the DATA here  
	// It's a JSON Dicionary (NSDictionary);
	if (connection.connectionTag == DDURLConnectionTagDefault) {
		
	} else if(connection.connectionTag == DDURLConnectionTagFirst) 
	
	}
}

// When request failed 

- (void)dURLConnection:(DDURLConnection *)connection didFailWithError:(NSError *)error {
	// Handle the error

}
 
// sometime the response data might not be a JSON Dictionay 
// You can use this method to get STRING to d
- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingJSONValue:(NSDictionary *)json string:(NSString *)content{

	if (connection.connectionTag == DDURLConnectionTagDefault) {
		NIF_TRACE(@"%@",content);
	} else if(connection.connectionTag == DDURLConnectionTagFirst) 
		NIF_TRACE(@"%@",content);
	}
 
}

*/ 
 
//////////////////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>

@protocol DDURLConnectionDelegate;
@class DDLoadingView;

typedef enum {
	DDURLConnectionTagDefault	= 0,
	DDURLConnectionTagFirst,
	DDURLConnectionTagSecond,
	DDURLConnectionTagThird,
	DDURLConnectionTagForth,
	DDURLConnectionTagFifth
}DDURLConnectionTag;

@interface DDURLConnection : NSObject {

@private 
	
	NSMutableData               *buffer;
	NSURLConnection             *connection;

	DDURLConnectionTag          connectionTag;
	id <DDURLConnectionDelegate> _delegate;
    int forstat;
    NSDate *_cacheValidityDate;
	
	NSString                    *searchText;
    
    
    int                 tmpApiCallIndex;
    NSString            *_pageRefs;
    BOOL                hasLoadView;
    int                 totalLength;
    BOOL                showProgress;
    NSString            *contentType;
}

@property (assign)  BOOL           ignoreOldCache;
@property (assign)  float          cacheValidity;
@property (copy)    NSString       *cacheName;
@property (copy)    NSString       *cacheType;

@property (assign)  BOOL           avoidStatistics; // 避免统计开关 默认关 表示需要统计

@property (nonatomic) DDURLConnectionTag connectionTag;
@property (nonatomic, retain) NSString *searchText;
@property (nonatomic, assign)  id <DDURLConnectionDelegate> delegate;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, retain)  id context;
@property (assign)BOOL                showProgress;


+ (DDURLConnection *)connectionWithDelegate:(id<DDURLConnectionDelegate>)delegate;
+ (DDURLConnection *)connectionWithDelegate:(id<DDURLConnectionDelegate>)delegate connectionTag:(NSInteger)tag;


- (id)initWithDelegate:(id<DDURLConnectionDelegate>)delegate;	// default tag
- (id)initWithDelegate:(id<DDURLConnectionDelegate>)delegate connectionTag:(NSInteger)tag;

// 
// GET 
// 简单转义
// 
- (void)connectToURL:(NSString *)url;

//
// GET
// 汉字特殊符号转义　注意使用
// 
- (void)connectToURL:(NSString *)url params:(NSDictionary *)params;

//
// POST
//
//- (void)connectToURLWithPost:(NSString *)url params:(NSDictionary *)params;


/* NOT implement
- (void)post:(NSString*)aURL body:(NSString*)body;
- (void)post:(NSString*)aURL data:(NSData*)data;
*/

- (void)postData:(NSData *)data url:(NSString *)url;
+ (void)setApiCallIndex:(int)aIndex;

//
// POST IMAGE
// 
- (void)postImage:(UIImage *)image url:(NSString *)url;


- (void)cancel;
- (void)cancelWithDelegate;

- (void)connectionToConnection:(NSURLConnection *)conn;

// Testing 
//- (void)showLoadingViewOnKeyWindowWithText:(NSString *)text;
//- (void)showLoadingViewText:(NSString *)text onWindow:(UIView *)aView;
//- (void)refreshLoadingStatus:(NSString *)text;
//- (void)removeLoadingView;

@end


@protocol DDURLConnectionDelegate <NSObject>

@optional

// NEW
- (void)dURLConnectionDidStartLoading:(DDURLConnection *)connection;

- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingJSONValue:(NSDictionary *)json;
- (void)dURLConnection:(DDURLConnection *)connection didFailWithError:(NSError *)error;

- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingJSONValue:(NSDictionary *)json string:(NSString *)content;

- (BOOL)dURLConnectionPopViewControllerWhenFail:(DDURLConnection *)connection;

//pb
- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingProtocolBufferValue:(NSDictionary *)dic;
- (void)dURLConnection:(DDURLConnection *)connection didFinishLoadingProtocolBufferData:(NSData *)data;
- (void)dURLConnection:(DDURLConnection *)connection didReceiveDataWithPercent:(int) aPercent;
- (void)dURLConnection:(DDURLConnection *)connection didUploadDataWithPercent:(int) aPercent;

@end
