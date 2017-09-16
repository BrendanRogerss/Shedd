//
//  ViewController.swift
//  Test
//
//  Created by Brendan Rogers on 15/9/17.
//  Copyright © 2017 Brendan Rogers. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -32.926581, longitude: 151.774008, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        Alamofire.request("http://hackathon-env.wmuyppksmy.ap-southeast-2.elasticbeanstalk.com/events").responseJSON { response in
            
            if let result = response.result.value{
                // main[0]["USDARS"] or use main.first?["USDARS"] for first index or loop through array
                let json = result as! NSArray
                for event in json{
                    let event_data = event as! NSDictionary
                    
                    let event_sub_data = event_data["location"] as! NSDictionary
                    
                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: event_sub_data["latitude"] as! Double, longitude: event_sub_data["longitude"] as! Double)
                    
                    marker.title = event_data["name"] as! String
                    marker.snippet = event_data["description"] as! String
                    marker.icon = UIImage(named: "Event_Pin")
                    marker.map = mapView
                    
                }
                
                //print(json[0])
            }
            
            
        }
        
        
    }


}
