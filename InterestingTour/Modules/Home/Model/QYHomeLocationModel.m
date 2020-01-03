//
//  QYHomeLocationModel.m
//  InterestingTour
//
//  Created by 厉威 on 2019/12/21.
//  Copyright © 2019 厉威. All rights reserved.
//

#import "QYHomeLocationModel.h"
#import <CoreLocation/CoreLocation.h>

@interface QYHomeLocationModel ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) NSString *city;
@end

@implementation QYHomeLocationModel
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }else{
        DLog(@"当前无法定位");
    }
}

#pragma mark ------- delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    //根据经纬度反向编译位置信息
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    [gecoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *placemark in placemarks) {
            NSDictionary *address = [placemark addressDictionary];
            NSString *city = address[@"City"];
            if (self.locationSuccess) {
                self.locationSuccess(city, currentLocation);
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.locationFailed) {
        self.locationFailed(error);
    }
}
@end
