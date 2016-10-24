//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Rafael Moraes on 24/10/16.
//  Copyright © 2016 Rafael Moraes. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView : GMSMapView?
    var selectedMarker : GMSMarker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushList" {
            if selectedMarker != nil {
                
            }else{
                let alertController = UIAlertController(title: "Hey!", message: "Tap on the map to see the forecast of the region", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    //MARK: GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        if self.selectedMarker == nil {
            self.selectedMarker = GMSMarker.init();
        }
        self.selectedMarker!.position = coordinate;
        self.selectedMarker!.title = "Search";
        self.selectedMarker!.snippet = "Forecast for this region";
        self.selectedMarker!.map = self.mapView;
    }
}

