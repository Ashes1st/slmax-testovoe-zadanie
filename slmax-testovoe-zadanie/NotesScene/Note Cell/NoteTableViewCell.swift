//
//  NoteTableViewCell.swift
//  slmax-testovoe-zadanie
//
//  Created by Александр on 07.12.2022.
//

import UIKit
import Foundation

class NoteTableViewCell: UITableViewCell {

    private var note: Note!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortTextLabel: UILabel!
    
    @IBOutlet weak var fullDescriptionView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var constraintsForCollapsedContent: [NSLayoutConstraint] = []
    private var constraintsForExpandedContent: [NSLayoutConstraint] = []
    
    var isExpanded: Bool = false {
        didSet {
            if isExpanded {
                expandNote()
            } else {
                collapseNote()
            }
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerView.layer.cornerRadius = 10
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        fullDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        selectionStyle = .none
        
        constraintsForExpandedContent = [
            headerView.bottomAnchor.constraint(equalTo: fullDescriptionView.topAnchor, constant: -8),
            fullDescriptionView.bottomAnchor.constraint(
                        equalTo: contentView.bottomAnchor, constant: -8
                    )
        ]
        
        
        constraintsForCollapsedContent = [
            headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
        
        collapseNote()
    }
    
    func setupCell(with note: Note) {
        self.note = note
        titleLabel.text = note.title
        if let text = note.text {
            shortTextLabel.text = String(text.prefix(20))
        } else {
            shortTextLabel.text = ""
        }
        self.textView.text = note.text
        
        if let date = note.date {
            self.dateLabel.text = formatDateToString(date: date)
        } else {
            self.dateLabel.text = "12.12.2022"
        }
    }
    
    private func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC+3")
        return dateFormatter.string(from: date)
    }
    
    private func collapseNote() {
        print("COLLAPS")
        NSLayoutConstraint.deactivate(constraintsForExpandedContent)
        NSLayoutConstraint.activate(constraintsForCollapsedContent)
        
        fullDescriptionView.alpha = isExpanded ? 1 : 0
        
        contentView.layoutIfNeeded()
    }
    
    private func expandNote() {
        print("EXPAND")
        NSLayoutConstraint.deactivate(constraintsForCollapsedContent)
        NSLayoutConstraint.activate(constraintsForExpandedContent)
        
        fullDescriptionView.alpha = isExpanded ? 1 : 0
        
        contentView.layoutIfNeeded()
    }
    
    @IBAction func expandNote(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
