//
//  AllCitiesController.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 31.03.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

class AllCitiesController: UITableViewController {
    
    var cities: [CitiesAll] = [CitiesAll(name: "Moscow", icon: "moskow"),CitiesAll(name: "Krasnoyarsk", icon: "krasnoyarsk"), CitiesAll(name: "London", icon: "london"), CitiesAll(name: "Paris", icon: "paris")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "все горда"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // Получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! AllCitiesCell
        // Получаем город для конкретной строки
        let city = cities[indexPath.row]
        
        // Устанавливаем город в надпись ячейки
        cell.cityName.text = city.name
        cell.CityView.image.image = UIImage(named: city.icon)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
