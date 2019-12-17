//
//  PodcastCell.swift
//  Podcast-GetPost
//
//  Created by Juan Ceballos on 12/17/19.
//  Copyright © 2019 Juan Ceballos. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell  {
    
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastTrackName: UILabel!
    @IBOutlet weak var podcastArtistName: UILabel!
    
    var podcasts = [Podcast]()

    func configureCell(with urlString: String, podcast: Podcast)    {
      
        podcastImage.getImage(with: urlString) { (result) in
            switch result   {
            case .failure:
                DispatchQueue.main.async {
                    self.podcastImage.image = UIImage(systemName: "podcast.fill")
                }
            case .success(let podcastImage):
                DispatchQueue.main.async {
                    self.podcastImage.image = podcastImage
                }
            }
        }
        
        self.podcastTrackName.text = "Track Name: \(podcast.trackName)"
        self.podcastArtistName.text = "Artist Name: \(podcast.artistName)"
    }
}
