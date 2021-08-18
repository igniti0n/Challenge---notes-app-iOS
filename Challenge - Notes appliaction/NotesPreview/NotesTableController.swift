//
//  ViewController.swift
//  Challenge - Notes appliaction
//
//  Created by Ivan Stajcer on 18.08.2021..
//

import UIKit

let kkNotesKey = "SavedNotes"

class NotesTableController : UIViewController {
    
    private var notes = [Note]()
    
    private var contentView : NotesTableView!
    
    override func loadView() {
        super.loadView()
        contentView = NotesTableView()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(NoteCell.self, forCellReuseIdentifier: kkNoteCellIdentifier)
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        
        contentView.onAddTapped = {
            [weak self] in
            
            let ac = UIAlertController(title: "Set name", message: nil, preferredStyle: .alert)
            ac.addTextField(configurationHandler: nil)
            ac.addAction(UIAlertAction(title: "Done", style: .default, handler: {
                action in
                let newNote = Note(title: ac.textFields?.first?.text ?? "", text: "")
                self?.notes.insert(newNote, at: 0)
                self?.saveUserData()
                self?.contentView.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }))
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            self?.present(ac, animated: true, completion: nil)
            
        }
        
    }

}


extension NotesTableController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
}

extension NotesTableController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kkNoteCellIdentifier) as? NoteCell else {
            fatalError("No cell for this identifier")
        }

        cell.titleLabel.text = notes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = NoteDetailViewController()
        vc.note = notes[indexPath.row]
        
        vc.updateNote = {
            [weak self] text in
            self?.notes[indexPath.row].text = text
            self?.saveUserData()
        }
        
        vc.deleteNote = {
            [weak self] in
            self?.notes.remove(at: indexPath.row)
            self?.saveUserData()
            self?.contentView.tableView.reloadData()
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension NotesTableController {
    
    private func loadUserData(){
        
        DispatchQueue.global().async {
            [weak self] in
            let defaults = UserDefaults.standard
            guard let savedData = defaults.data(forKey: kkNotesKey) else {print("No data");return}
            
            self?.decodeFromData(data: savedData)
        }
       
    }
    
  
    
    private func decodeFromData(data : Data){
        
        let decoder = JSONDecoder()
        guard let loadedNotes = try? decoder.decode([Note].self, from: data) else {print("Decoding failed");return}
        notes = loadedNotes
    }
    
    @objc private func saveUserData(){
        
        DispatchQueue.global().async {
            [weak self] in
            let data = self?.encodeToData()
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: kkNotesKey)
        }
        
    }
    
    private func encodeToData() -> Data{
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(notes) else {fatalError("Failed to encode to data")}
        
        return data
    }

    
}



