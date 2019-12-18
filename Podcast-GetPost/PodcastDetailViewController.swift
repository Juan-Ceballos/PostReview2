//
//  PodcastDetailViewController.swift
//  Podcast-GetPost
//
//  Created by Juan Ceballos on 12/17/19.
//  Copyright © 2019 Juan Ceballos. All rights reserved.
//

import UIKit

class PodcastDetailViewController: UIViewController {

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var podcast: Podcast?
    
    //https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let thePodcast = podcast else {
            return
        }
        
        imageLabel.getImage(with: thePodcast.artworkUrl600) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageLabel.image = image
                }
            }
        }
        trackNameLabel.text = podcast?.trackName
        artistNameLabel.text = podcast?.artistName
    }
    
    @IBAction func favoriteButtonChanged(_ sender: UIButton) {
        
    }
    
    
}
