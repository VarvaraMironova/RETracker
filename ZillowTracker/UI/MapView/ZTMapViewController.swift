//
//  ZTMapViewController.swift
//  ZillowTracker
//
//  Created by Varvara Myronova on 13.11.2020.
//  Copyright © 2020 Varvara Myronova. All rights reserved.
//

import UIKit
import MapKit
import ZTModels

private extension MKMapView {
    func centerToLocation (_ location   : CLLocation,
                           regionRadius : CLLocationDistance = 3000)
    {
        let coordinateRegion = MKCoordinateRegion(
            center             : location.coordinate,
            latitudinalMeters  : regionRadius,
            longitudinalMeters : regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }
    
    func centerToDefaultLocation() {
        //Default inital location set in Austin, TX
        let defaultLat  : Double = 30.266926
        let defaultLong : Double = -97.750519
        let defaultLocation = CLLocation(latitude : defaultLat,
                                         longitude: defaultLong)
        centerToLocation(defaultLocation)
    }
}

class ZTMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    //MARK: - variables & constants
    @IBOutlet var mapView : MKMapView!
    
    weak private var rootView: ZTMapView? {
        return viewIfLoaded as? ZTMapView
    }
    
    private var locationManager = CLLocationManager()
    
    private var searchContext : ZTSearchPropertiesContext?
    private var propertyList  : [ZTEvaluatedModel]? {
        willSet(aNewValue) {
            if aNewValue != propertyList {
                hideProperties()
                
                if let aNewValue = aNewValue {
                    displayProperties(properties: aNewValue)
                }
            }
        }
    }
    
    private lazy var searchSettings = {
        return ZTSearchSettings()
    }()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2000000)
        mapView.setCameraZoomRange(zoomRange, animated: false)
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.distanceFilter = 100.0
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK:- MKMapViewDelegate
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if let searchContext = searchContext {
            switch searchContext.state {
            case .searching:
                //cancelSearch()
                break
            default:
                performSearch()
                break
            }
        } else {
            performSearch()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {return nil}
        
        let annotationView = ZTAnnotationView(annotation      :  annotation,
                                              reuseIdentifier : "ZTAnnotationView")
        return annotationView
    }
    
    //MARK:- CLLocationManagerDelegate
    func locationManager(_ manager                   : CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last {
            mapView.centerToLocation(location)
        }
    }
    
    //MARK: - Private
    private func performSearch() {
        searchSettings.save()
        let searchContext = ZTSearchPropertiesContext()
        
        searchContext.perform { (properties, error) in
            if let properties = properties {
                self.propertyList = properties
            }
            
            if let error = error, error.code != ZTUIConstants.cancelErrorCode {
                DispatchQueue.main.async {[unowned self] in
                    self.showAlert(error: error)
                }
            }
        }
        
        self.searchContext = searchContext
    }
    
    private func cancelSearch() {
        if let searchContext = searchContext {
            searchContext.cancel()
            self.searchContext = nil
        }
    }
    
    private func displayProperties(properties: [ZTEvaluatedModel]) {
        DispatchQueue.main.async {[unowned mapView] in
            if let mapView = mapView {
                for evaluatedModel in properties {
                    let annotation = ZTAnnotation(evaluatedModel: evaluatedModel)
                    mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    private func hideProperties() {
        DispatchQueue.main.async {[unowned mapView] in
            if let mapView = mapView {
                let annotations = mapView.annotations
                mapView.removeAnnotations(annotations)
            }
        }
    }
}
