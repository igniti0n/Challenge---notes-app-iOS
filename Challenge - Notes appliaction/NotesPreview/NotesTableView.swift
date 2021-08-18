//
//  NotesTableView.swift
//  Challenge - Notes appliaction
//
//  Created by Ivan Stajcer on 18.08.2021..
//

import Foundation
import UIKit
import SnapKit

class NotesTableView : UIView {
    
    var tableView : UITableView!
    
    private lazy var titleView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var addNoteButton : UIButton = {
        let button = UIButton(type: .contactAdd)
        return button
    }()
    
    var onAddTapped : (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        configureView()
        configureConstraints()
    }
    
    private func configureView(){
        
        tableView = UITableView()
        
        tableView.register(NoteCell.self, forCellReuseIdentifier: kkNoteCellIdentifier)
        tableView.backgroundColor = UIColor.black
        
        titleLabel.text = "Notes"
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        titleLabel.textColor = UIColor.systemPurple
        
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(addNoteButton)
        titleView.backgroundColor = UIColor.black
        
        addNoteButton.addTarget(self, action: #selector(createNote), for: .touchUpInside)
        
        self.addSubview(tableView)
        self.addSubview(titleView)
        
    }
    
    @objc func createNote(){
        onAddTapped?()
    }
    
    private func configureConstraints(){
        
        titleView.snp.makeConstraints {
            make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            make in
            make.centerY.left.equalToSuperview()
        }
        
        addNoteButton.snp.makeConstraints {
            make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom)
        }
        
        
    }
    
    
}
