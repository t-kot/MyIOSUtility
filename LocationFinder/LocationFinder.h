
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationFinder : NSObject<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLGeocoder *geocoder;

- (void)getLocations:(void (^)(NSArray *locations))success failure:(void (^)(NSError *error))failure;
@end
