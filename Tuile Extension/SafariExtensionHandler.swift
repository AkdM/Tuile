//
//  SafariExtensionHandler.swift
//  Tuile Extension
//
//  Created by Anthony Da Mota on 21/02/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
        self.getSession(completion: { (session) in
            do {
                let jsonData = try JSONEncoder().encode(session)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                print(jsonString)
            } catch { print(error) }
        })
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }
    
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


struct TuileTab: Codable {
    var title: String?
    var url: URL?
    var isPrivate: Bool?
}

struct TuileWindow: Codable {
    var tabs: [TuileTab]?
}

struct TuileSession: Codable {
    var windows: [TuileWindow]
}
