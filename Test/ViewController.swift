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

class ViewController: UIViewController, GMSMapViewDelegate {
    
    var idToPass = "nil"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        //image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func plotMarkers(mapView: GMSMapView, endpoint: String){
        Alamofire.request("http://hackathon-env.wmuyppksmy.ap-southeast-2.elasticbeanstalk.com/" + endpoint).responseJSON { response in
            if let result = response.result.value{
                let json = result as! NSArray
                for event in json{
                    let event_data = event as! NSDictionary
                    let event_sub_data = event_data["location"] as! NSDictionary
                    let marker = GMSMarker()
                    
                    marker.position = CLLocationCoordinate2D(latitude: event_sub_data["latitude"] as! Double, longitude: event_sub_data["longitude"] as! Double)
                    marker.title = event_data["_id"] as! String
                    
                    let image = event_data["image"]
                    
                    var icon = self.imageWithImage(image: UIImage(named: "event_image.png")!, scaledToSize: CGSize(width: 30.0, height: 40.0))
                    
                    if image != nil{
                        print(image as! String)
                        icon = self.imageWithImage(image: UIImage(named: image as! String + ".png")!, scaledToSize: CGSize(width: 27.0, height: 40.0))
                    }
                    
                    marker.icon = icon
                    
                    marker.map = mapView
                    
                    
                }
            }
        }
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -32.926581, longitude: 151.774008, zoom: 14.5)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        
        plotMarkers(mapView: mapView, endpoint: "events")
        plotMarkers(mapView: mapView, endpoint: "users")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? SecondViewController
        controller?.idToDisplay = self.idToPass
    }
    
    func mapView(_ mapView: GMSMapView, didTapMarker marker: GMSMarker) {
        //print(marker.title)
        self.idToPass = marker.title!
        performSegue(withIdentifier: "segue1", sender: self)
    }
}
