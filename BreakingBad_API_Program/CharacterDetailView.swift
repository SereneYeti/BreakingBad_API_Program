//
//  CharacterDetailView.swift
//  BreakingBad_API_Program
//
//  Created by IACD-011 on 2022/06/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var name:String = "Character Details"
    
    var body: some View {
        NavigationView {
            Text("Character Details")
                .navigationTitle("\(name)")
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
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
