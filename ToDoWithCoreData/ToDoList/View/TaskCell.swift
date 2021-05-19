//
//  TaskCell.swift
//  ToDoWithCoreData
//
//  Created by Михаил Красильник on 07.02.2021.
//

import UIKit

class TaskCell: UITableViewCell {

    var title = UILabel()
    
    var body = UITextView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createTitle()
        createBody()
    }

    private func createTitle() {
        
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.font = title.font.withSize(28)
        title.textAlignment = .center
        
        if let parentView = title.superview {
            title.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
            title.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 16).isActive = true
            title.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -16).isActive = true
        }
    }
    
    private func createBody() {
        
        contentView.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        
        body.isEditable = false
        
        if let parentView = body.superview {
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
            body.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 16).isActive = true
            body.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -16).isActive = true
            body.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        }
    }
}
