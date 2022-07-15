//
//  ServiceManager.swift
//  ServicesVK
//
//  Created by Daria Uchaeva on 7/14/22.
//

import Foundation

protocol ServiceManagerDelegate {
    func didLoadData(_ serviceManager: ServiceManager, services: [ServiceModel])
    func didFailWithError(error: Error)
}

struct ServiceManager {
    var delegate: ServiceManagerDelegate?
    
    func fetchServices() {
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let services = self.parseJSON(safeData) {
                        self.delegate?.didLoadData(self, services: services)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ servicesData: Data) -> [ServiceModel]? {
        let decoder = JSONDecoder()
        do {
            var servicesArray = [ServiceModel]()
            let decodedData = try decoder.decode(ServiceData.self, from: servicesData)
            for service in decodedData.body.services
            {
                let name = service.name
                let description = service.description
                let link = service.link
                let icon_url = service.icon_url
                
                let service = ServiceModel(name: name, description: description, link: link, icon_url: icon_url)
                servicesArray.append(service)
            }
            
            return servicesArray
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
