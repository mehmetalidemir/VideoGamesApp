//
//  ListViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import UIKit
import Kingfisher

final class ListViewController: UIViewController {

    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var gameTableView: UITableView!

    let cellIdentifier: String = "listTableViewCell"

    let viewModel: ListViewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Games"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailVC" {
            guard let detailVC = segue.destination as? GameDetailViewController else { return }
            if let game = sender as? Game {
                detailVC.game = game
            }
        }
    }
}

extension ListViewController {
    func setupTableView() {
        gameTableView.delegate = self
        gameTableView.dataSource = self

        loadingIndicator.startAnimating()
        viewModel.fetchGames { isSuccessfull in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if isSuccessfull {
                    self.gameTableView.reloadData()
                } else {
                    print(LocalizedError.self)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailVC", sender: self.viewModel.games[indexPath.row])
    }
}
