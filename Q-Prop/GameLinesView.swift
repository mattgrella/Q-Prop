//
//  GameLinesView.swift
//  Q-Prop
//
//  Created by Matthew Grella on 4/26/23.
//

import SwiftUI


@MainActor
struct GameLinesView: View {
    
    @EnvironmentObject var oddsFetcher: GameLinesModel
    @State var selectedGame: Games?
    @State var game: Games
    
    var body: some View {
//        List(game.bookmakers, id: \.self) { bookmaker in
//            Text(bookmaker.title)
//            ForEach(bookmaker.markets, id: \.self) { market in
//                ForEach(market.outcomes, id: \.self) { outcome in
//                    HStack {
//                        Text("\(outcome.price)")
//                        Spacer()
//                        Text(String(format: "%.2f", outcome.price))
//                    }
//                }
//            }
//            .navigationTitle("\(game.home_team) vs. \(game.away_team) Lines")
//        }
                    VStack {
                        Text("\(game.home_team) vs. \(game.away_team)")
                        Spacer()
        
                        List {
                            ForEach(game.bookmakers, id: \.self) { bookmaker in
                                HStack {
                                    Image(bookmaker.title)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .cornerRadius(5)
                                    Text("\(bookmaker.title): \(bookmaker.markets[0].outcomes[0].name) \(String(format: "%.2f", bookmaker.markets[0].outcomes[0].price))")
                                }
        
                                HStack {
                                    Image(bookmaker.title)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                        .cornerRadius(5)
                                    Text("\(bookmaker.title): \(bookmaker.markets[0].outcomes[1].name) \(String(format: "%.2f", bookmaker.markets[0].outcomes[1].price))")
                                }
        
                            }
        
                        }
        
                        NavigationLink(destination: PriceView(game: game)) {
                            Text("Show Best Bets")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }
                        .navigationTitle("\(game.home_team) vs. \(game.away_team)")
        
                    }
        
                    .navigationTitle("\(game.home_team) vs. \(game.away_team)")
        
            }
    }

    struct GameLinesView_Previews: PreviewProvider {
        static let selectedGame = Games(id: "1", sport_key: "basketball_nba", sport_title: "Basketball NBA", commence_time: "2023-04-28T01:00:00Z", home_team: "Lakers", away_team: "Celtics", bookmakers: [
            Bookmaker(key: "betway", title: "BetWay", last_update: "2023-04-27T16:47:28Z", markets: [
                Market(key: "h2h", last_update: "2023-04-27T16:47:28Z", outcomes: [
                    Outcome(name: "Lakers", price: 1.75),
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
            GameLinesView(game: selectedGame).environmentObject(GameLinesModel())
        }
    }

