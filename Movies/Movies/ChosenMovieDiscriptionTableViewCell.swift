// ChosenMovieDiscriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка для описания фильма
final class ChosenMovieDiscriptionTableViewCell: UITableViewCell {
    // MARK: - Private Properties

    private let chosenMovieDescriptionLabel = UILabel()

    // MARK: - Public Methods

    func configure(movie: Result) {
        chosenMovieDescriptionLabel.text = movie.overview
    }

    override func layoutSubviews() {
        constraints()
    }

    // MARK: - Private Metgods

    private func constraints() {
        chosenMovieDescriptionLabel.numberOfLines = 0
        chosenMovieDescriptionLabel.font = UIFont(name: "Apple SD Gothic Neo", size: 15)
        chosenMovieDescriptionLabel.textAlignment = .center
        addSubview(chosenMovieDescriptionLabel)
        chosenMovieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chosenMovieDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chosenMovieDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            chosenMovieDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            chosenMovieDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
