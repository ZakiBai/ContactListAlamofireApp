//
//  NetworkManager.swift
//  ContactListAlamofireApp
//
//  Created by Zaki on 18.05.2023.
//

import Foundation
import Alamofire
enum Link {
    case contactUrl
    
    var url: URL {
        switch self {
        case .contactUrl:
            return URL(string: "https://randomuser.me/api/")!
        }
    }
}


final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUsers(completion: @escaping (Result<[Contact], AFError>) -> Void) {
        AF.request(Link.contactUrl.url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let contactsData):
                    let contacts = Contact.getContact(from: contactsData)
                    completion(.success(contacts))
                case .failure(let error):
                    completion(.failure(error))
                }
            }.resume()
    }
    
    func fetchData(from url: URL, completion: @escaping (Result <Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }.resume()
    }
    
}
