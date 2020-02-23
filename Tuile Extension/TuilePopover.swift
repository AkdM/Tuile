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

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setupView()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() -> Void {
        self.popoverTitle.translatesAutoresizingMaskIntoConstraints = false
        self.popoverTitle.font = NSFont(name: "Helvetica Neue", size: 24)
        self.popoverTitle.stringValue = "Tuile"
        self.popoverTitle.isBezeled = false
        self.popoverTitle.isEditable = false
        self.popoverTitle.backgroundColor = .none
        self.popoverTitle.alignment = .center

        self.addSubview(self.popoverTitle)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.popoverTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            self.popoverTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.popoverTitle.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
