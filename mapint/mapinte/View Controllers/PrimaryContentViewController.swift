//
//  ViewController.swift
//  Pulley
//
//  Created by Brendan Lee on 7/6/16.
//  Copyright © 2016 52inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON
import Cluster
import Localize_Swift
import Pulley

class PrimaryContentViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var mapView: MKMapView!
  
    @IBAction func showCurrentLocatoin(_ sender: Any) {
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    /**
     * IMPORTANT! If you have constraints that you use to 'follow' the drawer (like the temperature label in the demo)...
     * Make sure you constraint them to the bottom of the superview and NOT the superview's bottom margin. Double click the constraint, and you can change it in the dropdown in the right-side panel. If you don't, you'll have varying spacings to the drawer depending on the device.
     */
    @IBOutlet var temperatureLabelBottomConstraint: NSLayoutConstraint!
    
    fileprivate let temperatureLabelBottomDistance: CGFloat = 8.0
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    let manager = CLLocationManager()
    var currentLocation: CLLocation!
    var venues = [Venue]()
    let clusterManager = ClusterManager()
    var drawer = DrawerContentViewController()
    func fetchData()
    {
        let fileName = Bundle.main.path(forResource: "Venues", ofType: "json")
        let filePath = URL(fileURLWithPath: fileName!)
        var data: Data?
        do {
            data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
        } catch let error {
            data = nil
            print("Report error \(error.localizedDescription)")
        }
        
        if let jsonData = data {
            let json = JSON(data: jsonData)
            if let venueJSONs = json["response"]["venues"].array {
                for venueJSON in venueJSONs {
                    if let venue = Venue.from(json: venueJSON) {
                        self.venues.append(venue)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let preferredLanguage = NSLocale.preferredLanguages[0]
        Localize.setCurrentLanguage(preferredLanguage)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        
        clusterManager.zoomLevel = 17
        clusterManager.minimumCountForCluster = 3
        clusterManager.shouldRemoveInvisibleAnnotations = false
        
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        
        drawer.test = "hell"
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            //Magnifying glass
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            var color = UIColor(red: 128/255, green: 130/255, blue: 132/255, alpha: 1)
            glassIconView.tintColor = color
        }
        var annotations: [Annotation] = (0..<1000).map { i in
            let annotation = Annotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: drand48() * 80 - 40, longitude: drand48() * 80 - 40)
            let color = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
            annotation.type = .color(color, radius: 25)
            // or
            // annotation.type = .image(UIImage(named: "pin")?.filled(with: color)) // custom image
            return annotation
        }
        
        let font = UIFont(name: "GTHaptikMedium", size: 12)
        segmentedControl.setTitle("Map".localized(using: "SegmentedTitles"), forSegmentAt: 0)
        segmentedControl.setTitle("Saves".localized(using: "SegmentedTitles"), forSegmentAt: 1)
        segmentedControl.setTitle("Promo".localized(using: "SegmentedTitles"), forSegmentAt: 2)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: font ?? UIFont.systemFont(ofSize: 12.0)], for: .normal)
        let yellow = UIColor(red: 253/255, green: 191/255, blue: 18/255, alpha: 1)
        let gray = UIColor(red: 128/255, green: 130/255, blue: 132/255, alpha: 1)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: yellow], for: UIControlState.selected)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: gray], for: UIControlState.normal)
        var passgray = color(from: "808284")
        segmentedControl.layer.borderColor =  passgray
        
        if CLLocationManager.locationServicesEnabled(){
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            //Blocking out for right now because test data is in San fransico instead of location of iphone
            manager.startUpdatingLocation()
        } else{
            print("user didn't authorize location display pop up")
        }
        
        
        
        fetchData()
        for venue in venues{
            let tempAnnoation = Annotation()
            tempAnnoation.title = venue.title
            tempAnnoation.subtitle = venue.locationName
            tempAnnoation.coordinate = venue.coordinate
            tempAnnoation.type = venue.annotation
            annotations.append(tempAnnoation)
        }
        clusterManager.add(annotations)
        let initialLocation = CLLocation(latitude: 37.769122, longitude: -122.428353)
        zoomMapOn(location: initialLocation,radius: 2.0)
    }
    
    
    func color(from hexString : String) -> CGColor
    {
        if let rgbValue = UInt(hexString, radix: 16) {
            let red   =  CGFloat((rgbValue >> 16) & 0xff) / 255
            let green =  CGFloat((rgbValue >>  8) & 0xff) / 255
            let blue  =  CGFloat((rgbValue      ) & 0xff) / 255
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
        } else {
            return UIColor.black.cgColor
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        // or you could force view to end editing mode using self.view.endEditing(true)
    }
    
    var currentPlacemark: CLPlacemark?
    
    @IBAction func showCurrentLocation(_ sender: Any) {
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func showDirection() {
        guard let currentPlacemark = currentPlacemark else {
            return
        }
        let directionRequest = MKDirectionsRequest()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        // calculate the directions / route
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (directionsResponse, error) in
            guard let directionsResponse = directionsResponse else {
                if let error = error {
                    print("error getting directions: \(error.localizedDescription)")
                }
                return
            }
            
            let route = directionsResponse.routes[0]
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            let routeRect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(routeRect), animated: true)
            
            
        }
    }
    
    
    
    //This will be in charge of initatlly zooming to an area and setting up how far away zoom radius would be set
    private let regionRadius: CLLocationDistance = 2000 // 1km ~ 1 mile = 1.6km
    func zoomMapOn(location: CLLocation, radius: Double)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * radius, regionRadius * radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
        self.mapView.showsUserLocation = true
        currentLocation = location
       
        // zoomMapOn(location: location)
    }
    
    /* func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
     clusterManager.reload(mapView, visibleMapRect: mapView.visibleMapRect)
     }
     
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
     {
     if let annotation = annotation as? Venue {
     let identifier = "pin"
     var view: MKPinAnnotationView
     //var view: MKAnnotationView
     if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
     //if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
     
     //dequeuedView.annotation = annotation
     
     view = dequeuedView
     } else {
     view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
     //view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
     //view.image = UIImage(named: "pin.png")
     view.canShowCallout = true
     view.calloutOffset = CGPoint(x: -5, y: 5)
     view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
     }
     
     return view
     }
     
     return nil
     }
     
     func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
     {
     if let location = view.annotation as? Venue {
     self.currentPlacemark = MKPlacemark(coordinate: location.coordinate)
     }
     }*/
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchBar.text!) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                
                let placemark = placemarks?.first
                
                let anno = MKPointAnnotation()
                anno.coordinate = (placemark?.location?.coordinate)!
                anno.title = self.searchBar.text!
                
                let span = MKCoordinateSpanMake(0.075, 0.075)
                let region = MKCoordinateRegion(center: anno.coordinate, span: span)
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(anno)
                self.mapView.selectAnnotation(anno, animated: true)
                
                
                
            }else{
                print(error?.localizedDescription ?? "error")
            }
            
            
        }
        
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ClusterAnnotation {
            guard let type = annotation.type else { return nil }
            let identifier = "Cluster"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if let view = view as? BorderedClusterAnnotationView {
                view.annotation = annotation
                view.configure(with: type)
            } else {
                view = BorderedClusterAnnotationView(annotation: annotation, reuseIdentifier: identifier, type: type, borderColor: .white)
            }
            
            return view
        } else {
            guard let annotation = annotation as? Annotation, let type = annotation.type else { return nil }
            let identifier = "Pin"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            if let view = view {
                view.annotation = annotation
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            if #available(iOS 9.0, *), case let .color(color, _) = type {
                view?.pinTintColor =  color
            } else {
                view?.pinColor = .green
            }
            view!.canShowCallout = true
            view!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return view
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        clusterManager.reload(mapView, visibleMapRect: mapView.visibleMapRect)
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        if let cluster = annotation as? ClusterAnnotation {
            var zoomRect = MKMapRectNull
            for annotation in cluster.annotations {
                let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
                let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
                if MKMapRectIsNull(zoomRect) {
                    zoomRect = pointRect
                    
                } else {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect)
                }
            }
            mapView.setVisibleMapRect(zoomRect, animated: true)
        }
    }
    /*func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
     if let annotation = view.annotation as? PinAnnotation {
     // mapView.removeAnnotation(annotation)
     print(annotation)
     }
     }*/
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        var place = MKPlacemark(coordinate: (view.annotation?.coordinate)!)
        self.currentPlacemark = place
        var newCluster = view.annotation
        clusterManager.removeAll()
        clusterManager.add(newCluster!)
        showDirection()
        let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.zoomMapOn(location: self.currentLocation, radius: 1.0)
        }
    }
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach { $0.alpha = 0 }
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            views.forEach { $0.alpha = 1 }
        }, completion: nil)
    }
    
}

class BorderedClusterAnnotationView: ClusterAnnotationView {
    let borderColor: UIColor
    
    init(annotation: MKAnnotation?, reuseIdentifier: String?, type: ClusterAnnotationType, borderColor: UIColor) {
        self.borderColor = borderColor
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier, type: type)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(with type: ClusterAnnotationType) {
        super.configure(with: type)
        
        switch type {
        case .image:
            layer.borderWidth = 0
        case .color:
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 2
        }
    }
    
}
   
    


extension PrimaryContentViewController: PulleyPrimaryContentControllerDelegate {
    
    func makeUIAdjustmentsForFullscreen(progress: CGFloat, bottomSafeArea: CGFloat)
    {
        //controlsContainer.alpha = 1.0 - progress
    }
    
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat, bottomSafeArea: CGFloat)
    {
        if distance <= 268.0 + bottomSafeArea
        {
            temperatureLabelBottomConstraint.constant = distance + temperatureLabelBottomDistance
        }
        else
        {
            temperatureLabelBottomConstraint.constant = 268.0 + temperatureLabelBottomDistance
        }
    }
}

