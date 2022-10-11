//
//  BaseLocalMovies.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 09/10/22.
//

import Foundation
import CoreData

protocol BaseLocalMoviesProtocol {
    mutating func getAllFavouriteMovie(completion: @escaping(_ members: [MoviesFavouritesModel]) -> Void)
    mutating func getSelectedFavourite(_ id: Int, completion: @escaping(_ bool: Bool) -> Void)
    mutating func addFavourite(_ favouriteModel: MoviesFavouritesModel) throws
    mutating func deleteFavourite(with id: Int) throws
}

struct DefaultBaseLocalMovies: BaseLocalMoviesProtocol {
    private lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "RateMovie")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError("Unresolved Error \(error!)") }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    
    mutating func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    mutating func getSelectedFavourite(_ id: Int, completion: @escaping (Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MoviesFavourite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if (try taskContext.fetch(fetchRequest).first) != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    mutating func getAllFavouriteMovie(completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MoviesFavourite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var favourites = [MoviesFavouritesModel]()
                for result in results {
                    let favourite = MoviesFavouritesModel(
                        id: result.value(forKeyPath: "id") as? Int,
                        title: result.value(forKeyPath: "title") as? String,
                        originalLanguage: result.value(forKeyPath: "originalLanguage") as? String,
                        posterPath: result.value(forKeyPath: "posterPath") as? String,
                        voteAverage: result.value(forKeyPath: "voteAverage") as? Double
                    )
                    favourites.append(favourite)
                }
                completion(favourites)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    mutating func addFavourite(_ favouriteModel: MoviesFavouritesModel) throws {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "MoviesFavourite", in: taskContext) {
                let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
                favorite.setValue(favouriteModel.id, forKeyPath: "id")
                favorite.setValue(favouriteModel.title, forKeyPath: "title")
                favorite.setValue(favouriteModel.originalLanguage, forKeyPath: "originalLanguage")
                favorite.setValue(favouriteModel.posterPath, forKeyPath: "posterPath")
                favorite.setValue(favouriteModel.voteAverage, forKeyPath: "voteAverage")
                do {
                    try taskContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    mutating func deleteFavourite(with id: Int) throws {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesFavourite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            do {
                try taskContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        }
    }
}
