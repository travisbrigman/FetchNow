//
//  Favorites.swift
//  FetchNow
//
//  Created by Travis Brigman on 7/23/21.
//

import Foundation

class Favorites {
    private var favoriteEvents: Set<Int>
    
    private let saveKey = "Favorites"
    
    static let shared = Favorites()
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
                self.favoriteEvents = decoded
                return
            }
        }
        
        self.favoriteEvents = []
    }
    
    func contains(_ event: Event) -> Bool {
        decode()
        return favoriteEvents.contains(event.id)
    }
    
    func add(_ event: Event) {
        favoriteEvents.insert(event.id)
        save()
    }
    
    func remove(_ event: Event) {
        favoriteEvents.remove(event.id)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(favoriteEvents) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    
    func decode() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
                self.favoriteEvents = decoded
                return
            }
        }
    }
}
