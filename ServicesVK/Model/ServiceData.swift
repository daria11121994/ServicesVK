//
//  ServiceData.swift
//  ServicesVK
//
//  Created by Daria Uchaeva on 7/14/22.
//

import Foundation

struct ServiceData: Codable {
    let body: ServiceBody
}

struct ServiceBody: Codable {
    let services: [Service]
}

struct Service: Codable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}

