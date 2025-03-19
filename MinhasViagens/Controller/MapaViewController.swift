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
    private let viagensDataBase = ViagensModel()
    var viagem: Dictionary<String, String> = [:]
    
    var viagemLati: CLLocationDegrees?
    var viagemLongi: CLLocationDegrees?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        mapAddGesture()
        
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
    
    private func mapAddGesture(){
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
        var localCompleto = "Endereço não encontrado!"
        
        // tratamento para capturar o gesto apenas quando ele inicia
        if gesture.state == UIGestureRecognizer.State.began {
            
            //pega o local onde foi clicado no mapa
            let selectedPoint = gesture.location(in: contentMapa)
            //converte o ponto clicado no mapa para coordenadas
            let coordinates = contentMapa.convert(selectedPoint, toCoordinateFrom: contentMapa)
            //pega localizacao para recuperar o endereco do local selecionado
            let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            
            //Transforma localizacao em endereco
            CLGeocoder().reverseGeocodeLocation(location) { Local, erro in
                if erro == nil {
                    
                    if let localData = Local?.first {
                        if let localName = localData.name {
                            localCompleto = localName
                        } else {
                            if let endereco = localData.thoroughfare {
                                localCompleto = endereco
                            }
                        }
                    }
                    
                    self.addAnnotation(latiParametro: coordinates.latitude, longiParametro: coordinates.longitude, annotationTitle: localCompleto)
                 
                    self.viagem = ["local": localCompleto, "latitude": String(coordinates.latitude), "longitude": String(coordinates.longitude)]
                    
                    self.viagensDataBase.salvarViagem(viagem: self.viagem)
                } else {
                    print("Erro ao encontrar localização: \(String(describing: erro))")
                }
                
            }
            
        
            
            
        }
    }
    
    func addAnnotation(latiParametro: CLLocationDegrees?, longiParametro: CLLocationDegrees?, annotationTitle: String){
        //exibe a anotacao com os dados de endereço
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = latiParametro ?? 0
        annotation.coordinate.longitude = longiParametro ?? 0
        annotation.title = annotationTitle
        
        self.contentView.mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let mapa = contentView.mapView
        
        
        if (self.viagemLati != nil) && (self.viagemLongi != nil) {
            
            guard let latitude = self.viagemLati else {return}
            guard let longitude = self.viagemLongi else {return}
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(latitude, longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            mapa.setRegion(region, animated: true)
            
        } else {
            
            mapa.showsUserLocation = true
            
            guard let userLocation = locations.last else {return}
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            mapa.setRegion(region, animated: true)
        }
        
    }
    
}
