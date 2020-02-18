//
//  MediaListViewController.swift
//  IMDbAPI-VIPER
//
//  Created David Figueroa on 9/10/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//


import UIKit

class MediaListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MediaListPresenter!
    
    var medias: [Media]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.load()
        configureView()
        
        self.title = "Search Results"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureView() {
        tableView.rowHeight = 100
    }

}

extension MediaListViewController: MediaListViewProtocol {
    func update(presentation: [Media]) {
        self.medias = presentation
        tableView.reloadData()
    }
}

extension MediaListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medias?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.medias?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaListCell", for: indexPath) as! MediaListTableViewCell
        
        cell.setView(title: movie?.title ?? "", type: movie?.overview ?? "" , imageURL: movie?.poster ?? "")
        
        return cell
    }
}

extension MediaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let media = self.medias?[indexPath.row] {
            presenter.showMediaDetail(media: media)
        }
    }
}
