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
    var viagens: [Dictionary<String, String>] = []
    
    func salvarViagem(viagem: Dictionary<String, String>){
        
        viagens = listarViagens()
        
        viagens.append(viagem)
        UserDefaults.standard.set(viagens, forKey: chave)
        UserDefaults.standard.synchronize()
    }
    
    func listarViagens() -> [Dictionary<String, String>]{
        if let dados = UserDefaults.standard.object(forKey: chave) {
            return dados as? [Dictionary<String, String>] ?? []
        } else {
            return []
        }
    }
    
    func deletarViagem(index: Int){
        viagens = listarViagens()
        
        viagens.remove(at: index)
        UserDefaults.standard.set(viagens, forKey: chave)
        UserDefaults.standard.synchronize()
    }
}
