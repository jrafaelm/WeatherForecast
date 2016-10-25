//
//  CitiesTableViewController.swift
//  WeatherForecast
//
//  Created by Rafael Moraes on 24/10/16.
//  Copyright © 2016 Rafael Moraes. All rights reserved.
//

import UIKit
import CoreLocation
import PKHUD

class CitiesTableViewController: UITableViewController {

    var cities : [City]?
    var coordinate : CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getCities()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Request
    
    private func getCities(){
        HUD.show(.progress)
        let url = URL(string: "http://api.openweathermap.org/data/2.5/find?lat=\(self.coordinate!.latitude)&lon=\(self.coordinate!.longitude)&cnt=15&APPID=4bd8934d1a4555dda9f31894db43164f")
        URLSession.shared.dataTask(with:url!, completionHandler: { (data, response, error) in
            HUD.hide()
            if error != nil {
                print(error)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    self.cities = [City]();
                    if let dictionaries =  parsedData["list"] as? NSArray{
                        for dictionary in dictionaries {
                            if let map = dictionary as? [String:AnyObject]{
                                let city = City.init(map: map)
                                self.cities?.append(city)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }).resume()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.cities != nil {
            return self.cities!.count
        }else{
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCellId", for: indexPath)

        let city = self.cities?[indexPath.row]
        cell.textLabel?.text = city?.name
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? CityDetailViewController {
            if let cell = sender as? UITableViewCell{
                let indexPath = self.tableView.indexPath(for: cell)
                nextViewController.city = self.cities?[(indexPath?.row)!]
            }
        }
    }
    

}
