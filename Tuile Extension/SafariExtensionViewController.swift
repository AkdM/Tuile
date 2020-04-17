//
//  SafariExtensionViewController.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 21/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController, NSTableViewDelegate, NSTableViewDataSource {
    var tuilePopover = TuilePopover()
    let persistanceManager = PersistanceManager.shared
    var sessions = PersistanceManager.shared.fetch(Session.self)
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width: 320, height: 240)
        return shared
    }()
    
    override func loadView() {
        tuilePopover.saveSessionButton.action = #selector(self.saveSessionButtonAction(_:))
        tuilePopover.tableView.delegate = self
        tuilePopover.tableView.dataSource = self
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Delete", action: #selector(tableViewDeleteItemClicked(_:)), keyEquivalent: ""))
        tuilePopover.tableView.menu = menu

        self.view = tuilePopover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    @objc func contextObjectsDidChange(_ sender: Any) -> Void {
        sessions = PersistanceManager.shared.fetch(Session.self)
        tuilePopover.tableView.reloadData()
    }
    
    @objc func saveSessionButtonAction(_ sender: NSButton) -> Void {
        Tuile.shared.getSession(completion: { (session) in
            self.persistanceManager.save()
//            do {
//                let jsonData = try JSONEncoder().encode(session)
//                let jsonString = String(data: jsonData, encoding: .utf8)!
//                print(jsonString)
//            } catch { print(error) }
        })
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let text = NSTextField()
        let session = self.sessions[row]
        text.stringValue = session.title ?? ""
        let cell = NSTableCellView()
        cell.addSubview(text)
        text.drawsBackground = false
        text.isBordered = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addConstraints([
            NSLayoutConstraint(item: text, attribute: .centerY, relatedBy: .equal, toItem: cell, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: text, attribute: .leading, relatedBy: .equal, toItem: cell, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: text, attribute: .trailing, relatedBy: .equal, toItem: cell, attribute: .trailing, multiplier: 1, constant: -10)
        ])
        return cell
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let rowView = NSTableRowView()
        rowView.isEmphasized = false
        return rowView
    }

    @objc private func tableViewDeleteItemClicked(_ sender: AnyObject) {
        guard self.tuilePopover.tableView.clickedRow >= 0 else { return }
        let session = self.sessions[self.tuilePopover.tableView.clickedRow]
        persistanceManager.context.delete(session)
    }
}
