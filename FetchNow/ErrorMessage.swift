//
//  ErrorMessage.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/23/21.
//

import Foundation
enum ErrorMessage: String, Error {
    case invalidData = "Sorry. Something went wrong, try again"
    case invalidResponse = "Error. Please modify your search and try again"
}
