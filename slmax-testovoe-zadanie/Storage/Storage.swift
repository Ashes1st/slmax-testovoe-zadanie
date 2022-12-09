//
//  Storage.swift
//  slmax-testovoe-zadanie
//
//  Created by Александр on 02.12.2022.
//

import Foundation
import CoreData
import UIKit

class Storage {
    
    
    func getNotes() -> [Note] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let notes = try context.fetch(fetchRequest)
            return notes
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }

    func saveNote(title: String, text: String) -> Note? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return nil }
        
        let note = Note(entity: entity, insertInto: context)
        
        note.title = title
        note.text = text
        note.date = Date()
        
        do {
            try context.save()
            return note
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }

    func deleteNote(note: Note) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(note)
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
