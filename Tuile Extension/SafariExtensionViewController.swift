//
//  SafariExtensionViewController.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 21/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    let popoverTitle = NSTextField()
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width: 320, height: 240)
        return shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    
    func setupView() -> Void {
        self.view = NSView()

        self.popoverTitle.stringValue = "Tuile"
        self.popoverTitle.translatesAutoresizingMaskIntoConstraints = false
        self.popoverTitle.isBezeled = false
        self.popoverTitle.isEditable = false
        self.popoverTitle.backgroundColor = .none
        self.popoverTitle.font = NSFont(name: "Helvetica Neue", size: 24)
        self.popoverTitle.alignment = .center

        self.view.addSubview(self.popoverTitle)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.popoverTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0),
            self.popoverTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.popoverTitle.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}
