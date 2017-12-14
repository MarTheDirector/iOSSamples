//
//  DrawerPreviewContentViewController.swift
//  Pulley
//
//  Created by Brendan Lee on 7/6/16.
//  Copyright © 2016 52inc. All rights reserved.
//

import UIKit
import Pulley
import MapKit

class DrawerContentViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var gripperView: UIView!
    var test: String?
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    // We adjust our 'header' based on the bottom safe area using this constraint
    @IBOutlet var headerSectionHeightConstraint: NSLayoutConstraint!
    var language: String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let preferredLanguage = NSLocale.preferredLanguages[0]
        language = preferredLanguage
        
    }
    fileprivate var drawerBottomSafeArea: CGFloat = 0.0 {
        didSet {
            self.loadViewIfNeeded()
            
            // We'll configure our UI to respect the safe area. In our small demo app, we just want to adjust the contentInset for the tableview.
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: drawerBottomSafeArea, right: 0.0)
            
            searchCompleter.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gripperView.layer.cornerRadius = 2.5
       /* var currentLoc = PrimaryContentViewController().currentLocation
        //searchCompleter.filterType =
        let center = CLLocationCoordinate2D(latitude: (currentLoc?.coordinate.latitude)!, longitude: (currentLoc?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        searchCompleter.region = region*/
        //print("string")
        var request = MKLocalSearchRequest()
        request.naturalLanguageQuery = language
        var span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        var cornerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(51.5007282, -0.1246263)
        request.region = MKCoordinateRegionMake(cornerCoordinate, span)
        var search = MKLocalSearch(request: request)
    }
    
}


extension DrawerContentViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}
extension DrawerContentViewController: PulleyDrawerViewControllerDelegate {

    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 68.0 + bottomSafeArea
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 264.0 + bottomSafeArea
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
    }
    
    // This function is called by Pulley anytime the size, drawer position, etc. changes. It's best to customize your VC UI based on the bottomSafeArea here (if needed).
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
    {
        // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
        drawerBottomSafeArea = bottomSafeArea
        
        /*
         Some explanation for what is happening here:
         1. Our drawer UI needs some customization to look 'correct' on devices like the iPhone X, with a bottom safe area inset.
         2. We only need this when it's in the 'collapsed' position, so we'll add some safe area when it's collapsed and remove it when it's not.
         3. These changes are captured in an animation block (when necessary) by Pulley, so these changes will be animated along-side the drawer automatically.
         */
        if drawer.drawerPosition == .collapsed
        {
            headerSectionHeightConstraint.constant = 68.0 + drawerBottomSafeArea
        }
        else
        {
            headerSectionHeightConstraint.constant = 68.0
        }
        
        // Handle tableview scrolling / searchbar editing
        
        tableView.isScrollEnabled = drawer.drawerPosition == .open
        
        if drawer.drawerPosition != .open
        {
            searchBar.resignFirstResponder()
        }
    }
}

extension DrawerContentViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if let drawerVC = self.parent as? PulleyViewController
        {
            drawerVC.setDrawerPosition(position: .open, animated: true)
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

extension DrawerContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 5
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SampleCell")
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        ///return tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        return cell
    }
}

extension DrawerContentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let drawer = self.parent as? PulleyViewController
        {
            let primaryContent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrimaryTransitionTargetViewController")
            
            drawer.setDrawerPosition(position: .collapsed, animated: true)
            
            drawer.setPrimaryContentViewController(controller: primaryContent, animated: false)
        }
    }
}


