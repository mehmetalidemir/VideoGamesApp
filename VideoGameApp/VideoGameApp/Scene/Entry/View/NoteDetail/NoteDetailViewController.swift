//
//  NoteDetailViewController.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 19.01.2023.
//

import UIKit
import CoreData

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var noteTextField: UITextField!
    
    var game: Game?
    var selectedNote: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedNote != nil {
            noteTextField.text = selectedNote?.title
            descriptionTextView.text = selectedNote?.desc
        }
        
    }
    @IBAction func saveButton(_ sender: Any) {
        CoreDataManager.shared.createNote(title: noteTextField.text ?? "", desc: descriptionTextView.text ?? "", gameName: self.game?.name ?? "", id: noteList.count as NSNumber) { [weak self] in
            guard let self = self else { return }
            CoreDataManager.shared.saveContext()
            self.navigationController?.popViewController(animated: true)
        }
        LocalNotificationManager.shared.sendNotification()
        
    }
    @IBAction func deleteButtton(_ sender: Any) {
        if let note = selectedNote {
            CoreDataManager.shared.deleteNote(selectedNote: note) { [weak self] in
                guard let self = self else { return }
                CoreDataManager.shared.saveContext()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
