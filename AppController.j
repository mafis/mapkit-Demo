/*
 * AppController.j
 * null
 *
 * Created by You on August 18, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <MapKit/MapKit.j>

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

	var mapView = [[MKMapView alloc] initWithFrame:[contentView frame]];
	[mapView setDelegate:self];
    [contentView addSubview:mapView];

    [theWindow orderFront:self];

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

-(void)loadedMap:(MKMapView)mapView
{
	CPLog.debug("Loaded Map");
	var annotations = [CPArray array];
	
	for (var i=0; i < 500; i++) {
		var annotation = [[MKAnnotation alloc] init];
		[annotation setCoordinate:CLLocationCoordinate2DMake(GetRandom(-80,80),GetRandom(-80,80))];
	 
	 	[annotations addObject:annotation];
	};
	
	 [mapView addAnnotations:annotations];
	
}

-(MKAnnotationView)mapView:(MKMapView)aMapView viewForAnnotation:(MKAnnotation)aAnnotation
{
	var annotationView = [aMapView dequeueReusableAnnotationViewWithIdentifier:@"Test"];
	
	if(!annotationView)
	{
		 annotationView = [[MKAnnotationView alloc] initWithFrame:CGRectMake(0,0,100,100)];
		[annotationView setBackgroundColor:[CPColor colorWithCalibratedRed:GetRandom(0,255) green:GetRandom(0,255) blue:GetRandom(0,255) alpha:1.0]];
		
		[annotationView setImage: [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"map-marker.gif"]]];
	}
	
	return annotationView;
}

- (void)mapView:(MKMapView)mapView didSelectAnnotationView:(MKAnnotationView)view
{
	[view removeFromSuperview]
	//var annotation = [view annotation];
	//[mapView removeAnnotation:annotation];
}


@end

function GetRandom( min, max ) {
	if( min > max ) {
		return( -1 );
	}
	if( min == max ) {
		return( min );
	}
 
        return( min + parseInt( Math.random() * ( max-min+1 ) ) );
}