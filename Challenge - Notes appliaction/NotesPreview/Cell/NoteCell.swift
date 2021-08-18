//
//  NoteCell.swift
//  Challenge - Notes appliaction
//
//  Created by Ivan Stajcer on 18.08.2021..
//

import Foundation
import UIKit
import SnapKit

let kkNoteCellIdentifier = "NoteCell"

class NoteCell : UITableViewCell {
    
    lazy var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureConstraints()
                
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        configureConstraints()
       
    }
    
    private func configureView(){
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textColor = UIColor.purple
        backgroundColor = UIColor.black
        addSubview(titleLabel)
        
    }
    
    private func configureConstraints(){
        
        titleLabel.snp.makeConstraints {
            make in
            make.centerY.left.equalToSuperview()
        }
        
    }
    
    
}
