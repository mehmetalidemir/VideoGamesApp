//
//  GameDetailViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 16.01.2023.
//

import UIKit


final class GameDetailViewController: UIViewController {

    @IBOutlet weak var favoriteIconButton: UIBarButtonItem!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameLabel: UILabel!
    @IBOutlet private weak var reviews_countLabel: UILabel!
    @IBOutlet private weak var genres: UILabel!
    @IBOutlet private weak var releasedLabel: UILabel!
    @IBOutlet private weak var platforms: UILabel!

    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfGameIsFavorite()

        self.gameLabel.text = game.name

        let url = URL(string: game.background_image)
        self.gameImageView.kf.setImage(with: url)

        let ratingText = "★ \(game.rating)"
        self.ratingLabel.text = String(ratingText)

        let reviewsCountText = String(format: NSLocalizedString("reviews_count_format", comment: ""), game.reviews_count)
        self.reviews_countLabel.text = String(reviewsCountText)

        let releasedText = NSLocalizedString("released_format", comment: "") + game.released
        self.releasedLabel.text = String(releasedText)

        let genresText = NSLocalizedString("genres_format", comment: "") + game.genres.map { $0.name }.joined(separator: ",")
        self.genres.text = String(genresText)

        let platformsText = NSLocalizedString("platforms_format", comment: "") + game.platforms.map { $0.platform.name }.joined(separator: ", ")
        self.platforms.text = String(platformsText)

    }

    func checkIfGameIsFavorite() {
        let favoriteArray = UserDefaultsManager.shared.getGameFavorites()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if favoriteArray.contains(self.game.id) {
                self.favoriteIconButton.image = UIImage(systemName: "star.fill")
            } else {
                self.favoriteIconButton.image = UIImage(systemName: "star")
            }
        }

    }

    @IBAction func favoriteButton(_ sender: Any) {
        let array = UserDefaultsManager.shared.getGameFavorites()
        if array.contains(self.game.id) {
            UserDefaultsManager.shared.removeGameFavorite(id: self.game.id)
            CoreDataManager.shared.deleteGame(gameId: self.game.id, completionHandler: {
                CoreDataManager.shared.saveContext()
            })
        } else {
            UserDefaultsManager.shared.addNewGameFavorite(id: self.game.id)
            CoreDataManager.shared.createGame(gameId: self.game.id, gameName: self.game.name, gameBGImage: self.game.background_image) {
                CoreDataManager.shared.saveContext()
            }
        }
        checkIfGameIsFavorite()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNotesView" {
            guard let entryVC = segue.destination as? NewEntryViewController else { return }
            entryVC.game = self.game
        }
    }

}
