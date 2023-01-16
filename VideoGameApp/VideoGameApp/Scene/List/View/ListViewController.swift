//
//  ListViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gameTableView: UITableView!
    
    let cellIdentifier: String = "listTableViewCell"
    
    let viewModel: ListViewModel = {
        let viewModel = ListViewModel()
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        gameTableView.delegate = self
        gameTableView.dataSource = self
        loadingIndicator.startAnimating()
        viewModel.fetchGames { isSuccessfull in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if isSuccessfull {
                    self.gameTableView.reloadData()
                } else {
                    
                }
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
            }
            
        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ListTableViewCell {
            cell.gameLabel.text = "\(indexPath.row + 1) - \(viewModel.games[indexPath.row].name)"
            let url = URL(string: "\(self.viewModel.games[indexPath.row].background_image)")
            cell.gameImageView.kf.setImage(with: url)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
