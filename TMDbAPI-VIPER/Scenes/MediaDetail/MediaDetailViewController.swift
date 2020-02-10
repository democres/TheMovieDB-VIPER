//
//  MediaDetailViewController.swift
//  TMDbAPI-VIPER
//
//  Created by David Figueroa on 9/02/20.
//  Copyright © 2020 Furkan Kurnaz. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class MediaDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var moviePosterImg: UIImageView!
    
    // MARK: - Properties
    
    var presenter: MediaDetailPresenterProtocol!
    var media: Media!


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
        presenter.getMovieDetail(id: media.id ?? 0)
        
        configureView()
    }
    
    // MARK: - Handle Presenter Output
    func handleOutput(_ output: MediaDetailPresenterOutput) {
        switch output {
        case .trailerKey(let trailerKey):
            print(trailerKey)
        }
    }
    
    // MARK: - Helpers
    
    func configureView(){
        titleLbl.text = media.title
        descriptionLbl.text = media.overview
        
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500/" + (media?.poster ?? ""))
        moviePosterImg.af_setImage(withURL: baseUrl!)
    }
    
    func getMovieTrailer(){
        if media.mediaType == "movie" {
            
            
        }
    }

    // MARK: - Actions
    
}


extension MediaDetailViewController: MediaDetailViewProtocol {
    func showMovieTrailer(trailerKey: String) {
        print(trailerKey)
    }
    
    func update(presentation media: Media) {
        self.media = media
    }
}
