//
//  URLImage.swift
//  BreakingBad_API_Program
//
//  Created by IACD-011 on 2022/06/23.
//

import Foundation
import SwiftUI

struct URLImage: View{
    
    let urlString:String
    
    @State var data: Data?
    
    var body: some View{
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode : .fill)
                .frame(width: 100, height: 100)
                .background(Color.gray)
        } else
        {
            Image(systemName: "Photo")
                .resizable()
                .aspectRatio(contentMode : .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchImage()
                }
        }
    }
    
    private func fetchImage(){
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data,
            _, _ in self.data = data
        }
        task.resume()
    }
    
}
