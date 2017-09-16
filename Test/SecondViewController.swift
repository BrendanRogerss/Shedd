//
//  SecondViewController.swift
//  Test
//
//  Created by Brendan Rogers on 16/9/17.
//  Copyright © 2017 Brendan Rogers. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController {

    var idToDisplay = "nil"
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var bio: UITextField!
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //labels[0].text = "test"
        
        Alamofire.request("http://hackathon-env.wmuyppksmy.ap-southeast-2.elasticbeanstalk.com/users/" + idToDisplay).responseJSON { response in
            if let result = response.result.value{
                let json = result as! NSDictionary
                self.labels[0].text = json["first_name"] as! String
                self.labels[1].text = json["suburb"] as! String
                
                self.bio.text = json["bio"] as! String
                
                let interests = json["interests"] as! NSArray
                
                self.labels[2].text = interests[0] as! String
                self.labels[3].text = interests[1] as! String
                self.labels[4].text = interests[2] as! String
                self.labels[5].text = interests[3] as! String
                
                //self.photo.image = UIImage(named: json["image"] as! String + "_profile.png")
                
            }
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
