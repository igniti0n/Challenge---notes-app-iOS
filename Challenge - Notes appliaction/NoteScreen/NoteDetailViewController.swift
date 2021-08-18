//
//  NoteDetailViewController.swift
//  Challenge - Notes appliaction
//
//  Created by Ivan Stajcer on 18.08.2021..
//

import Foundation
import UIKit

class NoteDetailViewController : UIViewController {
    
    var contentView = NoteDetailView()
    var note : Note!
    var updateNote : ((_ text:String)->Void)?
    var deleteNote : (()->Void)?
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = note.title
        contentView.textView.text = note.text
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteCurrentNote))
        
    }
    
    @objc private func saveNote(){
        updateNote?(contentView.textView.text)
        navigationController?.popViewController(animated: true)

    }
    
    @objc private func deleteCurrentNote(){
        deleteNote?()
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
