//
//  TuilePopover.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 23/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import Cocoa
import SafariServices

class TuilePopover: NSView {

    let popoverTitle = NSTextField()
    let saveSessionButton = NSButton()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setupView()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() -> Void {
        // Title
        self.popoverTitle.translatesAutoresizingMaskIntoConstraints = false
        self.popoverTitle.font = NSFont(name: "Helvetica Neue", size: 18)
        self.popoverTitle.stringValue = "Tuile"
        self.popoverTitle.isBezeled = false
        self.popoverTitle.isEditable = false
        self.popoverTitle.backgroundColor = .none
        self.popoverTitle.alignment = .left
        
        // Save Session Button
        self.saveSessionButton.translatesAutoresizingMaskIntoConstraints = false
        self.saveSessionButton.title = "Save Session"
        self.saveSessionButton.bezelStyle = .texturedRounded
        self.saveSessionButton.focusRingType = .none
        self.saveSessionButton.attributedTitle = NSMutableAttributedString(string: self.saveSessionButton.title,
                                                                           attributes: [.foregroundColor: NSColor.white])

        // Adding subviews
        self.addSubview(self.popoverTitle)
        self.addSubview(self.saveSessionButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title
            self.popoverTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            self.popoverTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            
            // Save Session Button
            self.saveSessionButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            self.saveSessionButton.leadingAnchor.constraint(equalTo: self.popoverTitle.trailingAnchor, constant: 10.0),
            self.saveSessionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0)
        ])
    }
}
