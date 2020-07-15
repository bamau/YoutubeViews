//
//  VideoTableViewCell.swift
//  YoutubeViews
//
//  Created by Bá Mẫu on 7/15/20.
//  Copyright © 2020 Bá Mẫu. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var dateLable: UILabel!
    
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video) {
        
        self.video = v
        
        //Ensure that we have a video
        guard self.video != nil else {
            return
        }
        
        //Set the title
        self.titleLable.text = video?.title
        
        //Set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLable.text = df.string(from: video!.published)
        
        //Set the thmbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //Check cache before downloading data
        if let cacheData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            //Set the thumbnail imageview
            self.thumbnailImageView.image = UIImage(data: cacheData)
            return
        }
        
        //Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        //Get the shared URL Session object
        let session = URLSession.shared
        
        //Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data!)
                
                //Check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                if url!.absoluteString != self.video?.thumbnail {
                    //Video cell has been recycled for another video and no longer matches the thmbnail that was downloaded
                    return
                }
                //Create the image object
                let image = UIImage(data: data!)
                
                //Set the imageview
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
            }
        }
        //Start data task
        dataTask.resume()
    }
        

}
