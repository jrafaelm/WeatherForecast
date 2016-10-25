//
//  CityDetailViewController.swift
//  WeatherForecast
//
//  Created by Rafael Moraes on 24/10/16.
//  Copyright © 2016 Rafael Moraes. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    @IBOutlet weak var lblName : UILabel?
    @IBOutlet weak var lblMinTemperature : UILabel?
    @IBOutlet weak var lblMaxTemperature : UILabel?
    @IBOutlet weak var lblDescription : UILabel?
    
    var city : City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblName?.text = city?.name
        self.lblMinTemperature?.text = String(format:"%.1f", (city?.minTemperatureCelsius)!)
        self.lblMaxTemperature?.text = String(format:"%.1f", (city?.maxTemperatureCelsius)!)
        self.lblDescription?.text = city?.weatherDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}

}
