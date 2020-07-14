//
//  Video.swift
//  YoutubeViews
//
//  Created by Bá Mẫu on 7/10/20.
//  Copyright © 2020 Bá Mẫu. All rights reserved.
//

import Foundation
struct Video : Decodable {

    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case published = "publishedAt"
        case title
        case videoId
        case description
        case thumbnail = "url"
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        //Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        //Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        //Parse published
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        //Parse thumbnail
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        //Parse videoId
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
    }
}
