//
//  ContentView.swift
//  BreakingBad_API_Program
//
//  Created by IACD-011 on 2022/06/23.
//

import SwiftUI

//TODO: Add Caching

struct ContentView: View {
   @StateObject var dataHandler = DataHandler()
   @State var showDetail:Bool = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(dataHandler.characters, id: \.self) { Character in
                    HStack{
                        URLImage(urlString: Character.img)
                        VStack {
                            Text("Name: \(Character.name)").bold()
                            Text("Nickname: \(Character.nickname)").font(.subheadline)
                            if(dataHandler.calcAge(birthday: Character.birthday) != -1){
                                Text("Age: \(dataHandler.calcAge(birthday: Character.birthday))").font(.body)
                                    .foregroundColor(Color.gray)
                            } else {
                                Text("Age: Unknown").font(.body).foregroundColor(Color.gray)
                            }
                            Button(action: {
                                print("Button Pressed")
                                currentCharacter = Character
                                currentCharacterQuotes = dataHandler.findQuote(author: currentCharacter.name)
                                self.showDetail.toggle()
                            }, label: {
                                Text("More Details")
                                    .padding(4)
                                    .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2)
                                        .background()
                                    )
                            }).sheet(isPresented: $showDetail){
                                CharacterDetailView()
                            }
                        }
                    }.padding()
                }
            }
            .navigationTitle("Breaking Bad")
            .onAppear{
                dataHandler.fetch()
                dataHandler.fetchQuotes()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        CharacterDetailView()
    }
}
