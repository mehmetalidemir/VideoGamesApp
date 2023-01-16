//
//  ListViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import UIKit

class ListViewController: UIViewController {
    
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
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ListTableViewCell {
            cell.gameLabel.text = self.viewModel.games[indexPath.row]
            cell.gameImageView.image = UIImage(systemName: "arrow.left")
            return cell
        }
        return UITableViewCell()
    }
    
    
}
