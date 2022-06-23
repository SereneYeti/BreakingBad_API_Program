//
//  DataHandler.swift
//  BreakingBad_API_Program
//
//  Created by IACD-011 on 2022/06/23.
//

import Foundation
import SwiftUI

/*
 Your summary list should contain:
- name
- nickname
- Age
- Avatar Image

When selecting a character, a detail view should contain:
- Name
- Occupation
- Actor
- Are they deceased

Any info from another API:
- quotes
- deaths
 */

struct Character : Hashable, Decodable{
    var id:Int
    var name:String
    var nickname:String
    var birthday:String
    var img:String
    var portrayed:String
    var status:String
    
    enum CodingKeys: String, CodingKey{
        case name, nickname, birthday, img, portrayed, status
        case id = "char_id"
    }
}


class DataHandler : ObservableObject
{
    @Published var characters: [Character] = []
    
    var urlSession = URLSession.shared
    var urlRequest = URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/characters")!)
            
    func fetch(){
        let task = urlSession.dataTask(with: urlRequest){ data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do{
                guard let parsedData = try? jsonDecoder.decode([Character].self, from: data)
                else {
                    print("Parsing Failed")
                    return
                }
                
                DispatchQueue.main.async {
                    self.characters = parsedData
                    print("updated characters data")
                    print("Birthday: \(self.characters[0].birthday)")
                }                
            }
            
        }
        
        task.resume()
         //print("Age: \(calcAge(birthday: "10/17/1997"))") // testing to ensure calculations work
        
    }
    
    func calcAge(birthday:String) -> Int{
        
        let birthdayClean = birthday
        birthdayClean.replacingOccurrences(of: "-", with: "")
        var age:Int = -1
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let birthdayDate = dateFormatter.date(from: birthdayClean) else {
            print("Error")
            return -1
        }
        let calendar = Calendar.current
        let calcAge = calendar.dateComponents([.year], from: birthdayDate, to: now)
        age = calcAge.year!
        return age
    }
}
