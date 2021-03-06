//
//  ViewController.swift
//  Tuile
//
//  Created by Anthony Da Mota on 21/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import Cocoa
import SafariServices.SFSafariApplication

class ViewController: NSViewController {

    @IBOutlet var appNameLabel: NSTextField!
    let persistanceManager = PersistanceManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = "Tuile"
        
//        let session = Session(context: persistanceManager.context)
//        session.title = "Session title"
//        persistanceManager.save()
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "com.akdm.Tuile-Extension") { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.

            }
        }
    }

}
