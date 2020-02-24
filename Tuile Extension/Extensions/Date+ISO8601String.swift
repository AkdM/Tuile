//
//  Date+ISO8601String.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 24/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import Foundation

extension Date {
    static let currentAsISO8601String: String = {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        let iso8601String = dateFormatter.string(from: Date())
        return iso8601String
    }()
}
