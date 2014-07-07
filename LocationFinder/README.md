
位置情報を取得したいViewControllerなりでいちいち`CLLocationManagerDelegate`を実装するのは面倒なのでもっと手軽に使いたい。

# LocationFinder
LocationFinderというwrapperクラスを作り、こいつがブロックを受け取ってdelegateを処理するようにしてみる。

```objective-c:LocationFinder.h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TULocationFinder : NSObject<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLGeocoder *geocoder;

- (void)getLocations:(void (^)(NSArray *locations))success failure:(void (^)(NSError *error))failure;
@end
```

```objective-c:LocationFinder.m

#import "TULocationFinder.h"

@interface TULocationFinder ()
@property (nonatomic, copy) void (^didUpdateLocations)(NSArray *);
@property (nonatomic, copy) void (^didFailUpdateLocationsWithError)(NSError *);
@end

@implementation TULocationFinder

- (id)init
{
    self = [super init];
    self.manager = [CLLocationManager new];
    self.manager.delegate = self;
    self.geocoder = [CLGeocoder new];
    
    return self;
}

- (void)getLocations:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    self.didUpdateLocations = success;
    self.didFailUpdateLocationsWithError = failure;
    
    if([CLLocationManager locationServicesEnabled]) {
        [self.manager startUpdatingLocation];
    } else {
		//エラーハンドリング
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.manager stopUpdatingLocation];
    if(self.didUpdateLocations) self.didUpdateLocations(locations);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(self.didFailUpdateLocationsWithError) self.didFailUpdateLocationsWithError(error);
}

@end
```


# 使い方
```objective-c

LocationFinder *finder = [ [LocationFinder alloc] init];

[finder getLocations:^(NSArray *locations) {
	//成功時
} failure:^(NSError *error) {
	//失敗時
}];

```
