//
//  LaunchScreenViewController.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit

class LaunchScreenViewController: UIViewController {
    
    let contentView: LaunchScreenView = LaunchScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        showHomeView()
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        view.addSubview(contentView)
    }
    
    private func setConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func showHomeView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
            let homeView = HomeViewController()
            self?.navigationController?.setViewControllers([homeView], animated: true)
        }
    }
}
