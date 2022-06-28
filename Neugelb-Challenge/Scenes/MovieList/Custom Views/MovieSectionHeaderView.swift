//
//  MovieSectionHeaderView.swift
//  Neugelb-Challenge
//
//  Created by DENİZÇ on 25.06.2022.
//

import UIKit

class MovieSectionHeaderView: UITableViewHeaderFooterView {
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemBrown
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHeaderLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeaderLabel() {
        contentView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            headerLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
