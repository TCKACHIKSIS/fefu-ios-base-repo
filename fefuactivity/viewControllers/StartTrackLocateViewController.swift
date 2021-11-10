//
//  StartTrackLocateViewController.swift
//  fefuactivity
//
//  Created by иван on 10.11.2021.
//

import UIKit
import CoreLocation
import MapKit
class LocationTrackingView: UIViewController{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    var userLocation: CLLocation? {
        didSet {
            guard let userLocation = userLocation else {
                return
            }
            let region = MKCoordinateRegion(
                        center:userLocation.coordinate,
                        latitudinalMeters: 500,
                        longitudinalMeters: 500
                )
            mapView.setRegion(region, animated: true)
            userLocationHistory.append(userLocation)
        }
    }
    
    fileprivate var userLocationHistory: [CLLocation] = []{
        didSet {
            let coordinates = userLocationHistory.map { $0.coordinate }
            
            let route = MKPolyline(coordinates: coordinates,                                         count: coordinates.count)
            route.title = "Ваш маршрут"
            mapView.addOverlay(route)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
}
extension LocationTrackingView: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        guard let currentLocation = locations.first else {
            return
        }
        userLocation = currentLocation
    }
}

extension LocationTrackingView: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)->MKOverlayRenderer{
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            render.fillColor = UIColor.blue
            render.strokeColor = UIColor.blue
            render.lineWidth = 5
            return render
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
