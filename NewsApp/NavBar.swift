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
                    Button("Assunto") {
                        self.estaMostrandoTelaAssunto.toggle()
                    }
                    .accentColor(.black)
                )
                .sheet(isPresented: $estaMostrandoTelaAssunto) {
                    assuntoConfigView(isPresented: $estaMostrandoTelaAssunto)
                }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.blue)
                .shadow(radius: 10)
                .frame(width: 100, height: 30, alignment: .center)
                .overlay(
                    Button("Palavra") {

                    }
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
        Text("Aqui você pode selecionar o país que deseja ver as notícias")
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
        
        Divider()
        
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

struct assuntoConfigView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Text("Aqui você pode selecionar a categoria que deseja ver as notícias")
            .multilineTextAlignment(.center)
            .padding(.top, 50)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .font(.title2)
        
        ScrollView {
            HStack {
                VStack {
                    assunto(imagemAssunto: Image(uiImage: #imageLiteral(resourceName: "Business-AssuntoView")), assunto: "Negócios", corDeFundo: .gray, opacidade: 0.5)
                        .padding(.bottom, 15)
                    
                    assunto(imagemAssunto: Image(uiImage: #imageLiteral(resourceName: "Health-AssuntoView")), assunto: "Saúde", corDeFundo: .pink, opacidade: 0.3)
                        .padding(.bottom, 15)

                    assunto(imagemAssunto: Image(uiImage: #imageLiteral(resourceName: "Entertainment-AssuntoView")), assunto: "Entretenimento", corDeFundo: .orange, opacidade: 0.2)
                    
                }
                
                VStack {
                    assunto(imagemAssunto: Image(uiImage: #imageLiteral(resourceName: "Sports-AssuntoView")), assunto: "Esporte", corDeFundo: .green, opacidade: 0.2)
                        .padding(.top, 125)
                        .padding(.bottom, 15)
                                    
                    assunto(imagemAssunto: Image(uiImage: #imageLiteral(resourceName: "Sicence-AssuntoView")), assunto: "Ciência", corDeFundo: .blue, opacidade: 0.2)
                        .padding(.bottom,15)

                    assunto(imagemAssunto: Image(uiImage: #imageLiteral(resourceName: "Technology-AssuntoView")), assunto: "Tecnologia", corDeFundo: .green, opacidade: 0.4)
                    
                }
                .padding(.leading, 25)
                
            } .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        Divider()
        
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.blue)
            .frame(width: 100, height: 35, alignment: .center)
            .overlay(
                Button("Confirmar") {
                    isPresented = false
                }
                .accentColor(.black)
            )
            .padding(.bottom, 5)
            .padding(.top, 10)
    }
}

struct assunto: View {
    var imagemAssunto: Image
    var assunto: String
    var corDeFundo: Color
    var opacidade: Double
    
    var body: some View {
        imagemAssunto
            .resizable()
            .frame(width: 150, height: 250, alignment: .center)
            .cornerRadius(25.0)
            .overlay(
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 150, height: 250, alignment: .center)
                    .foregroundColor(corDeFundo)
                    .opacity(opacidade)
                    .overlay(
                        Text(assunto)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 200)
                            .font(.title3)
                    )
            )
    }
    
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
