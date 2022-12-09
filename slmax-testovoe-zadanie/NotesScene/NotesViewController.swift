//
//  ViewController.swift
//  slmax-testovoe-zadanie
//
//  Created by Александр on 02.12.2022.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var inputFormView: UIView!
    @IBOutlet weak var noteTitleVIew: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    
    private let notesTableDataSource = NotesTableDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = notesTableDataSource
        tableView.delegate = notesTableDataSource
        
        noteTextView.delegate = self
        
        tableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        
        setupInputFormView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notesTableDataSource.loadExistedNotes()
    }
    
    private func setupInputFormView() {
        inputFormView.layer.cornerRadius = 10
        inputFormView.layer.borderWidth = 1
        inputFormView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }

    @IBAction func addnote(_ sender: Any) {
        guard let title = noteTitleVIew.text, let text = noteTextView.text else { return }
        notesTableDataSource.addNote(title: title, text: text) {
            self.tableView.reloadData()
            self.noteTextView.text = "Текст описание"
            self.noteTitleVIew.text = "Название"
            self.textViewDidChange(self.noteTextView)
            self.view.endEditing(true)
        }
    }
    
}

extension NotesViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.size.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        guard textView.contentSize.height < 100.0 else {
            textView.isScrollEnabled = true
            return
        }
        
        textView.isScrollEnabled = false
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
}
