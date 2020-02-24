//
//  SessionModel.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 23/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import Foundation

struct TuileTab: Codable {
    var title: String?
    var url: URL?
    var isPrivate: Bool?
}

struct TuileWindow: Codable {
    var tabs: [TuileTab]?
}

struct TuileSession: Codable {
    var windows: [TuileWindow]
    var title: String
    var createdDate: String
}
