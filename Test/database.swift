////
////  database.swift
////  Test
////
////  Created by Brendan Rogers on 16/9/17.
////  Copyright © 2017 Brendan Rogers. All rights reserved.
////
//
//import Foundation
//import Alamofire
//class database{
//    
//    func events() -> String{
//        Alamofire.request("http://hackathon-env.wmuyppksmy.ap-southeast-2.elasticbeanstalk.com/events").responseJSON { response in
//            
//            if let result = response.result.value{
//                // main[0]["USDARS"] or use main.first?["USDARS"] for first index or loop through array
//                let json = result as! NSArray
//                for event in json{
//                    let event_data = event as! NSDictionary
//                    
//                    let event_sub_data = event_data["location"] as! NSDictionary
//                    
//                    // Creates a marker in the center of the map.
//                    let x = event_sub_data["latitude"] as! Double
//                    let y = event_sub_data["longitude"] as! Double
//                    
//                }
//                //print(json[0])
//            }
//    }
//}
