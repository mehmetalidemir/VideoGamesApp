//
//  ListViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    let viewModel: ListViewModel = {
        let viewModel = ListViewModel()
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
