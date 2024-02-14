//
//  Item.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/02/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
