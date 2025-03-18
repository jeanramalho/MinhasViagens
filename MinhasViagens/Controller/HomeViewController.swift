//
//  HomeViewController.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let contentView: HomeView = HomeView()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.style = .plain
        button.target = self
        button.action = #selector(showMapaView)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        self.title = "Minhas Viagens"
        
        //configura layout da navigationBar
        if let navigationBar = navigationController?.navigationBar {
            //configura cor de fundo
            let navBarlayout = UINavigationBarAppearance()
            navBarlayout.configureWithOpaqueBackground()
            navBarlayout.backgroundColor = .blue
            
            //configura cor do título
            navBarlayout.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            //aplica a aparencia em todos os estados da navigationBar
            navigationBar.standardAppearance = navBarlayout
            navigationBar.scrollEdgeAppearance = navBarlayout
            navigationBar.compactAppearance = navBarlayout
            
            //para ios 15 ou superior define cor dos icones
            navigationBar.tintColor = .white
        }
        
        self.navigationItem.rightBarButtonItem = addButton
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
    
    @objc private func showMapaView(){
        let mapaVC = MapaViewController()
        self.navigationController?.pushViewController(mapaVC, animated: true)
    }
}
