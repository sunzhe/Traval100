//
//  DDURLConnection.m
//  DDCoupon
//
//  Created by ryan on 11-6-8.
//  Copyright 2011 DDmap. All rights reserved.
//

#import "DDURLConnection.h"
#import "Reachability.h"

static NSInteger SortParameter(NSString *key1, NSString *key2, void *context) {
	NSComparisonResult r = [key1 compare:key2];
	if(r == NSOrderedSame) { // compare by value in this case
		NSDictionary *dict = (NSDictionary *)context;
		NSString *value1 = [dict objectForKey:key1];
		NSString *value2 = [dict objectForKey:key2];
		return [value1 compare:value2];
	}
	return r;
}

static NSString *boundary = @"--------------------------------------fdsfdsffvvf3v";

@interface DDURLConnection () 

@property (nonatomic, retain)  NSMutableData		*buffer;
@property (nonatomic, assign)  NSURLConnection		*connection;
@property (nonatomic, retain) NSDate *cacheValidityDate;

@end 

@interface DDURLConnection (Amination)


- (void)didStopSelector;
- (void)removeLoadingView;
- (BOOL)isSessionValid;

- (NSData *)cacheWhenValid;
- (void)cacheJsonIfNeeded:(NSData *)jsonData;
- (void)saveFailedUrls;

@end

static NSUInteger APICallIndex = 0;

@implementation DDURLConnection

@synthesize connectionTag;
@synthesize searchText;
@synthesize buffer;
@synthesize connection;
@synthesize delegate = _delegate;
@synthesize cacheValidity = _cacheValidity;
@synthesize cacheName = _cacheName;
@synthesize cacheType = _cacheType;
@synthesize ignoreOldCache = _ignoreOldCache;
@synthesize url = _url;
@synthesize cacheValidityDate = _cacheValidityDate;
@synthesize context = _context;
@synthesize avoidStatistics = _avoidStatistics;
@synthesize showProgress;


- (int)apiCallIndex
{
    @synchronized(self)
    {
        APICallIndex++;
        return APICallIndex - 1; 
      //  NSLog(@"******************%d*************",APICallIndex - 1);
    } 
}

+ (void)setApiCallIndex:(int)aIndex
{
   // NSLog(@"******************%d*************",APICallIndex - 1);
    APICallIndex = aIndex;
}

//
+ (DDURLConnection *)connectionWithDelegate:(id<DDURLConnectionDelegate>)delegate {
	DDURLConnection *aConnection = [[DDURLConnection alloc] initWithDelegate:delegate connectionTag:DDURLConnectionTagDefault];
	return [aConnection autorelease];
}

+ (DDURLConnection *)connectionWithDelegate:(id<DDURLConnectionDelegate>)delegate connectionTag:(NSInteger)tag {
	DDURLConnection *aConnection = [[DDURLConnection alloc] initWithDelegate:delegate connectionTag:tag];
	return [aConnection autorelease];
}

- (id)initWithDelegate:(id <DDURLConnectionDelegate>)delegate {
	return [self initWithDelegate:delegate connectionTag:DDURLConnectionTagDefault];
}

// DI 
- (id)initWithDelegate:(id<DDURLConnectionDelegate>)delegate connectionTag:(NSInteger)tag {
	if (self = [super init]) {
        hasLoadView = NO;
        showProgress = NO;
		self.delegate = delegate;
		connectionTag = tag;
		NSAssert(_delegate,@"no delegate to get the responsed data");
            
        _cacheValidity = -1;
        _ignoreOldCache = NO;
        forstat = 0;
        
        //　避免统计
        _avoidStatistics = NO;
	}
	return self;
}

- (void)connectToURL:(NSString *)url {
	NSString *tempURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self connectToURL:tempURL params:nil];
}
- (void)connectToURL:(NSString *)anUrl params:(NSDictionary *)params {
    @try {
        [self cancel];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.f];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        self.connection = conn;
        [conn release];
        [self.connection start];
        if ([_delegate respondsToSelector:@selector(dURLConnectionDidStartLoading:)]) {
            [_delegate dURLConnectionDidStartLoading:self];
        }
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"服务器错误，请稍后重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    @finally {
        
    }

}

- (void)postData:(NSData *)data url:(NSString *)url {
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] == NotReachable) {
		
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络无连接" forKey:NSLocalizedDescriptionKey];
		NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1001 userInfo:userInfo];
		
		if ([_delegate respondsToSelector:@selector(dURLConnection:didFailWithError:)]) {
			[self removeLoadingView];
			[_delegate dURLConnection:self didFailWithError:error];
		}
		return;
	}
    
    NSString *tempURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSURL *URL = [NSURL URLWithString:tempURL];
	
	NSAssert(url,@"url shouldn't be nil!");
	NSAssert(URL,@"can't convert to NSURL");
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.f];
    // Body 
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.connection = conn;
	[conn release];
	[self.connection start];
	
	if ([_delegate respondsToSelector:@selector(dURLConnectionDidStartLoading:)]) {
		[_delegate dURLConnectionDidStartLoading:self];
	}
}



