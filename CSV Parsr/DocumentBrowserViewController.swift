//
//  DocumentBrowserViewController.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 19.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import UIKit
import CSV


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate{
    
    var users = [UserProfile]()
    var currentUserID = String()
    var eName: String = String()
    var name:String = String()
    var category = UserCategory()
    var item = UserItems()
    var userCategory:[UserCategory] = [UserCategory]()
    var userItems:[UserItems] = [UserItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        allowsDocumentCreation = false
        allowsPickingMultipleItems = false

    }
    

    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    private func parseDocument(documentPath: URL) {
        if let parser = XMLParser(contentsOf: documentPath) {
                parser.delegate = self
                parser.parse()
            }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        parseDocument(documentPath: sourceURL)
        print(users.count)
        performSegue(withIdentifier:  Constants.SegueIds.showUsers, sender: users)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.SegueIds.showUsers{
            let destViewController = segue.destination as? UINavigationController
            let targetController = destViewController?.topViewController as? StartViewController
            guard let users = sender as? [UserProfile] else {return}
            targetController?.initializeViewModel(users:users)
        }
    }
}

extension DocumentBrowserViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if elementName == "user" {
            name = String()
            item.id = String()
            category.items = []
            userItems = []
            userCategory = []
            let userID = attributeDict["id"]
            self.currentUserID = (userID)!
        }
        if elementName == "ownedCategory" {
            category.items.removeAll()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "user" {
            let user = UserProfile(name: name, id: currentUserID, category: userCategory)
            print(user.name)
            print(user.category)
            users.append(user)
        }
        
        if elementName == "ownedCategory"{
            userCategory.append(category)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)

        if (!data.isEmpty) {
            if eName == "name" {
                name += data
            }
             else if eName == "item" {
                item.id = data
                userItems.append(item)
                category.items = userItems
                
             } else if eName == "ownedCategory" {
                    category.id = data
            }
        }
    }
}
