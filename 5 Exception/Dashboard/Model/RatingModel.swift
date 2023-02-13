//
//  ReatingModel.swift
//  5 Exception
//
//  Created by Kavya Prajapati on 11/02/23.
//

import Foundation
struct Rating : Codable {
    let rate : Double?
    let count : Int?

    enum CodingKeys: String, CodingKey {

        case rate = "rate"
        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }

}
