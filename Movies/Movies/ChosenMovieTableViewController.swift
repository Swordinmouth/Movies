// ChosenMovieTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ChosenMovieTableViewController: UITableViewController {
    private var movieList: MovieList?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "ChosenMovieCell", for: indexPath) as? MoveiImageTableViewCell
        else { return UITableViewCell() }

        guard let movie = movieList?.results[indexPath.row] else { return UITableViewCell() }
        cell.configure(movie: movie)

        return cell
    }
}
