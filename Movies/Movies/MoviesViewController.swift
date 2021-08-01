// MoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Контроллер для библиотеки фильмов
final class MoviesViewController: UIViewController {
    // MARK: - Private Properties

    private var movieList: MovieList?

    private let moviesTableView: UITableView = {
        let moviesTableView = UITableView()
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.register(MoveiImageAndNameTableViewCell.self, forCellReuseIdentifier: "cell")
        return moviesTableView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        subviews()
        constraints()
        fetchFill()
    }

    // MARK: - Private MEthods

    private func subviews() {
        view.addSubview(moviesTableView)
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            moviesTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchFill() {
        guard let url =
            URL(
                string: """
                https://api.themoviedb.org/3/movie/popular?api_key=7502b719af3e4c9ad68d80658e7b83ed&language=ru-US&page=1
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
                    .decode(MovieList.self, from: data ?? Data())
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MoveiImageAndNameTableViewCell
        else { return UITableViewCell() }

        guard let movie = movieList?.results[indexPath.row] else { return UITableViewCell() }
        cell.configure(movie: movie)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = movieList?.results[indexPath.row].id else { return }
        let vc = ChosenMovieViewController()
        vc.movieID = movieID
        print(movieID)
        navigationController?.pushViewController(vc, animated: true)
    }
}
