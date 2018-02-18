//
//  DetailViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 18/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func dismissAction(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
