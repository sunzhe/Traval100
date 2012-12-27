
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef enum {
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN
} NetworkStatus;
#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"

@interface Reachability: NSObject
{
	BOOL localWiFiRef;//是否是WIFI标志
	SCNetworkReachabilityRef reachabilityRef;//检测地址可达性的指针
}
+(NSString *)stringFromAddress:(const struct sockaddr *)address;//将地址转换NSString类型
+(BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address;//判断将一个NSString类型转换为地址是否可以
+(NSString *)hostname;//获取本机名称
+(NSString *)getIPAddressForHost:(NSString *)theHost;//获取指定host的IP地址
+(NSString *)localIPAddress;//获取本机的IP地址
+(NSString *)localWiFiIPAddress;//获取wifi的ip地址
+(NSString *)whatismyipdotcom;//查询 http://www.whatismyip.com/automation/n09230945.asp 的IP地址
+(BOOL)hostAvailable:(NSString *)theHost;
//reachabilityWithHostName- Use to check the reachability of a particular host name. 
+ (Reachability*) reachabilityWithHostName: (NSString*) hostName;

//reachabilityWithAddress- Use to check the reachability of a particular IP address. 
+ (Reachability*) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress;

//reachabilityForInternetConnection- checks whether the default route is available.  
//  Should be used by applications that do not connect to a particular host
+ (Reachability*) reachabilityForInternetConnection;

//reachabilityForLocalWiFi- checks whether a local wifi connection is available.
+ (Reachability*) reachabilityForLocalWiFi;

//Start listening for reachability notifications on the current run loop
- (BOOL) startNotifier;
- (void) stopNotifier;

- (NetworkStatus) currentReachabilityStatus;
//WWAN may be available, but not active until a connection has been established.
//WiFi may require a connection for VPN on Demand.
- (BOOL) connectionRequired;
@end


