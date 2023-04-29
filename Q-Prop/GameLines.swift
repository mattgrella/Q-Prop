//
//  GameLines.swift
//  Q-Prop
//
//  Created by Matthew Grella on 4/27/23.
//

import Foundation

@MainActor

struct Result: Codable, Identifiable{
    let id : UUID
    let result : [Games]
}
struct Games: Codable, Identifiable, Hashable {
    var id = ""
    var sport_key = ""
    var sport_title = ""
    var commence_time = ""
    var home_team = ""
    var away_team = ""
    let bookmakers : [Bookmaker]
    
    static func == (lhs: Games, rhs: Games) -> Bool {
            return lhs.id == rhs.id
        }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(sport_key)
            hasher.combine(sport_title)
            hasher.combine(commence_time)
            hasher.combine(home_team)
            hasher.combine(away_team)
            hasher.combine(bookmakers)
        }
}

struct Bookmaker : Codable, Hashable{
    //let id : UUID
    var key = ""
    var title = ""
    var last_update = ""
    let markets : [Market]
    
    static func == (lhs: Bookmaker, rhs: Bookmaker) -> Bool {
            return lhs.key == rhs.key
        }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(key)
            hasher.combine(title)
            hasher.combine(last_update)
            hasher.combine(markets)
        }
}

struct Market : Codable, Hashable {
    var key = ""
    var last_update = ""
    let outcomes : [Outcome]
    
    static func == (lhs: Market, rhs: Market) -> Bool {
            return lhs.key == rhs.key
        }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(key)
            hasher.combine(outcomes)
            hasher.combine(last_update)
        }
}

struct Outcome : Codable, Hashable {
    var name = ""
    var price = 0.0
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(price)
        }
}
