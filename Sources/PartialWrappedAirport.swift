//
//  PartialWrappedAirport.swift
//  Airport
//
//  Created by Phillip Kast on 1/12/25.
//  Copyright © 2025 Flight School. All rights reserved.
//

import Foundation

struct PartialWrapper: Codable {
    let response: String
    let status: String
    // Ignore other keys like "payload"
}
