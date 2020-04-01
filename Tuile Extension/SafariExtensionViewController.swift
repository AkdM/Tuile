//
//  SafariExtensionViewController.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 21/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    var tuilePopover = TuilePopover()
    let persistanceManager = PersistanceManager.shared
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width: 320, height: 240)
        return shared
    }()
    
    override func loadView() {
        tuilePopover.saveSessionButton.action = #selector(self.saveSessionButtonAction(_:))
        self.view = tuilePopover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func saveSessionButtonAction(_ sender: NSButton) -> Void {
        Tuile.shared.getSession(completion: { (session) in
            do {
                self.persistanceManager.save()
                
//                let jsonData = try JSONEncoder().encode(session)
//                let jsonString = String(data: jsonData, encoding: .utf8)!
//                print(jsonString)
            } catch { print(error) }
        })
    }
}
