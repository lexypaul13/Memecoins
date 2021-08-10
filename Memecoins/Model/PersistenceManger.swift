//
//  PersistenceManger.swift
//  Memecoins
//
//  Created by Alex Paul on 8/9/21.
//

import Foundation

enum SaveActionType {
    case add
    case remove
}

enum SaveManger{
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
        static let mostRecent = "mostRecent"
    }
    
    static func updateWith(favorite: Memecoins, actionType: SaveActionType,key: String, completed: @escaping (ErroMessage?) -> Void) {
        collectFavorties { result in
            
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.duplicate)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                    
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.name == favorite.name }
                }
                
                completed(save(favorites: retrievedFavorites, key: key))
                
            case .failure(let error):
                completed(error)
            }
        }
        
    }
    
    static func collectFavorties(completed:@escaping(Result<[Memecoins], ErroMessage>)->Void){
        guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Memecoins].self, from: favoriteData)
            completed(.success(favorites))
        } catch{
            completed(.failure(.unableToComplete))
        }
        
    }
    
    static func collectRecent(completed:@escaping(Result<[Memecoins], ErroMessage>)->Void){
        guard let favoriteData = defaults.object(forKey: Keys.mostRecent) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Memecoins].self, from: favoriteData)
            completed(.success(favorites))
        } catch{
            completed(.failure(.unableToComplete))
        }
        
    }
    
    static func save (favorites: [Memecoins],key :String)->ErroMessage?{
        do {
            let encoder = JSONEncoder()
            let encodedFavorite = try encoder.encode(favorites)
            defaults.setValue(encodedFavorite, forKey: key)
            return nil
        }
        catch {
            return .saveFailure
        }
    }
    
}
