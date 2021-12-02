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
    
    let CoreDataActivity = FEFUCoreDataContainer.instance
    
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
    func getUserLocationHistory() -> [CLLocation] {
        return userLocationHistory
    }
    let userLocationIdentifier = "user_location_icon"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    @IBAction func SaveActivityData(_ sender: Any) {
        var long_of_activnosti = Double();
        for i in 0...userLocationHistory.count-2{
            long_of_activnosti += userLocationHistory[i].distance(from: userLocationHistory[i+1])
        }
        print(long_of_activnosti)
        let core_data = CDUserActivitys(context: CoreDataActivity.context)
        core_data.long_of_activity = long_of_activnosti / 1000;
        core_data.start_date = userLocationHistory[0].timestamp
        core_data.end_date = userLocationHistory.last?.timestamp
        CoreDataActivity.saveContext()
    }
}
extension LocationTrackingView: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKUserLocation {
            
            let dequeView = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationIdentifier)
            
            let view = dequeView ?? MKAnnotationView(
                annotation: annotation, reuseIdentifier: userLocationIdentifier
            )
            view.image = UIImage(named: "user_location_icon")
            return view
        }
        return nil
    }
}
