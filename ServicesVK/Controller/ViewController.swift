//
//  ViewController.swift
//  ServicesVK
//
//  Created by Daria Uchaeva on 7/14/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var serviceManager = ServiceManager()
    var servicesData: [ServiceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceManager.delegate = self
        serviceManager.fetchServices()       
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = servicesData[indexPath.row]
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ServiceCell
        cell.serviceNameLabel.text = message.name
      
        return cell
    }
}

extension ViewController: ServiceManagerDelegate {
    func didLoadData(_ serviceManager: ServiceManager, services: [ServiceModel]) {
        servicesData = services
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
