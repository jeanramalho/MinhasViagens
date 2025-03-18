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
        
        setupContentView()
        setupNavigationBar()
        setHierarchy()
        setConstraints()
    }
    
    private func setupContentView(){
        contentView.viagensTableView.delegate = self
        contentView.viagensTableView.dataSource =  self
        
        contentView.viagensTableView.register(ViagensTableViewCell.self, forCellReuseIdentifier: ViagensTableViewCell.identifier)
    }
    
    private func setupNavigationBar(){
        self.title = "Minhas Viagens"
        
        //configura layout da navigationBar
        if let navigationBar = navigationController?.navigationBar {
            //configura cor de fundo
            let navBarlayout = UINavigationBarAppearance()
            navBarlayout.configureWithOpaqueBackground()
            navBarlayout.backgroundColor = .blue
            
            // Configurar cor e TAMANHO do título
            let fontAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)
                   ]
            navBarlayout.titleTextAttributes = fontAttributes
            
            //aplica a aparencia em todos os estados da navigationBar
            navigationBar.standardAppearance = navBarlayout
            navigationBar.scrollEdgeAppearance = navBarlayout
            navigationBar.compactAppearance = navBarlayout
            
            //para ios 15 ou superior define cor dos icones
            navigationBar.tintColor = .white
        }
        
        self.navigationItem.rightBarButtonItem = addButton
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViagensTableViewCell.identifier, for: indexPath) as? ViagensTableViewCell else {return UITableViewCell()}
        cell.viagemLabel.text = "texto testando"
        return cell
    }
    
    
}
