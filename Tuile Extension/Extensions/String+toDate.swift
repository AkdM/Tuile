//
//  String+toDate.swift
//  Tuile
//
//  Created by Anthony Da Mota on 01/04/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        let date = dateFormatter.date(from: self)
        return date
    }
}
