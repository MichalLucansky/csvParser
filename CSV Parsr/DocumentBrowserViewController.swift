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
    var currentProductDatabase = Product()
    var dataBaseProduct = [Product]()
    var dataBaseCategory = [Category]()
    var curentDatabaseCategory = Category()
    var curreneDatabaseCategoryId = String()
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
        
        let data = try! String(contentsOf: documentPath)
       let xxx = data.filter{!"\n\t".contains($0)}.folding(options: .diacriticInsensitive, locale: .current)
        let yyy = Data(xxx.utf8)
         let parser = XMLParser(data: yyy)
                parser.delegate = self
                parser.parse()
        
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        parseDocument(documentPath: sourceURL)
        let data = (users, dataBaseCategory, dataBaseProduct)
        performSegue(withIdentifier:  Constants.SegueIds.showUsers, sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.SegueIds.showUsers{
            let destViewController = segue.destination as? UINavigationController
            let targetController = destViewController?.topViewController as? StartViewController
            guard let users = sender as? ([UserProfile],[Category],[Product]) else {return}
            targetController?.initializeViewModel(users:users.0, categories: users.1, products: users.2)
        }
    }
}

extension DocumentBrowserViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if elementName == "user" {
            name = String()
            item.id = String()
            userItems = []
            userCategory = []
            let userID = attributeDict["id"]
            self.currentUserID = (userID)!
        }
        if elementName == "ownedCategory" {
            category.items.removeAll()
        }
        
        if elementName == "category" {
            let categoryId = attributeDict["id"]
            let parentId = attributeDict["parent"]
            if categoryId != nil && parentId != nil {
                self.curentDatabaseCategory.id = categoryId!
            } else {
                self.currentProductDatabase.id = categoryId!
                 dataBaseProduct.append(currentProductDatabase)
            }
            
            
        }

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "user" {
            
            let user = UserProfile(name: name, id: currentUserID, category: userCategory)
//            print(user.name)
//            print(user.category)
            users.append(user)
        }
        
        if elementName == "ownedCategory"{
            userCategory.append(category)
            userItems.removeAll()
        }
        
        if elementName == "category" {
//            print(curentDatabaseCategory.name, curentDatabaseCategory.id, curentDatabaseCategory)
            print(currentProductDatabase.name, currentProductDatabase.id)
            dataBaseCategory.append(curentDatabaseCategory)
//            dataBaseProduct.append(currentProductDatabase)
            
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.filter{!"\n\t".contains($0)}.folding(options: .diacriticInsensitive, locale: .current)


        if (!data.isEmpty) {
            if eName == "name" {
                name += data
                curentDatabaseCategory.name = data
                currentProductDatabase.name = data
            }
             else if eName == "item" {
               
                item.id = data
                userItems.append(item)
                category.items = userItems
                
             } else if eName == "ownedCategory" {
                    category.id = data
            }
            
            if eName == "active" {
                curentDatabaseCategory.active = data
            }
            
            if eName == "category" {
               
            }
        }
    }
}
