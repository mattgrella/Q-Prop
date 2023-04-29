//
//  ContentView.swift
//  Q-Prop
//
//  Created by Matthew Grella on 4/24/23.
//

import SwiftUI
import Combine

@MainActor
struct Main: View {
    @EnvironmentObject var oddsFetcher: GameLinesModel
    @State private var selectedOption: Games?
    @State private var selectedGame: Games

    var body: some View {
        let array = oddsFetcher.gamesArray
        NavigationView {
            VStack {
                Spacer()
                
                HStack {
                    Text("Find Your Best Bet!!!")
                        .font(Font.custom("Supreme", size: 35))
                        .bold()
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Image(systemName: "basketball")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.orange)
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                Text("💸 💸 💸 💸 💸")
                    .font(.custom("Supreme", size: 50))
                
                
            
                Image("Q-Prop")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.orange)
                
                
                    
                Text("💸 💸 💸 💸 💸")
                    .font(.custom("Supreme", size: 50))
                
                Spacer()

                Text("Today's Games")
                    .font(Font.custom("Supreme", size: 30))
                    .bold()
                    .foregroundColor(.teal)
                
               Spacer()

                HStack {
                    Picker(selection: $selectedGame, label: Text("Select Game")) {
                        Text("N/A")
                        ForEach(array, id: \.id) { game in
                            Text("\(game.home_team) vs. \(game.away_team)").tag(game)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedGame) { newValue in
                        selectedGame.id = newValue.id
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: GameLinesView(game: selectedGame)) {
                        Text("Lines")
                    }
                    .disabled(selectedGame == nil)
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            .navigationTitle("Q-Prop")
            .onReceive(Just(selectedOption)) { value in
                if let game = value {
                    selectedGame = game
                }
            }
        }
        .task {
            await oddsFetcher.getData()
        }
    }

    init() {
        _selectedGame = State(initialValue: Games(id: "", sport_key: "", sport_title: "", commence_time: "", home_team: "", away_team: "", bookmakers: []))
    }
}


struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
            .environmentObject(GameLinesModel())
    }
}
