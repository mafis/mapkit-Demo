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
	var points = 100;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
	var sharedApplication = [CPApplication sharedApplication];
		var namedArguments = [sharedApplication namedArguments];

		var enumerator = [namedArguments keyEnumerator];
		var key;
		while ((key = [enumerator nextObject]) != nil)
		{
			if(key == "points")
			{
				points = [namedArguments objectForKey:key];
				
			}
			console.log(key + " = " + points);
		}
	
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
	
	for (var i=0; i < points; i++) {
		var annotation = [[MKAnnotation alloc] init];
		[annotation setCoordinate:CLLocationCoordinate2DMake(GetRandom(-85,85),GetRandom(-175,175))];
	 	[annotation setTitle:@"Test " + i];
	 	[annotations addObject:annotation];
	};
	
	 [mapView addAnnotations:annotations];
	
}

-(MKAnnotationView)mapView:(MKMapView)aMapView viewForAnnotation:(MKAnnotation)aAnnotation
{
	var annotationView = [aMapView dequeueReusableAnnotationViewWithIdentifier:@"Test"];
	
	if(!annotationView)
	{
		annotationView = [[MKAnnotationView alloc] initWithAnnotation:aAnnotation reuseIdentifer:@"Test"];
		
		[annotationView setImage: [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:"Location_marker.png"]]];
	}
	
	return annotationView;
}

- (void)mapView:(MKMapView)mapView didSelectAnnotationView:(MKAnnotationView)view
{
	CPLog.debug("DidSelectAnnotaitonView");
	//[view removeFromSuperview]
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