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
 
 id
 quote
 author
 series
 
 */

struct Character : Hashable, Decodable{
    var id:Int
    var name:String
    var nickname:String
    var birthday:String
    var img:String
    var portrayed:String
    var status:String
    var occupation:[String]
    
    enum CodingKeys: String, CodingKey{
        case name, nickname, birthday, img, portrayed, status, occupation
        case id = "char_id"
    }
}

struct Quote: Decodable{
    var quote:String
    var author:String
    var series:String
}

struct MultiFoundQuote: Decodable{ //This struct is used for when a single author has multiple quotes
    var quote:[String]
    var author:String
    var series:String
}

var currentCharacter:Character = Character(id: 0, name: "", nickname: "", birthday: "", img: "", portrayed: "", status: "", occupation: [])
var currentCharacterQuotes:Quote = Quote(quote: "Unkown Quote", author: "Unkown Author", series: "Unkown Series")

class DataHandler : ObservableObject
{
    @Published var characters: [Character] = []   
    @Published var quotes : [Quote] = []
    
    var urlSession = URLSession.shared
    var urlRequestChar = URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/characters")!)
    var urlRequestQuote = URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/quotes")!)
    
            
    func fetch(){
        let task = urlSession.dataTask(with: urlRequestChar){ data, response, error in
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
    
    func fetchQuotes(){
        print("Finding quote")
        let taskQ = urlSession.dataTask(with: urlRequestQuote){ data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do{
                guard let parsedData = try? jsonDecoder.decode([Quote].self, from: data)
                else {
                    print("Parsing Failed")
                    return
                }
                
                DispatchQueue.main.async {
                    self.quotes = parsedData
                    print("updated quote data")
                }
            }
            
        }
        
        taskQ.resume()
         //print("Age: \(calcAge(birthday: "10/17/1997"))") // testing to ensure calculations work
        
    }
    
    func findQuote(author:String) -> Quote{
        //TODO: Change FindQuotes to find all quotes from an author not just the final one
        var foundQuote:Quote = Quote(quote: "", author: "", series: "")
        for quote in quotes {
            if(quote.author == author)
            {
                foundQuote.author = quote.author
                foundQuote.quote = quote.quote
                foundQuote.series = quote.series
            }
        }
        return foundQuote
    }
    
    func calcAge(birthday:String) -> Int{
        
        let birthdayClean = birthday
        //birthdayClean.replacingOccurrences(of: "-", with: "")
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
