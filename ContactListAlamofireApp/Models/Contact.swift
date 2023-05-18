//
//  Contact.swift
//  ContactListAlamofireApp
//
//  Created by Zaki on 18.05.2023.
//

import Foundation

struct Contact {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: Id
    let picture: Picture
    let nat: String
    
    init(from value: [String: Any]) {
        gender = value["gender"] as? String ?? ""
        
        let nameDict = value["name"] as? [String: String] ?? [:]
        name = Name(from: nameDict)
        
        let locationDict = value["location"] as? [String: Any] ?? [:]
        location = Location(from: locationDict)
        
        email = value["email"] as? String ?? ""
        
        let loginDict = value["login"] as? [String: String] ?? [:]
        login = Login(from: loginDict)
        
        let dobDict = value["dob"] as? [String: Any] ?? [:]
        dob = Dob(from: dobDict)
        
        let registeredDict = value["registered"] as? [String: Any] ?? [:]
        registered = Dob(from: registeredDict)
        
        phone = value["phone"] as? String ?? ""
        cell = value["cell"] as? String ?? ""
        
        let idDict = value["id"] as? [String: String] ?? [:]
        id = Id(from: idDict)
        
        let pictureDict = value["picture"] as? [String: String] ?? [:]
        picture = Picture(from: pictureDict)
        
        nat = value["nat"] as? String ?? ""
    }
 
    static func getContact(from contactsData: Any) -> [Contact] {
        guard let info = contactsData as? [String: Any] else { return [] }
        guard let contacts = info["results"] as? [[String: Any]] else { return [] }
        return contacts.map { Contact(from: $0)}
    }
    
}
// MARK: - Picture
struct Picture {
    let large, medium, thumbnail: String
    
    init(from value: [String: String]) {
        large = value["large"] ?? ""
        medium = value["medium"] ?? ""
        thumbnail = value["thumbnail"] ?? ""
    }
}



//MARK: - ID
struct Id {
    let name, value: String
    
    init(from val: [String: String]) {
        name = val["name"] ?? ""
        value = val["value"] ?? ""
    }
}

//MARK: - Dob
struct Dob {
    let date: String
    let age: Int
    
    init(from value: [String: Any]) {
        date = value["date"] as? String ?? ""
        age = value["age"] as? Int ?? 0
    }
}

// MARK: - Login
struct Login {
    let uuid, username, password: String
    let salt, md5, sha1, sha256: String
    
    init(from value: [String: String]) {
        uuid = value["uuid"] ?? ""
        username = value["username"] ?? ""
        password = value["password"] ?? ""
        salt = value["salt"] ?? ""
        md5 = value["md5"] ?? ""
        sha1 = value["sha1"] ?? ""
        sha256 = value ["sha256"] ?? ""
    }
}

// MARK: -Location
struct Location {
    let street: Street
    let city, state, country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
    
    init(from value: [String: Any]) {
        let streetDict = value["street"] as? [String: Any] ?? [:]
        street = Street(from: streetDict)
        
        city = value["city"] as? String ?? ""
        state = value["state"] as? String ?? ""
        country = value["country"] as? String ?? ""
        
        postcode = value["postcode"] as? Int ?? 0
        
        let coordinatesDict = value["coordinates"] as? [String: String ] ?? [:]
        coordinates = Coordinates(from: coordinatesDict)
        
        let timezoneDict = value["timezone"] as? [String: String] ?? [:]
        timezone = Timezone(from: timezoneDict)
    }
}

struct Timezone {
    let offset, description: String
    
    init(from value: [String: String]) {
        offset = value["offset"] ?? ""
        description = value["description"] ?? ""
    }
}

struct Coordinates {
    let latitude, longitude: String
    
    init(from value: [String: String]) {
        latitude = value["latitude"] ?? ""
        longitude = value["longitude"] ?? ""
    }
}

struct Street {
    let number: Int
    let name: String
    
    init(from value: [String: Any]) {
        number = value["number"] as? Int ?? 0
        name = value["name"] as? String ?? ""
    }
}

// MARK: - Name
struct Name {
    let title, first, last: String
    
    init(from value: [String: String]) {
        title = value["title"] ?? ""
        first = value["first"] ?? ""
        last = value["last"] ?? ""
    }
}


