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

    func getSession(completion: @escaping (TuileSession) -> ()) {
        SFSafariApplication.getAllWindows { (windows) in
            self.getWindows(windows: windows) { (tuileWindows) in
                completion(TuileSession(windows: tuileWindows))
            }
        }
    }
    
    func getWindows(windows: [SFSafariWindow], completion: @escaping ([TuileWindow]) -> ()) {
        let group = DispatchGroup()
        var tuileWindows: [TuileWindow] = []
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
    
    func getWindow(window: SFSafariWindow, completion: @escaping (TuileWindow) -> ()) {
        let group = DispatchGroup()
        var tuileWindow: TuileWindow = TuileWindow()
        group.enter()
        window.getAllTabs(completionHandler: { (tabs) in
            self.getTabs(tabs: tabs) { (tuileTabs) in
                tuileWindow.tabs = tuileTabs
                group.leave()
            }
        })
        group.notify(queue: .main) {
            completion(tuileWindow)
        }
    }
    
    func getTabs(tabs: [SFSafariTab], completion: @escaping ([TuileTab]) -> ()) {
        let group = DispatchGroup()
        var tuileTabs: [TuileTab] = []
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
    
    func getTab(tab: SFSafariTab, completion: @escaping (TuileTab) -> ()) {
        tab.getActivePage(completionHandler: { (page) in
            self.getProperties(page: page, completion: { (titleProp, urlProp, privateProp) in
                DispatchQueue.main.async {
                    completion(TuileTab(title: titleProp, url: urlProp, isPrivate: privateProp))
                }
            })
        })
    }
    
    func getProperties(page: SFSafariPage?, completion: @escaping (String?, URL?, Bool?) -> ()) {
        page?.getPropertiesWithCompletionHandler({ (p) in
            if let properties = p {
                DispatchQueue.main.async {
                    completion(properties.title, properties.url, properties.usesPrivateBrowsing)
                }
            }
        })
    }
}
