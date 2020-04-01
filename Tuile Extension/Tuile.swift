//
//  Tuile.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 23/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import SafariServices

class Tuile {
    
    static let shared = Tuile()
    private let persistanceManager = PersistanceManager.shared

    func getSession(completion: @escaping (Session) -> ()) {
        let currentDate = Date.currentAsISO8601String
        SFSafariApplication.getAllWindows { (windows) in
            self.getWindows(windows: windows) { (tuileWindows) in
                let newSession = Session(context: self.persistanceManager.context)
                newSession.title = currentDate
                newSession.created = currentDate.toDate()
                newSession.mutableSetValue(forKey: "windows").addObjects(from: tuileWindows)
                completion(newSession)
            }
        }
    }
    
    func getWindows(windows: [SFSafariWindow], completion: @escaping ([Window]) -> ()) {
        let group = DispatchGroup()
        var tuileWindows: [Window] = []
        for window in windows {
            group.enter()
            self.getWindow(window: window) { (tuileWindow) in
                tuileWindows.append(tuileWindow)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(tuileWindows)
        }
    }
    
    func getWindow(window: SFSafariWindow, completion: @escaping (Window) -> ()) {
        let group = DispatchGroup()
        let newWindow = Window(context: self.persistanceManager.context)
        group.enter()
        window.getAllTabs(completionHandler: { (tabs) in
            self.getTabs(tabs: tabs) { (tuileTabs) in
                newWindow.mutableSetValue(forKey: "tabs").addObjects(from: tuileTabs)
                group.leave()
            }
        })
        group.notify(queue: .main) {
            completion(newWindow)
        }
    }
    
    func getTabs(tabs: [SFSafariTab], completion: @escaping ([Tab]) -> ()) {
        let group = DispatchGroup()
        var tuileTabs: [Tab] = []
        for tab in tabs {
            group.enter()
            getTab(tab: tab) { (tuileTab) in
                tuileTabs.append(tuileTab)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(tuileTabs)
        }
    }
    
    func getTab(tab: SFSafariTab, completion: @escaping (Tab) -> ()) {
        let group = DispatchGroup()
        var title: String?
        var url: URL?
        var isPrivate: Bool?

        group.enter()
        tab.getActivePage(completionHandler: { (page) in
            
            page?.getPropertiesWithCompletionHandler({ (p) in
                title = p?.title ?? "New tab"
                url = p?.url ?? URL.init(string: "about:blank")
                isPrivate = p?.usesPrivateBrowsing ?? false
                group.leave()
            })
        })
        group.notify(queue: .main) {
            let newTab = Tab(context: self.persistanceManager.context)
            newTab.title = title
            newTab.url = url
            newTab.isPrivate = isPrivate ?? false
            completion(newTab)
        }
    }
}
