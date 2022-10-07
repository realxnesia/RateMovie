//
//  MovieFavouritesViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

class MovieFavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

}

extension MovieFavouritesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

extension MovieFavouritesViewController {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieItemTableViewCell.nib(), forCellReuseIdentifier: MovieItemTableViewCell.identifier)
    }
}

extension MovieFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieItemTableViewCell.identifier, for: indexPath) as? MovieItemTableViewCell
        else {
            return UITableViewCell()
        }
        
        return movieCell
    }
    
    
}
