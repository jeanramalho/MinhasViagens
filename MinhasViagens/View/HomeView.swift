//
//  HomeView.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit

class HomeView: UIView {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([

        ])
    }
}
