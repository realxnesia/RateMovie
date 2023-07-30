//
//  TabBarController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    createBaseTabBar()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // TODO: Onboarding if Any
  }
  
  func createBaseTabBar() {
    self.viewControllers = [
      makeNavigation(viewController: createMovieListTab()),
      makeNavigation(viewController: createMovieFavouritesTab())
    ]
  }
  
  private func setupView() {
    tabBar.tintColor = .systemRed
    self.view.layer.borderColor = UIColor.gray.cgColor
    self.view.layer.shadowOffset = CGSize(width: 10, height: 10)
    self.view.layer.shadowRadius = 3
    self.view.layer.shadowOpacity = 0.1
    self.view.layer.shadowOffset = .zero
    self.view.layer.shadowColor = UIColor.black.cgColor
    self.view.clipsToBounds = true
  }
  
  func moveToFavoritesController(){
    let controller = MovieFavouritesViewController()
    controller.viewModel = DefaultMovieFavouritesViewModel(
      useCase: DefaultMovieFavoritesUseCase(
        repository: DefaultBaseMovieRepository(
          remoteData: DefaultBaseRemoteMovies(),
          localData: DefaultBaseLocalMovies()
        )
      )
    )
    let navigation = RootViewController(
      rootViewController: controller
    )
    self.navigationController?.pushViewController(navigation, animated: true)
    self.selectedIndex = 2
  }
}

extension TabBarController {
  private func customNavigation(viewController: UIViewController) -> RootViewController {
    let navigation = RootViewController(rootViewController: viewController)
    navigation.navigationBar.prefersLargeTitles = false
    return navigation
  }
  
  private func makeNavigation(viewController: UIViewController) -> UINavigationController {
    let navigation = RootViewController(rootViewController: viewController)
    navigation.navigationBar.barStyle = .default
    navigation.delegate = self
    navigation.navigationBar.prefersLargeTitles = false
    return navigation
  }
  
  private func createMovieListTab() -> UIViewController {
    let movieListController = MovieListViewController(
      nibName: "MovieListViewController", bundle: nil
    )
    movieListController.viewModel = DefaultMovieListViewModel(
      useCase: DefaultFetchMovieUseCase(
        repository: DefaultBaseMovieRepository(
          remoteData: DefaultBaseRemoteMovies(),
          localData: DefaultBaseLocalMovies()
        )
      )
    )
    movieListController.tabBarItem.title = "Movie"
    movieListController.tabBarItem.image = UIImage(systemName: "film")
    movieListController.tabBarItem.selectedImage = UIImage(systemName: "film.fill")
    return movieListController
  }
  
  private func createMovieFavouritesTab() -> UIViewController {
    let movieFavouritesController = MovieFavouritesViewController()
    movieFavouritesController.viewModel = DefaultMovieFavouritesViewModel(
      useCase: DefaultMovieFavoritesUseCase(
        repository: DefaultBaseMovieRepository(
          remoteData: DefaultBaseRemoteMovies(),
          localData: DefaultBaseLocalMovies()
        )
      )
    )
    movieFavouritesController.tabBarItem.title = "Favourite"
    movieFavouritesController.tabBarItem.image = UIImage(systemName: "star")
    movieFavouritesController.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
    return movieFavouritesController
  }
  
  private func createDetailMovieTab() -> UIViewController {
    let movieDetailController = MovieDetailsViewController()
    movieDetailController.tabBarItem.title = "Detail"
    movieDetailController.tabBarItem.image = UIImage(systemName: "star")
    movieDetailController.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
    return movieDetailController
  }
  
}

extension UIViewController: UINavigationControllerDelegate {
  public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    if #available(iOS 14.0, *) {
      viewController.navigationItem.backButtonDisplayMode = .minimal
    } else {
      // Fallback on earlier versions
      viewController.navigationItem.backButtonTitle = ""
    }
  }
}
