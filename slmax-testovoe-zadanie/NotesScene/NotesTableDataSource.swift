//
//  NotesTable.swift
//  slmax-testovoe-zadanie
//
//  Created by Александр on 07.12.2022.
//

import Foundation
import UIKit

class NotesTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var notes: [Note] = []
    private let storage = Storage()
    
    func loadExistedNotes() {
        notes = storage.getNotes()
        print("NOTES ", notes)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        
        cell.setupCell(with: notes[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteTableViewCell else {
            return
        }

        tableView.beginUpdates()

        UIView.animate(withDuration: 0.3) {
            cell.isExpanded = !cell.isExpanded
        }

        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.storage.deleteNote(note: self.notes[indexPath.row])
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }

        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    
    func addNote(title: String, text: String, completion: @escaping ()->()) {
        if let note = storage.saveNote(title: title, text: text) {
            notes.insert(note, at: 0)
            completion()
        }
    }
}
