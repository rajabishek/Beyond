//
//  NoteTableViewCell.swift
//  Beyond
//
//  Created by Raj Abishek on 19/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet weak var contentTextLabel: UILabel!
    
    func populateCellWithNote(note: Note) {
        titleTextLabel.text = note.title
        contentTextLabel.text = note.content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
