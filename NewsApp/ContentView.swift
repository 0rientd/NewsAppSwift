//
//  ContentView.swift
//  NewsApp
//
//  Created by 0rientd on 21/02/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var testeTexto = ""
    @State private var stateArtigosArray = [String]()
    
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=br&apiKey=295414512a19411a93582f0f697449e9")
    
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
                        Button("Atualziar Notícias") {
                            func handle(data: Data?, response: URLResponse?, error: Error?) {
                                let content = try? JSONSerialization.jsonObject(with: data!, options: [])
                                var artigosArray = [String]()
                                
                                if let dictionary = content as? [String: Any] {
                                    if let teste = dictionary["articles"] as? [[String: Any]] {
                                        for conteudo in teste {
                                            artigosArray.append(String(describing: conteudo["content"]!))
                                            
                                        }
                                        
                                        artigosArray = artigosArray.filter() {
                                            $0 != "<null>"
                                        }
                                        self.stateArtigosArray = artigosArray
                                        artigosArray = [String]()
                                        
                                    } else {
                                        print("Erro aqui => 2")
                                
                                    }
                                
                                } else {
                                    print("Erro aqui => 1")
                                
                                }
                            }
                            
                            let config = URLSessionConfiguration.default
                            config.waitsForConnectivity = true
                            config.timeoutIntervalForResource = 60
                            let session = URLSession(configuration: config)
                            let task = session.dataTask(with: url!, completionHandler: handle(data:response:error:))
                            task.resume()
                            
                            self.stateArtigosArray = [String]()
                            
                        }.accentColor(.black)
                    )
                
                Spacer()
                
                ScrollView() {
                    if stateArtigosArray.count > 1 {
                        VStack {
                            ForEach(0..<stateArtigosArray.count) { index in
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(width: 350, height: 200, alignment: .center)
                                    .foregroundColor(.blue)
                                    .shadow(radius: 5)
                                    .shadow(radius: 5)
                                    .padding(.top, 15)
                                    .overlay(
                                        Text(String(describing: self.stateArtigosArray[index]))
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 5)
                                            .padding(.leading, 5)
                                            .padding(.trailing, 5)
                                    )
                            }
                        } .frame(maxWidth: .infinity, maxHeight: .infinity)
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
