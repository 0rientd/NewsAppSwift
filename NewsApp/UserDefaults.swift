//
//  UserDefaults.swift
//  NewsApp
//
//  Created by 0rientd on 06/03/21.
//

import Foundation
import SwiftUI

func saveCountryNews(country: String) {
    UserDefaults.standard.set(country, forKey: "countrySaved")
    print("País \(country) salvo com sucesso")
}

func loadSavedCountryNews() -> String {
    let savedCountry = UserDefaults.standard.string(forKey: "countrySaved")
    if savedCountry == nil {
        print("Sem páis padrão... Retornando US")
        return "us"
    }
    
    print("Carregado o país \(savedCountry!)")
    return savedCountry!
}

func saveCategoryNews(salvo: Bool, categoria: String) {
    UserDefaults.standard.set(salvo, forKey: String("categoria\(categoria)"))
    print("Categoria \(categoria) salva como \(String(salvo))")
}

func loadSavedCategory(categoria: String) -> Color {
    let savedCategory = UserDefaults.standard.string(forKey: "categoria\(categoria)")
    print("Categoria \(categoria) retornou \(String(savedCategory ?? "nil"))")
    
    if savedCategory == "1" {
        categoriaSelecionada = "&category=\(categoria.lowercased())"
        return Color.green
    } else {
        return Color.gray
    }
}

func loadCategoryOnAppear() {
    let categorias = ["Business", "Health", "Entertenaiment", "Sports", "Science", "Technology"]
    
    for categoria in categorias {
        _ = loadSavedCategory(categoria: categoria)
    }
}
