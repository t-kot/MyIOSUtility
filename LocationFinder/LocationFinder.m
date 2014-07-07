#import "LocationFinder.h"

@interface LocationFinder ()
@property (nonatomic, copy) void (^didUpdateLocations)(NSArray *);
@property (nonatomic, copy) void (^didFailUpdateLocationsWithError)(NSError *);
@end

@implementation LocationFinder

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
        self.didFailUpdateLocationsWithError(error);
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
