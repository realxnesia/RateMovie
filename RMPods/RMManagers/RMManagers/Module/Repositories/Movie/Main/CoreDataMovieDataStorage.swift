//
//  CoreDataMovieDataStorage.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import CoreData

public final class CoreDataMovieDataStorage {
  let coreDataStorage: CoreDataStorage
  public init(coreDataStorage: CoreDataStorage = CoreDataStorage.instance) {
    self.coreDataStorage = coreDataStorage
  }
}

extension CoreDataMovieDataStorage {
  func fetchData() -> NSFetchRequest<MoviesFavourite> {
    let request: NSFetchRequest = MoviesFavourite.fetchRequest()
    return request
  }
  func deleteData(in context: NSManagedObjectContext) {
    let request = fetchData()
    do {
      let result = try context.fetch(request)
      for object in result {
        context.delete(object)
      }
    } catch {}
  }
}
