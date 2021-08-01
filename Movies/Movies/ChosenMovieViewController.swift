// ChosenMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// TableView для выбранного фильма
final class ChosenMovieViewController: UIViewController {
    // MARK: - Private Properties

    private var imageCellID = "ChosenMovieImageCell"
    private var descriptionCellID = "ChosenMovieDescriptionCell"

    private var movieList: Result?

    private let chosenMovieTableView: UITableView = {
        let chosenMovieTableView = UITableView()
        chosenMovieTableView.translatesAutoresizingMaskIntoConstraints = false
        chosenMovieTableView.register(
            ChosenMovieImageTableViewCell.self,
            forCellReuseIdentifier: "ChosenMovieImageCell"
        )
        chosenMovieTableView.register(
            ChosenMovieDiscriptionTableViewCell.self,
            forCellReuseIdentifier: "ChosenMovieDescriptionCell"
        )

        return chosenMovieTableView
    }()

    // MARK: - Public Properties

    var movieID = Int()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        subviews()
        fetchFill()
        chosenMovieTableView.delegate = self
        chosenMovieTableView.dataSource = self
        constraints()
    }

    // MARK: - Private Methods

    private func subviews() {
        view.addSubview(chosenMovieTableView)
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            chosenMovieTableView.topAnchor.constraint(equalTo: view.topAnchor),
            chosenMovieTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chosenMovieTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chosenMovieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func fetchFill() {
        guard let url =
            URL(
                string: """
                https://api.themoviedb.org/3/movie/\(movieID)?api_key=7502b719af3e4c9ad68d80658e7b83ed&language=ru-RU
                """
            )
        else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                self.movieList = try JSONDecoder()
                    .decode(Result.self, from: data ?? Data()) // во 2 экране вместо movieList парсим Result
                DispatchQueue.main.async {
                    self.chosenMovieTableView.reloadData()
                    print("reloadData")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - UITableViewDataSource

extension ChosenMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "ChosenMovieImageCell",
                    for: indexPath
                ) as? ChosenMovieImageTableViewCell
            else { return UITableViewCell() }

            guard let movie = movieList else { return UITableViewCell() }
            cell.configure(movie: movie)

            return cell
        } else {
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: "ChosenMovieDescriptionCell",
                    for: indexPath
                ) as? ChosenMovieDiscriptionTableViewCell
            else { return UITableViewCell() }

            guard let movie = movieList else { return UITableViewCell() }
            cell.configure(movie: movie)

            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ChosenMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        } else {
            return 150
        }
    }
}
