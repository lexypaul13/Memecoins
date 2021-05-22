//
//  NetworkManager.swift
//  Memecoins
//
//  Created by Alex Paul on 5/22/21.
//

import UIKit

class NetworkManger{
    enum EndPoint{
        case tokens
    }
    
    static let shared = NetworkManger()
    private var baseURL: String
    private var  apiKeyPathCompononent :String
    
    private init(){
        self.baseURL = "https://api.pancakeswap.info"
        self.apiKeyPathCompononent = "/api/tokens"
    }
    
    private var jsonDecoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    func get<T:Decodable>(_ endPoints: EndPoint,urlString: String, completed:@escaping(Result<T?,ErroMessage>)->Void){
        
        guard let url = urlBuilder(endPoint: endPoints) else {
            print(ErroMessage.invalidURL.rawValue)
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                print(ErroMessage.unableToComplete.rawValue)
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode==200 else {
                print(ErroMessage.invalidResponse.rawValue)
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                print(error!.localizedDescription)
                completed(.failure(.invalidData))
                return
            }
            do{
                let apiResponse = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(apiResponse))
                }
                
            } catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    
    private func urlBuilder(endPoint:EndPoint, page:Int?=nil, query:String? = nil)->URL?{
        switch endPoint {
        case .tokens:
            return URL(string: baseURL + apiKeyPathCompononent )
       
        }
    }
}
