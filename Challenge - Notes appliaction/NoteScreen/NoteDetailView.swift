//
//  NoteDetailView.swift
//  Challenge - Notes appliaction
//
//  Created by Ivan Stajcer on 18.08.2021..
//

import Foundation
import UIKit
import SnapKit

class NoteDetailView : UIView {
    
    var textView : UITextView!
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        
        textView = UITextView()
        textView.backgroundColor = UIColor.black
        textView.textAlignment = .left
        textView.textColor = UIColor.white
        textView.font = UIFont(name: "Chalkduster", size: 20)
        addSubview(textView)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustTextViewSize), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustTextViewSize), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)

        backgroundColor = UIColor.black
        
    }
    
    @objc private func adjustTextViewSize(notification : NSNotification){
        
        //get reference for the user keyboard
             guard let info = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
             
             //get the rect of keyboard and convert it into one relative to our view
             let keyboardRect = info.cgRectValue
             let frame = convert(keyboardRect, to: self)
             
             //if we ar ehiding the keyboard, set it to zero
             if notification.name == UIResponder.keyboardWillHideNotification {
                 textView.contentInset = .zero
             }else{
                 //determine ammount of space available for our text field
                let heightInsents = frame.height - (self.superview?.safeAreaInsets.bottom ?? 0)
                textView.contentInset.bottom = heightInsents
             }
             //insets for the scroll pedal
            textView.scrollIndicatorInsets = textView.contentInset
             
             let selectedRange = textView.selectedRange
            textView.scrollRangeToVisible(selectedRange)
        
    }
    
    private func configureConstraints(){
        
        textView.snp.makeConstraints {
            make in
            make.width.height.equalTo(safeAreaLayoutGuide).offset(13)
        }
        
    }
    
}
