//
//  Model.swift
//  YoutubeViews
//
//  Created by Bá Mẫu on 7/10/20.
//  Copyright © 2020 Bá Mẫu. All rights reserved.
//

import Foundation
class Model {
    func getVideos() {
        
        //Create a URL object
        let url = URL(string: Constants.API_URL)
        guard url != nil else{
            return
        }
        
        //Get a URLSession object
        let session = URLSession.shared
        //Get data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            //Check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            //Passing the data into video object
        }
        //Kick off the task
        dataTask.resume()
        
        
    }
}
