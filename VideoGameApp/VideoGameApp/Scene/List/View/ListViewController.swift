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

    var filterButton: UIMenu!

    let cellIdentifier: String = "listTableViewCell"

    let viewModel: ListViewModel = ListViewModel()
    var platforms = Set<String>()
    var filteredGames: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Games".localized()
        self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = true
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailVC" {
            guard let detailVC = segue.destination as? GameDetailViewController else { return }
            if let game = sender as? Game {
                detailVC.game = game
            }
        }
    }

    func setupFilterMenuButton() {
        let _ = self.viewModel.games.map { game in
            for platform in game.platforms {
                self.platforms.insert(platform.platform.name)
            }
        }
        var actions: [UIAction] = []
        for platform in self.platforms {
            let action = UIAction(title: "\(platform)", image: UIImage(systemName: "camera.filters"), handler: { _ in
                    self.filteredGames = self.viewModel.games.filter({ game in
                        for innerPlatform in game.platforms {
                            if innerPlatform.platform.name == "\(platform)" {
                                return true
                            }
                        }
                        return false
                    })
                    DispatchQueue.main.async { [weak self] in
                        self?.gameTableView.reloadData()
                    }
                })
            actions.append(action)
        }
        let items = UIMenu(title: "Filter by".localized(), options: .displayInline, children: actions)
        self.filterButton = UIMenu(title: "", children: [items])
        if #available(iOS 14.0, *) {
            self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Categories", image: UIImage(systemName: "arrowtriangle.down.circle.fill"), primaryAction: nil, menu: filterButton)

        } else {
            // Fallback on earlier versions
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
                    self.setupFilterMenuButton()
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
        if filteredGames.count != 0 {
            return filteredGames.count
        } else {
            return viewModel.games.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ListTableViewCell {
            var currentGame: Game
            if filteredGames.count != 0 {
                currentGame = filteredGames[indexPath.row]
            } else {
                currentGame = self.viewModel.games[indexPath.row]
            }
            cell.gameLabel.text = "\(indexPath.row + 1) - \(currentGame.name)"
            let url = URL(string: "\(currentGame.background_image)")
            cell.gameImageView.kf.setImage(with: url)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currentGame: Game
        if filteredGames.count != 0 {
            currentGame = filteredGames[indexPath.row]
        } else {
            currentGame = self.viewModel.games[indexPath.row]
        }
        performSegue(withIdentifier: "goToDetailVC", sender: currentGame)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
        textDidChange searchText: String) {
        if !(searchText.count == 0) {
            viewModel.games = viewModel.games.filter { game in
                let tmp: NSString = game.name as NSString
                let range = tmp.range(of: searchText, options: .caseInsensitive)
                return range.location != NSNotFound
            }
            self.gameTableView.reloadData()

        } else {
            viewModel.fetchGames { _ in
                DispatchQueue.main.async { [weak self] in
                    self?.gameTableView.reloadData()
                }
            }
        }
    }
}

