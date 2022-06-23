//
//  CharacterDetailView.swift
//  BreakingBad_API_Program
//
//  Created by IACD-011 on 2022/06/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack{                
                Text("Name: \(currentCharacter.name )").font(.title).padding()
                URLImage(urlString: currentCharacter.img).padding()
                Text("Actor: \(currentCharacter.portrayed )").font(.body).fontWeight(.bold).padding()
                Text("Current Status: \(currentCharacter.status)")
                    .font(.body).fontWeight(.bold).padding()
                Divider()
                Text("Quote by \(currentCharacterQuotes.author) ").font(.title).padding()                
                Text("Quote: \(currentCharacterQuotes.quote)").font(.body).font(.system(size: 48)).fontWeight(.bold).padding()
                Text("Quote from \(currentCharacterQuotes.series) ").font(.subheadline).padding()
                Divider()
                
            }   .navigationTitle("Character Details")
                .navigationBarItems(trailing: Button(action: {
                    dismiss()
                }, label: {
                    Text("Done").bold()
                }))
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
    }
}
