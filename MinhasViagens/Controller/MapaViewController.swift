//
//  MapaViewController.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 18/03/25.
//
import Foundation
import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    let contentView: MapaView = MapaView()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        setupLocation()
        setupNavigationBar()
        setHierarchy()
        setConstraints()
    }
    
    private func setupNavigationBar(){
        self.title = "Mapa"
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
}

extension MapaViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    private func setupLocation(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    private func mapAddMark(){
        let mapa = contentView.mapView
        //cria objeto que reconhece o toque longo
        let getGesture = UILongPressGestureRecognizer(target: self, action: #selector(mapMark(gesture: )))
        //configura tempo de toque longo
        getGesture.minimumPressDuration = 2
        
        //Faa o mapa reconhecer o gesto de toque
        mapa.addGestureRecognizer(getGesture)
    }
    
    @objc private func mapMark(gesture: UIGestureRecognizer){
        
        let contentMapa = contentView.mapView
        
        // tratamento para capturar o gesto apenas quando ele inicia
        if gesture.state == UIGestureRecognizer.State.began {
            //pega o local onde foi clicado no mapa
            let selectedPoint = gesture.location(in: contentMapa)
            //converte o ponto clicado no mapa para coordenadas
            let coordinates = contentMapa.convert(selectedPoint, toCoordinateFrom: <#T##UIView?#>)
        }
    }
    
}
