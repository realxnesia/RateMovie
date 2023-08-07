//
//  CoreDataStorage.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import CoreData

public final class CoreDataStorage {
  public static let instance = CoreDataStorage()
  private init () { }
  private lazy var persistentContainer: NSPersistentContainer = {
    guard
      let modelURL = Bundle(for: Self.self).resource.url(
        forResource: "RateMovie", withExtension: "momd"
      ),
      let mom = NSManagedObjectModel(contentsOf: modelURL)
    else { fatalError("Unable to located Core Data model") }
    
    let container = NSPersistentContainer(name: "RateMovie", managedObjectModel: mom)
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  public func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        assertionFailure("CoreDataStorage Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}

extension CoreDataStorage {
  func performMainQueueAsync(_ block: @escaping(NSManagedObjectContext) -> Void) {
    let context = persistentContainer.viewContext
    
    context.perform {
      block(context)
    }
  }
  func performMainThread(_ block: @escaping (NSManagedObjectContext) -> Void) {
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.perform {
      block(context)
    }
  }
}

extension CoreDataStorage {
  func performPrivateQueue(_ block: @escaping(NSManagedObjectContext) -> Void) {
    persistentContainer.performBackgroundTask(block)
  }
  func performNewPrivateSync(_ block: @escaping (NSManagedObjectContext) -> Void) {
    let context = persistentContainer.newBackgroundContext()
    context.performAndWait {
      block(context)
    }
  }
  func performNewPrivateQueue(_ block: @escaping (NSManagedObjectContext) -> Void) {
    let context = persistentContainer.newBackgroundContext()
    context.undoManager = nil
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    context.perform {
      block(context)
    }
  }
}
