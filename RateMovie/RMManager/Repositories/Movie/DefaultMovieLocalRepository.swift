//
//  DefaultMovieLocalRepository.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import CoreData
import RMDomainEntities

extension CoreDataMovieDataStorage: LocalMovieRepository {
    func getAllFavouriteMovie(completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        coreDataStorage.performNewPrivateQueue { context in
            do {
                let fetchRequest = self.fetchData()
                let fetchResults = try context.fetch(fetchRequest)
                completion(
                    self.convertToFavouritesModelArray(
                        moviesFavourites: fetchResults
                    )
                )
            } catch { fatalError("[x] Error while getAllFavouriteMovie()") }
        }
    }

    func getSelectedFavourite(
        _ id: Int,
        completion: @escaping (Bool) -> Void
    ) {
        coreDataStorage.performNewPrivateQueue { context in
            do {
                let fetchRequest = self.fetchData()
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                let fetchResults = try context.fetch(fetchRequest)
                if fetchResults.first != nil {
                    completion(true)
                    return
                }
                completion(false)
            } catch let error as NSError {
                print("[x] Could not fetch. getSelectedFavourite(_:) \(error), \(error.userInfo)")
            }
        }
    }
    
    func addFavourite(_ favouriteModel: MoviesFavouritesModel) {
        coreDataStorage.performNewPrivateQueue { context in
            do {
                _ = favouriteModel.toMoviesFavouritesEntity(in: context)
                try context.save()
            } catch { }
        }
    }
    
    func deleteFavourite(with id: Int) {
        coreDataStorage.performNewPrivateQueue { context in
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesFavourite")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                let batchDeleteRequest = NSBatchDeleteRequest(
                    fetchRequest: fetchRequest
                )
                try context.execute(batchDeleteRequest)
            } catch let error as NSError {
                print("[x] Could not delete deleteFavourite(_:). \(error), \(error.userInfo)")
            }
        }
    }
}

extension CoreDataMovieDataStorage {
    private func convertToFavouritesModelArray(
        moviesFavourites: [MoviesFavourite]
    ) -> [MoviesFavouritesModel] {
        return moviesFavourites.map { $0.toDTO() }
    }
}
