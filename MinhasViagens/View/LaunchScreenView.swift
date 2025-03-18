//
//  LauchScreenView.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit

class LaunchScreenView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "logo")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = .blue
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        addSubview(logoImageView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
        ])
    }
}
