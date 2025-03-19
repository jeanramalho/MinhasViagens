//
//  Viagens.swift
//  MinhasViagens
//
//  Created by Jean Ramalho on 19/03/25.
//
import Foundation
import UIKit

class ViagensModel {
    
    let chave: String = "viagens"
    var viagens: [String] = []
    
    func salvarViagem(viagem: String){
        
        viagens = listarViagens()
        
        viagens.append(viagem)
        UserDefaults.standard.set(viagens, forKey: chave)
    }
    
    func listarViagens() -> [String]{
        if let dados = UserDefaults.standard.object(forKey: chave) {
            return dados as? [String] ?? []
        } else {
            return []
        }
    }
    
    func deletarViagem(index: Int){
        viagens = listarViagens()
        
        viagens.remove(at: index)
        UserDefaults.standard.set(viagens, forKey: chave)
    }
}
