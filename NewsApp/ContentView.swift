//
//  ContentView.swift
//  NewsApp
//
//  Created by 0rientd on 21/02/21.
//

import SwiftUI
import Foundation

let url = URL(string: "https://newsapi.org/v2/top-headlines?country=br&apiKey=295414512a19411a93582f0f697449e9")


struct ContentView: View {
    
    @State private var stateArtigosArray = [String]()
    @State private var stateArtigosImagensArray = [String]()
    @State private var stateTesteArrayUIImage = [UIImage]()
    @State private var indexParaArtigos = 0
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        let conteudoJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
        var artigosArray = [String]()
        var artigosImagensArray = [String]()
        
        if let dicionario = conteudoJSON as? [String: Any] {
            if let conteudoArtigos = dicionario["articles"] as? [[String: Any]] {
                for conteudo in conteudoArtigos {
                    if String(describing: conteudo["urlToImage"]!) != "<null>" {
                        artigosArray.append(String(describing: conteudo["title"]!))
                        artigosImagensArray.append(String(describing: conteudo["urlToImage"]!))
                    }
                }
                
                self.stateArtigosArray = artigosArray
                self.stateArtigosImagensArray = artigosImagensArray
                
                getImagesFromUrl()
                
            } else {
                print("Erro aqui => 2")
        
            }
        } else {
            print("Erro aqui => 1")
        
        }
    }
        
    func getImagesFromUrl() {
        print("Inicializando download das imagens....")
        
        var imageToReturn = [UIImage]()
        self.stateTesteArrayUIImage = [UIImage]()
        
        for url in self.stateArtigosImagensArray {
            print("Fazendo request para a URL => \(url)")
            if let getURL = URL(string: url) {
                if let data = try? Data(contentsOf: getURL) {
                    if let image = UIImage(data: data) {
                        imageToReturn.append(image)
                    }
                }
            }
            
            print("Do self => \(self.stateTesteArrayUIImage.count)")
            print("Da Variavel Global => \(imageToReturn.count)")
            self.stateTesteArrayUIImage = imageToReturn
        }
        
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("NewsApp")
                    .font(.largeTitle)
                    .bold()
                
                Text("by 0rientd")
                    .font(.system(size: 13))
                    .padding(.bottom, 50)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 20.0)
                    .foregroundColor(.red)
                    .shadow(radius: 10)
                    .frame(width: 170, height: 50, alignment: .center)
                    .overlay(
                        Button("Atualizar Notícias") {
                            let config = URLSessionConfiguration.default
                            config.waitsForConnectivity = true
                            config.timeoutIntervalForResource = 60
                            let session = URLSession(configuration: config)
                            let task = session.dataTask(with: url!, completionHandler: handle(data:response:error:))
                            task.resume()
                            
                            self.stateArtigosArray = [String]()
                            self.stateArtigosImagensArray = [String]()
                            
                        }.accentColor(.black)
                    )
                
                Spacer()
                
                ScrollView() {
                    if self.stateTesteArrayUIImage.count == self.stateArtigosArray.count {
                        ZStack {
                            VStack {
                                ForEach(stateArtigosArray, id: \.self) { titulo in
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .frame(width: 350, height: 160, alignment: .center)
                                            .foregroundColor(.blue)
                                            .shadow(radius: 5)
                                            .shadow(radius: 5)
                                            .padding(.top, 15)
                                            .overlay(
                                                Text(titulo)
                                                    .frame(width: 235, height: 170, alignment: .leading)
                                                    .padding(.trailing, 105)
                                                    .padding(.leading, 10)
                                            )
                                }
                            }
                            
                            VStack {
                                ForEach (stateTesteArrayUIImage, id: \.self) {imagem in
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .frame(width: 350, height: 160, alignment: .center)
                                        .opacity(0.0)
                                        .padding(.top, 15)
                                        .overlay(
                                            Image(uiImage: imagem)
                                                .resizable()
                                                .cornerRadius(10)
                                                .frame(width: 100, height: 100, alignment: .center)
                                                .padding(.leading, 235)
                                        )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
