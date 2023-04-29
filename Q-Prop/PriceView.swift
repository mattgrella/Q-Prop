//
//  PriceView.swift
//  Q-Prop
//
//  Created by Matthew Grella on 4/28/23.
//

import SwiftUI
import AVFAudio

@MainActor
struct PriceView: View {
    
    @EnvironmentObject var oddsFetcher: GameLinesModel
    @State var selectedGame: Games?
    @State var game: Games
    @State private var audioPlayer: AVAudioPlayer!
    @State private var prevNum = 6
    
    var body: some View {
        
        let songs = ["All I Do is Win", "We Are the Champions", "Mo Money Mo Problems", "I Believe", "Money in the Grave", "A lot"]
        
    
        let maxPrice = ((game.bookmakers.compactMap { bookmaker -> Double? in
            let firstOutcomePrice = bookmaker.markets.first?.outcomes.first?.price
            let lastOutcomePrice = bookmaker.markets.first?.outcomes.last?.price
            return [firstOutcomePrice, lastOutcomePrice].compactMap { $0 }.max()
        }.max() ?? 0.0) * 100) - 100
        
        let minPrice = (-100 / (1 - (game.bookmakers.compactMap { bookmaker -> Double? in
            let firstOutcomePrice = bookmaker.markets.first?.outcomes.first?.price
            let lastOutcomePrice = bookmaker.markets.first?.outcomes.last?.price
            return [firstOutcomePrice, lastOutcomePrice].compactMap { $0 }.min()
        }.max() ?? 0.0)))
        
        
        
        var bookmakerWithMaxPrice: String {
               if let bookmaker = game.bookmakers.first(where: {
                   $0.markets.contains(where: {
                       $0.outcomes.contains(where: {
                           $0.price == ((maxPrice + 100) / 100)
                       })
                   })
               }) {
                   return bookmaker.title
               }
               
               return "Unknown"
           }
        var bookmakerWithMinPrice: String {
               if let bookmaker = game.bookmakers.first(where: {
                   $0.markets.contains(where: {
                       $0.outcomes.contains(where: {
                           $0.price == (((-1*minPrice) - 100)/(-1 * minPrice))
                       })
                   })
               }) {
                   return bookmaker.title
               }
               
               return "Unknown"
           }
        
        var maxPriceTeamTitle: String {
                var maxPriceOutcome: Outcome?
                for bookmaker in game.bookmakers {
                    let outcomes = bookmaker.markets[0].outcomes
                    if let outcome = outcomes.first(where: { $0.price == ((maxPrice + 100) / 100) }) {
                        if let currentMaxPriceOutcome = maxPriceOutcome {
                            if outcome.price > currentMaxPriceOutcome.price {
                                maxPriceOutcome = outcome
                            }
                        } else {
                            maxPriceOutcome = outcome
                        }
                    }
                }
                return maxPriceOutcome?.name ?? "N/A"
            }
        
        var minPriceTeamTitle: String {
                var minPriceOutcome: Outcome?
                for bookmaker in game.bookmakers {
                    let outcomes = bookmaker.markets[0].outcomes
                    if let outcome = outcomes.first(where: { $0.price == (((-1 * minPrice) - 100)/(-1 * minPrice)) }) {
                        if let currentMinPriceOutcome = minPriceOutcome {
                            if outcome.price < currentMinPriceOutcome.price {
                                minPriceOutcome = outcome
                            }
                        } else {
                            minPriceOutcome = outcome
                        }
                    }
                }
                return minPriceOutcome?.name ?? "N/A"
            }
        
        VStack {
            Text("Sites With The Best Value!")
                .font(Font.custom("Supreme", size: 50))
                .bold()
                .foregroundColor(.teal)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("Best Underdog Value: +\(String(format: "%.0f",maxPrice))")
                .font(Font.custom("Supreme", size: 25))
                .bold()
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .bold()
            HStack {
                Text("Book: \(bookmakerWithMaxPrice)")
                    .frame(alignment: .leading)
                    .font(Font.custom("Supreme", size: 25))
                    .bold()
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                Image(bookmakerWithMaxPrice)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            
            HStack {
                Text("Team: \(maxPriceTeamTitle)")
                    .frame(alignment: .leading)
                    .font(Font.custom("Supreme", size: 25))
                    .bold()
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                Image(maxPriceTeamTitle)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            
            
          
            Text("Best Favorite Value: -\(String(format: "%.0f", minPrice))")
                .font(Font.custom("Supreme", size: 25))
                .bold()
                .foregroundColor(.teal)
                .multilineTextAlignment(.center)
                .bold()
            
            HStack {
                Text("Book: \(bookmakerWithMinPrice)")
                    .frame(alignment: .leading)
                    .font(Font.custom("Supreme", size: 25))
                    .bold()
                    .foregroundColor(.teal)
                    .multilineTextAlignment(.center)
                Image(bookmakerWithMinPrice)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            
            HStack {
                Text("Team: \(minPriceTeamTitle)")
                    .frame(alignment: .leading)
                    .font(Font.custom("Supreme", size: 25))
                    .bold()
                    .foregroundColor(.teal)
                    .multilineTextAlignment(.center)
                Image(minPriceTeamTitle)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
            }
            
            Spacer()
            
            Button("Celebrate!") {
                playSound(soundName: songs[randomNum()])
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .cornerRadius(5)
            
    
            
            
            
        }
        .navigationTitle("Price Range")
        
    }
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("ERROR: \(error.localizedDescription) creating audio player.")
        }
    }
    
    func randomNum() -> Int {
        var random = Int.random(in: 0...5)
        
        while (random == prevNum) {
            random = Int.random(in: 0...5)
        }
        prevNum = random
        return random
    }
}

struct PriceView_Previews: PreviewProvider {
    static let selectedGame = Games(id: "1", sport_key: "basketball_nba", sport_title: "Basketball NBA", commence_time: "2023-04-28T01:00:00Z", home_team: "Los Angeles Lakers", away_team: "Celtics", bookmakers: [
            Bookmaker(key: "betway", title: "BetWay", last_update: "2023-04-27T16:47:28Z", markets: [
                Market(key: "h2h", last_update: "2023-04-27T16:47:28Z", outcomes: [
                    Outcome(name: "Los Angeles Lakers", price: 1.75),
                    Outcome(name: "Celtics", price: 2.1)
                ])
            ]), Bookmaker(key: "Fan Duel", title: "FanDuel", last_update: "2023-04-27T19:28:57Z", markets: [
                Market(key: "h2h", last_update: "2023-04-27T19:28:57Z", outcomes: [
                    Outcome(name: "Atlanta Hawks", price: 3.4),
                    Outcome(name: "Boston Celtics", price: 1.35)
                ])
            ])
        ])
    static var previews: some View {
       PriceView(game: selectedGame)
    }
}
