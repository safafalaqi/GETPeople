//
//  PeopleModel.swift
//  GET People
//
//  Created by Safa Falaqi on 21/12/2021.
//

import Foundation

class PeopleModel{
    
    static func getAllPeople(pageIndex:Int,completionHandler:@escaping  (_ data: Data? , _ response:URLResponse?, _ error:Error?) -> Void){
        let url = URL(string: "https://swapi.dev/api/people/?page=\(pageIndex)&format=json")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler:completionHandler)
        task.resume()
    }
    
}

// MARK: - Welcome
struct People: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let gender: Gender
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case nA = "n/a"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


