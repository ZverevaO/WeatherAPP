//
//  MyCitiesController.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 31.03.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit
import RealmSwift

class MyCitiesController: UITableViewController {
    
    var cityes: Results<City>?
    var token: NotificationToken?
    
    var myCities = [CitiesAll]()
    
    
    @IBAction func addCityBtn(_ sender: Any) {
        showAddCityForm()
        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "избранные города"
        pairTableAndRealm()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityes?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем ячейку из пула
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCitiesCell", for: indexPath) as! MyCitiesCell
        // Получаем город для конкретной строки
        let city = cityes![indexPath.row]
        
        // Устанавливаем город в надпись ячейки
        cell.myCityName.text = city.name
        //cell.MyCityView.image.image = UIImage(named: city.icon)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let city = cityes![indexPath.row]
        // Если была нажата кнопка «Удалить»
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(city.weathers)
                realm.delete(city)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        }
    }
    
    func showAddCityForm() {
        let alertController = UIAlertController(title: "Введите город", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
        })
        let confirmAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
            guard let name = alertController.textFields?[0].text else { return }
            self?.addCity(name: name)
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true  )
    }
    
    func addCity(name: String) {
        let newCity = City()
        newCity.name = name
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(newCity, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        cityes = realm.objects(City.self)
        token = cityes?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherViewController", let cell = sender as? UITableViewCell {
            let ctrl = segue.destination as! WeatherCollectionView
            if let indexPath = tableView.indexPath(for: cell) {
                ctrl.cityName = cityes![indexPath.row].name
            }
        }
    }
    
}
