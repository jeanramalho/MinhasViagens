//
//  HomeView.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit

class HomeView: UIView {
    
    lazy var viagensTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
 
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
        addSubview(viagensTableView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            viagensTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            viagensTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            viagensTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            viagensTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
