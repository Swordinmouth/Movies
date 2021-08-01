// MoveiImageAndNameTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейки для постера и названия фильмов
final class MoveiImageAndNameTableViewCell: UITableViewCell {
    // MARK: - Private Properties

    private let moviePosterImageView = UIImageView()
    private let movieTitleLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        movieImageViewConstraints()
        movieTitleLabelConstraints()
    }

    // MARK: - Private Methods

    func configure(movie: Result) {
        movieTitleLabel.text = movie.title
        DispatchQueue.global().async {
            let urlString = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
            guard let url = URL(string: urlString) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            guard let posterImage = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.moviePosterImageView.image = posterImage
            }
        }
    }

    private func movieImageViewConstraints() {
        moviePosterImageView.clipsToBounds = true
        addSubview(moviePosterImageView)
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moviePosterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: 65),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func movieTitleLabelConstraints() {
        movieTitleLabel.numberOfLines = 2
        addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
