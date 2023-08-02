//
//  CoreDataStorageError.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
    case emptyData
    case duplicatedData
}
