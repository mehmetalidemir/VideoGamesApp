//
//  DetailViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import UIKit


class DetailViewController: UIViewController {
    var game: Game!

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var reviews_countLabel: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var platforms: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameLabel.text = game.name
        

        let url = URL(string: game.background_image)
        self.gameImageView.kf.setImage(with: url)

        let ratingText = "★ \(game.rating)"
        self.ratingLabel.text = String(ratingText)

        let reviewsCountText = " (\(game.reviews_count) Reviews)"
        self.reviews_countLabel.text = String(reviewsCountText)

        let releasedText = "Relased Date : \(game.released)"
        self.releasedLabel.text = String(releasedText)

        let genresText = "Genres: \(game.genres.map { $0.name }.joined(separator: ","))"
        self.genres.text = String(genresText)

        let platformsText = "Platforms: \(game.platforms.map { $0.platform.name }.joined(separator: ", "))"
        self.platforms.text = String(platformsText)


    }


}
