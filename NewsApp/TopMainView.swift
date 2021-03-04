//
//  TopMainView.swift
//  NewsApp
//
//  Created by 0rientd on 03/03/21.
//

import SwiftUI

struct TopMainView: View {
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
                            requestNews()
                            
                            self.estaCarregandoNoticias = true
                            
                            self.stateArtigosArray = [String]()
                            self.stateUrlArtigosArray = [String]()
                            heightFrameCarregamentoNoticias = CGFloat(50)
                            widthFrameCarregamentoNoticias = CGFloat(50)
                            
                        }
                        .accentColor(.black)
                    )
            }
        }
    }
}

struct TopMainView_Previews: PreviewProvider {
    static var previews: some View {
        TopMainView()
    }
}
