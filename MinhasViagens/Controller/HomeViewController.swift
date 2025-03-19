//
//  HomeViewController.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    let contentView: HomeView = HomeView()
    private let viagensDataBase = ViagensModel()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.style = .plain
        button.target = self
        button.action = #selector(addButtonAction)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentView.viagensTableView.reloadData()
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
    
    
    @objc private func showMapaView(latitude: String?, longitude: String?, title: String?){
        let mapaVC = MapaViewController()
        if (latitude != nil) && (longitude != nil) {
            mapaVC.viagemLati = CLLocationDegrees(latitude ?? "")
            mapaVC.viagemLongi = CLLocationDegrees(longitude ?? "")
            mapaVC.addAnnotation(latiParametro: CLLocationDegrees(latitude ?? ""), longiParametro: CLLocationDegrees(longitude ?? ""), annotationTitle: title ?? "")
            self.navigationController?.pushViewController(mapaVC, animated: true)
        } else {
            self.navigationController?.pushViewController(mapaVC, animated: true)
        }
        
    }
    
    @objc private func addButtonAction(){
        showMapaView(latitude: nil, longitude: nil, title: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viagensDataBase.listarViagens().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViagensTableViewCell.identifier, for: indexPath) as? ViagensTableViewCell else {return UITableViewCell()}
        cell.viagemLabel.text = viagensDataBase.listarViagens()[indexPath.row]["local"]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viagensDataBase.deletarViagem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let latitude = viagensDataBase.listarViagens()[indexPath.row]["latitude"]
        let longitude = viagensDataBase.listarViagens()[indexPath.row]["longitude"]
        let title = viagensDataBase.listarViagens()[indexPath.row]["local"]
        showMapaView(latitude: latitude, longitude: longitude, title: title)
    }
    
}
