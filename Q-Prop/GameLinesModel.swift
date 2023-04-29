//
//  GameLinesModel.swift
//  Q-Prop
//
//  Created by Matthew Grella on 4/24/23.
//

 
import Foundation
import SwiftUI
import Combine

@MainActor
class GameLinesModel: ObservableObject {
//    @Published var games = [Games]()
//
//       func fetchGames() {
//           let url = URL(string: "https://api.the-odds-api.com/v4/sports/basketball_nba/odds/?apiKey=91dd4dc30202db85b7f40efb2049ff5d&regions=us")!
//           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//               guard let data = data else { return }
//               do {
//                   let decoder = JSONDecoder()
//                   decoder.keyDecodingStrategy = .convertFromSnakeCase
//                   let result = try decoder.decode(Result.self, from: data)
//                   DispatchQueue.main.async { [weak self] in
//                       self?.games = result.result
//                   }
//               } catch let error {
//                   print(error)
//               }
//           }.resume()
//       }
    
 //    @Published var games : [Result] = []
//
//       func fetchGames() {
//           let apiKey = "91dd4dc30202db85b7f40efb2049ff5d"
//           let urlString = "https://api.the-odds-api.com/v4/sports/basketball_nba/odds/?apiKey=\(apiKey)&regions=us"
//           guard let url = URL(string: urlString) else {
//               return
//           }
//           URLSession.shared.dataTask(with: url) { data, response, error in
//               guard let data = data, error == nil else {
//                   return
//               }
//               do {
//                   let result = try JSONDecoder().decode([Result].self, from: data)
//                   DispatchQueue.main.async {
//                       self.games = result
//                   }
//               } catch {
//                   print(error)
//               }
//           }.resume()
//       }
    
    @Published var urlString = "https://api.the-odds-api.com/v4/sports/basketball_nba/odds/?apiKey=91dd4dc30202db85b7f40efb2049ff5d&regions=us"
    @Published var gamesArray: [Games] = []
    

    func getData() async {
        print("We are accesing the url \(urlString)")

        guard let url = URL(string: urlString) else {
            print("ERROR: COuld not create a URL from \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode([Games].self, from: data) else {
                print("JSON ERROR: Could not decode returned data.")
                return
            }
            self.gamesArray.append(contentsOf: returned)
        } catch {
            print("ERROR: Could not use URL at \(urlString)")
        }
    }
}
