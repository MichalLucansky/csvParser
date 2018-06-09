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
        
        if elementName == "product"{
            name = String()
            let id = attributeDict["id"]
            self.currentProductDatabase.id = id!
        }
        
        if elementName == "category" {
            
            let categoryId = attributeDict["id"]
            let parentId = attributeDict["parent"]
            if  parentId?.isEmpty == false {
                self.curentDatabaseCategory.id = categoryId!
            }
        }
        
        if elementName == "name" {
//            name = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "user" {
            
            let user = UserProfile(name: name, id: currentUserID, category: userCategory)
            users.append(user)
        }
        
        if elementName == "ownedCategory"{
            userCategory.append(category)
            userItems.removeAll()
        }
        
        if elementName == "category" {
            dataBaseCategory.append(curentDatabaseCategory)
        }
        
        if elementName == "product" {
            self.currentProductDatabase.name = name
            dataBaseProduct.append(currentProductDatabase)
            name = String()
            print(currentProductDatabase.name)
            print(currentProductDatabase.id)
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines).filter{!"\n\t".contains($0)}.folding(options: .diacriticInsensitive, locale: .current)


        if (!data.isEmpty) {
            if eName == "name" {
                print(data)
                name += data
                curentDatabaseCategory.name = data
            }
             else if eName == "item" {
                item.id = data.filter{!" ".contains($0)}
                userItems.append(item)
                category.items = userItems
                
             } else if eName == "ownedCategory" {
                    category.id = data
            }
            
            if eName == "active" {
                curentDatabaseCategory.active = data
            }
            
//            if eName == "alternate" {
//                name = String()
//            }
        }
    }
}