- (void)postImage:(UIImage *)image url:(NSString *)url {

	if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] == NotReachable) {
		
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"网络无连接" forKey:NSLocalizedDescriptionKey];
		NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1001 userInfo:userInfo];
		
		if ([_delegate respondsToSelector:@selector(dURLConnection:didFailWithError:)]) {
			[self removeLoadingView];
			[_delegate dURLConnection:self didFailWithError:error];
		}
		return;
	}
	
	
	NSString *tempURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSURL *URL = [NSURL URLWithString:tempURL];
	
	NSAssert(url,@"url shouldn't be nil!");
	NSAssert(URL,@"can't convert to NSURL");

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:40.f];
    
    //NSMutableDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forKey:@"Content-Type"];
    NSMutableDictionary *dic = [[NSMutableDictionary dictionary] retain];
    [dic setDictionary:[request allHTTPHeaderFields]];
    [dic setObject:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forKey:@"Content-Type"];
    [request setAllHTTPHeaderFields:dic];
     // Body 
	
	NSData *imageData = nil;
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] == ReachableViaWiFi) {
		imageData = UIImageJPEGRepresentation(image, 0.3);
	} else {
		imageData = UIImageJPEGRepresentation(image, 0.1);
	}
    //NSData *imageData = UIImageJPEGRepresentation(image, 1);
	
	NSString *name = [[NSDate date] description];
	
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n",name,name] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[NSData dataWithData:imageData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:body];
	
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.connection = conn;
	[conn release];
	[self.connection start];
	
	if ([_delegate respondsToSelector:@selector(dURLConnectionDidStartLoading:)]) {
		[_delegate dURLConnectionDidStartLoading:self];
	}
}
/////////////////////////////////////////////////////////////
// Ignore it if you don't know
- (void)connectionToConnection:(NSURLConnection *)conn {
	self.connection = conn;
	[self.connection start];
	
}
/////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
	self.buffer = nil;
    if ([_delegate respondsToSelector:@selector(dURLConnection:didFailWithError:)]) {
        [_delegate dURLConnection:self didFailWithError:error];
    }
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response {
	self.buffer = [NSMutableData data];
    NSDictionary *headers;
    if ([response isKindOfClass:[NSHTTPURLResponse self]]) {
        headers = [(NSHTTPURLResponse *)response allHeaderFields]; 
        NSString  *type = [[NSString stringWithFormat:@"%@", [headers objectForKey:@"Type"]] retain];
        if ([type rangeOfString: @"protobuf"].location != NSNotFound) {
            [contentType release];
            contentType = [[NSString stringWithFormat:@"protobuf"] retain];
        }
        else if ([type rangeOfString: @"json"].location != NSNotFound) {
            [contentType release];
            contentType = [[NSString stringWithFormat:@"json"] retain];
        }
        else {
            NSString  *type = [[NSString stringWithFormat:@"%@", [headers objectForKey:@"Content-Type"]] retain];
            if ([type rangeOfString: @"application/vnd.apple.pkpass"].location != NSNotFound) {
                [contentType release];
                contentType = [[NSString stringWithFormat:@"pkpass"] retain];
            }
        }
    }
   
    NSUInteger length = [[headers objectForKey:@"Content-Length"] intValue];
    totalLength = length;
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data {
	[self.buffer appendData:data];
    NSInteger newPercent = 0;
    if (totalLength>0) {
        newPercent = [self.buffer length]/(float)totalLength *100;
        if (newPercent>100) newPercent = 100;
    }
    if ([_delegate respondsToSelector: @selector(dURLConnection:didReceiveDataWithPercent:)]) {
        [_delegate dURLConnection: self didReceiveDataWithPercent: newPercent];
    }
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten
                totalBytesWritten:(NSInteger)totalBytesWritten
                totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    
    NSInteger newPercent = totalBytesWritten/(float)totalBytesExpectedToWrite *100;
    if ([_delegate respondsToSelector: @selector(dURLConnection:didUploadDataWithPercent:)]) {
        [_delegate dURLConnection: self didUploadDataWithPercent: newPercent];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    @try {
        NSError*error=nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.buffer options:NSJSONReadingAllowFragments error:&error];
        if (dic) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(dURLConnection:didFinishLoadingProtocolBufferValue:)]) {
                [self.delegate dURLConnection:self didFinishLoadingProtocolBufferValue: dic];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(dURLConnection:didFinishLoadingProtocolBufferData:)]) {
                [self.delegate dURLConnection:self didFinishLoadingProtocolBufferData: self.buffer];
            }
        }
        else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(dURLConnection:didFinishLoadingProtocolBufferData:)]) {
                [self.delegate dURLConnection:self didFinishLoadingProtocolBufferData: self.buffer];
            }
        }
    }
    @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"服务器错误，请稍后重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    self.connection = nil;
    [pool drain];
}

- (void)cancel {
    @synchronized(self) {
        [self.connection cancel];
        self.connection = nil;
        self.buffer = nil;
    }
}

- (void)cancelWithDelegate {
    [self cancel];
    self.delegate = nil;  
}


- (void)dealloc {
	[searchText release];
	self.delegate = nil;
	self.buffer = nil;
	self.connection = nil;
    self.cacheName = nil;
    self.cacheType = nil;
    [_url release]; _url = nil;
    [_cacheValidityDate release]; _cacheValidityDate = nil;
    [_pageRefs release];
    self.context = nil;
    [contentType release];
    
	[super dealloc];
}

@end
