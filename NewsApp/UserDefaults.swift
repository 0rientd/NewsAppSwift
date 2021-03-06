//
//  UserDefaults.swift
//  NewsApp
//
//  Created by 0rientd on 06/03/21.
//

import Foundation

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
