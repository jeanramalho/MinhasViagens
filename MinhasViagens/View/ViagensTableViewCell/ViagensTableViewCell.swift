//
//  ViagensTableViewCell.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit

class ViagensTableViewCell: UITableViewCell {
    
    lazy var miniLogoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "logo")
        image.backgroundColor = .blue
        return image
    }()
    
    lazy var viagemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    static let identifier: String = "ViagensTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        contentView.addSubview(miniLogoImageView)
        contentView.addSubview(viagemLabel)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            miniLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            miniLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            miniLogoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            miniLogoImageView.widthAnchor.constraint(equalToConstant: 60),
            miniLogoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            
            viagemLabel.leadingAnchor.constraint(equalTo: miniLogoImageView.trailingAnchor, constant: 8),
            viagemLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            viagemLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            viagemLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
        ])
    }
}

