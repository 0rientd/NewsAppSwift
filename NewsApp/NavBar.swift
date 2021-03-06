//
//  NavBar.swift
//  NewsApp
//
//  Created by 0rientd on 03/03/21.
//

import SwiftUI

var paisSelecionado = loadSavedCountryNews()

struct NavBar: View {
    @State private var estaMostrandoTelaPais = false
    @State private var estaMostrandoTelaAssunto = false
    
    var body: some View {
        HStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.blue)
                .shadow(radius: 10)
                .frame(width: 100, height: 30, alignment: .center)
                .overlay(
                    Button("País") {
                        self.estaMostrandoTelaPais.toggle()
                    }
                    .accentColor(.black)
                )
                .sheet(isPresented: $estaMostrandoTelaPais) {
                    PaisConfigView(isPresented: $estaMostrandoTelaPais)
                }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.blue)
                .shadow(radius: 10)
                .frame(width: 100, height: 30, alignment: .center)
                .overlay(
                    Text("Assunto")
                        .accentColor(.black)
                )
            
            Spacer()
        }
    }
}

struct PaisConfigView: View {
    @Binding var isPresented: Bool
    @State private var paisPadrao = loadSavedCountryNews()
    
    let paises = ["ae", "ar","at","au","be","bg","br", "ca", "ch", "cn","co", "cu","cz","de","eg","fr","gb","gr","hk","hu","id","ie","il","in","it","jp","kr","lt","lv","ma","mx","my","ng","nl","no","nz","ph","pl","pt","ro","rs","ru","sa","se","sg","si","sk","th","tr","tw","ua","us","ve","za"]
    
    var body: some View {
        Text("Aqui você pode selecionar o país que deseja ver as notícias.")
            .multilineTextAlignment(.center)
            .padding(.top, 50)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .font(.title2)
        
        Form {
            Section {
                Picker("País selecionado", selection: $paisPadrao) {
                    ForEach(paises, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(InlinePickerStyle())
            }
        }
        
        Spacer()
        
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.blue)
            .frame(width: 100, height: 35, alignment: .center)
            .overlay(
                Button("Confirmar") {
                    paisSelecionado = paisPadrao
                    isPresented = false
                    
                    saveCountryNews(country: self.paisPadrao)
                }
                .accentColor(.black)
            )
            .padding(.bottom, 5)
            .padding(.top, 10)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
