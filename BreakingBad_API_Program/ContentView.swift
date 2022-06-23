//
//  ContentView.swift
//  BreakingBad_API_Program
//
//  Created by IACD-011 on 2022/06/23.
//

import SwiftUI

struct ContentView: View {
   @StateObject var dataHandler = DataHandler()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(dataHandler.characters, id: \.self) { Character in
                    HStack{
                        URLImage(urlString: Character.img)
                        VStack {
                            Text("Name: \(Character.name)").bold()
                            Text("Nickname: \(Character.nickname)").font(.subheadline)
                        }
                        
                    }
                }
            }
            .navigationTitle("Breaking Bad")
            .onAppear{
                dataHandler.fetch()
            }
            Text("Test Text")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
