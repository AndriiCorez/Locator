//
//  ViewController.m
//  ShowLocation
//
//  Created by Andres on 1/29/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//


#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet MKPointAnnotation *itemBar1;
@property (strong, nonatomic) IBOutlet MKPointAnnotation *itemBar2;
@property (strong, nonatomic) IBOutlet MKPointAnnotation *itemBar3;
@property (strong, nonatomic) MKPointAnnotation *deviceAnnotation;

@property (weak, nonatomic) IBOutlet UISwitch *switchLocate;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self addPointAnnotations];
}

- (void)addPointAnnotations{
    self.itemBar1 = [[MKPointAnnotation alloc] init];
    self.itemBar1.coordinate = CLLocationCoordinate2DMake(51.7653274, 19.4552197);
    self.itemBar1.title = @"Home";
    
    self.itemBar2 = [[MKPointAnnotation alloc] init];
    self.itemBar2.coordinate = CLLocationCoordinate2DMake(51.7790346, 19.4670443);
    self.itemBar2.title = @"Work";
    
    self.itemBar3 = [[MKPointAnnotation alloc] init];
    self.itemBar3.coordinate = CLLocationCoordinate2DMake(51.7807063, 19.445031);
    self.itemBar3.title = @"Shop";
    
    self.deviceAnnotation = [[MKPointAnnotation alloc] init];
    self.deviceAnnotation.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.deviceAnnotation.title = @"Me";
    
    [self.mapView addAnnotations:@[self.itemBar1, self.itemBar2, self.itemBar3, self.deviceAnnotation]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = locations.lastObject;
    NSLog(@"MY LOCATION %@", locations);
    self.deviceAnnotation.coordinate = location.coordinate;
    [self centerMap:self.deviceAnnotation];
}


- (void)centerMap:(MKPointAnnotation*)point{
    [self.mapView setCenterCoordinate:point.coordinate animated:YES];
}

- (IBAction)item1Tapped:(id)sender {
    [self centerMap:self.itemBar1];
}

- (IBAction)item2Tapped:(id)sender {
    [self centerMap:self.itemBar2];
}

- (IBAction)item3Tapped:(id)sender {
    [self centerMap:self.itemBar3];
}

- (IBAction)switchChanged:(id)sender {
    if (self.switchLocate.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    }
    else{
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

@end
