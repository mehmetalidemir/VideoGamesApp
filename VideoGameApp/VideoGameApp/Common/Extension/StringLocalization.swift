//
//  StringLocalization.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 23.01.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            value: self,
            comment: self
        )
    }
}
