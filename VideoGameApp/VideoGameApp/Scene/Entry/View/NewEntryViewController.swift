//
//  NewEntryViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 19.01.2023.
//

import UIKit

var noteList = [Note]()

final class NewEntryViewController: UIViewController {

    @IBOutlet weak var noteTableView: UITableView!

    let noteCellIdentifier: String = "noteTableViewCell"
    
    var notes: [Note] = []
    var game: Game?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.fetchNotes { [weak self] result in
            guard let self = self else { return }
            self.notes.removeAll()
            switch result {
            case .success(let notes):
                self.notes = notes.filter({ note in
                    return note.deletedDate == nil && note.gameName == self.game?.name ?? ""
                })
            case .failure(let error):
                print(error)
            }
            self.noteTableView.reloadData()
        }
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupTableView() {
        noteTableView.dataSource = self
        noteTableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            if let noteDetail = segue.destination as? NoteDetailViewController {
                let indexPath = noteTableView.indexPathForSelectedRow!
                let selectedNote: Note!
                selectedNote = self.notes[indexPath.row]
                noteDetail.selectedNote = selectedNote

                noteTableView.deselectRow(at: indexPath, animated: true)
            }
        } else if segue.identifier == "newNote" {
            if let noteDetail = segue.destination as? NoteDetailViewController {
                noteDetail.game = self.game
            }
        }
    }
    
}

extension NewEntryViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let noteCell = tableView.dequeueReusableCell(withIdentifier: noteCellIdentifier, for: indexPath) as? NoteCell {
            
            let thisNote = notes[indexPath.row]
            
            noteCell.titleLabel.text = thisNote.title
            noteCell.descLabel.text = thisNote.desc
            
            return noteCell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: nil)
    }
    
}
