//
//  Venue.swift
//  mapinte
//
//  Created by Mar on 10/16/17.
//  Copyright © 2017 DreamDrawn. All rights reserved.
//

import MapKit
import Contacts
import SwiftyJSON
import Cluster


class Venue: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    let annotation: ClusterAnnotationType?
    
    init(title: String, locationName: String?, coordinate: CLLocationCoordinate2D, annotation: ClusterAnnotationType?)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.annotation = annotation
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    class func from(json: JSON) -> Venue?
    {
        var title: String
        if let unwrappedTitle = json["name"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }
        
        var locationName = json["location"]["address"].string!
        locationName += ", "
        locationName += json["location"]["city"].string!
        locationName += ", "
        locationName += json["location"]["state"].string!
        locationName += " "
        locationName += json["location"]["postalCode"].string!
        
        let lat = json["location"]["lat"].doubleValue
        let long = json["location"]["lng"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        
        var priceColor: String
        if let unwrappedPriceColor = json["contact"]["priceColor"].string {
            priceColor = unwrappedPriceColor
        } else {
            priceColor = "red"
        }
        
       
     
        let annotation : ClusterAnnotationType = {
            switch priceColor {
            case "red": return  .color(.red, radius: 25)
            case "blue": return  .color(.blue, radius: 25)
            case "purple": return .color(.purple, radius: 25)
            case "yellow": return .color(.yellow, radius: 25)
            default: return  .color(.orange, radius: 25)
            }
        }()
        
        return Venue(title: title, locationName: locationName, coordinate: coordinate, annotation: annotation)
    }
    
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(CNPostalAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(title) \(String(describing: subtitle))"
        
        return mapItem
    }
}

