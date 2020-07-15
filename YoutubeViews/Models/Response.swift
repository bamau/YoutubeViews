//
//  Response.swift
//  YoutubeViews
//
//  Created by Bá Mẫu on 7/14/20.
//  Copyright © 2020 Bá Mẫu. All rights reserved.
//

import Foundation

struct Response: Decodable {
    
    var items: [Video]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
        
    }
    
    init (from decoder: Decoder) throws {
        
        let contanier = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try contanier.decode([Video].self, forKey: .items)
    }
}
