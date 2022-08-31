//
//  FilmTableViewCell.swift
//  MovieList
//
//  Created by никита богатырев on 31.08.2022.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    static let identifier = "FilmTableViewCell"
    
    private let filmLabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.addSubview(filmLabel)
        
        NSLayoutConstraint.activate([
            filmLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            filmLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(model:Film){
        filmLabel.text = "\(model.name)  \(model.year)"
    }
}
