//
//  ContentView.swift
//  NewsApp
//
//  Created by 0rientd on 21/02/21.
//

import SwiftUI
import Foundation

let url = URL(string: "https://newsapi.org/v2/top-headlines?country=br&apiKey=295414512a19411a93582f0f697449e9")
var imageToReturn = [UIImage]()

struct ContentView: View {
    
    @State private var stateArtigosArray = [String]()
    @State private var stateArtigosImagensArray = [String]()
    @State private var stateTesteArrayUIImage = [UIImage]()
    @State private var estaCarregandoNoticias = true
    
    @State private var widthFrameCarregamentoNoticias = CGFloat(50)
    @State private var heightFrameCarregamentoNoticias = CGFloat(50)
    
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
        
        imageToReturn = [UIImage]()
        self.stateTesteArrayUIImage = [UIImage]()
        
        for url in self.stateArtigosImagensArray {
            if let getURL = URL(string: url) {
                do {
                    if let data = try Optional(Data(contentsOf: getURL)) {
                        if let image = UIImage(data: data) {
                            imageToReturn.append(image)
                        }
                    }
                } catch {
                    print("=====================")
                    print(error.localizedDescription)
                    imageToReturn.append(UIImage(imageLiteralResourceName: "Erro - Sem Imagem"))
                }
            }
            
            print("Do self => \(self.stateTesteArrayUIImage.count)")
            print("Da Variavel Global => \(imageToReturn.count)")
            self.stateTesteArrayUIImage = imageToReturn
            
            if self.stateTesteArrayUIImage.count == self.stateArtigosArray.count {
                self.estaCarregandoNoticias = false
            }
        }
        
        print("print do self.stateTesteArrayUIImage.count => \(self.stateTesteArrayUIImage.count)")
        print("print do self.stateArtigosArray.count => \(self.stateArtigosArray.count)")
        print("print do imageToReturn.count => \(imageToReturn.count)")
        
    }
    
    func requestNews() {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 60
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url!, completionHandler: handle(data:response:error:))
        task.resume()
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("NewsApp")
                    .font(.largeTitle)
                    .bold()
                    .onAppear(perform: requestNews)
                
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
                            requestNews()
                            
                            self.estaCarregandoNoticias = true
                            
                            self.stateArtigosArray = [String]()
                            self.stateArtigosImagensArray = [String]()
                            
                        }
                        .accentColor(.black)
                    )
                
                Spacer()
                
                ScrollView() {
                    if self.estaCarregandoNoticias == true {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.blue)
                            .frame(width: self.widthFrameCarregamentoNoticias, height: self.heightFrameCarregamentoNoticias, alignment: .center)
                            .padding(.top, 150)
                            .overlay(
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .overlay(
                                        Text("Carregando Notícias")
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 60)
                                            .frame(width: 150, height: 150, alignment: .center)
                                    )
                                    .padding(.top, 135)
                            )
                            .animation(
                                        Animation.easeIn(duration: 1)
                                    )
                            .onAppear {
                                self.widthFrameCarregamentoNoticias += 100
                                self.heightFrameCarregamentoNoticias += 100
                            }
                    }
                    
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
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 200, height: 150, alignment: .leading)
                                                    .padding(.trailing, 110)
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
                                                .padding(.leading, 210)
                                        )
                                }
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
