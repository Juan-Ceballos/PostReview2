//
//  ViewController.swift
//  Podcast-GetPost
//
//  Created by Juan Ceballos on 12/16/19.
//  Copyright © 2019 Juan Ceballos. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {

    @IBOutlet weak var podcastTableView: UITableView!
    
    var podcasts = [Podcast]()    {
        didSet  {
            DispatchQueue.main.async {
                self.podcastTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        podcastTableView.dataSource = self
        podcastTableView.delegate = self
        loadData()
    }
    
    func loadData() {
        PodcastAPIClient.fetchPodcast { (result) in
            switch result   {
            case .failure(let appError):
                print(appError)
            case .success(let podcast):
                self.podcasts = podcast
            }
        }
    }
}

extension PodcastViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let podcastCell = podcastTableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else    {
            fatalError()
        }
       
        let podcast = podcasts[indexPath.row]
        podcastCell.configureCell(with: podcast.artworkUrl600, podcast: podcast)
        
        return podcastCell
    }
}

extension PodcastViewController: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
}

extension PodcastViewController: UISearchBarDelegate    {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

