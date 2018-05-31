//
//  DocumentBrowserViewController.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 19.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import UIKit
import CSV


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        allowsDocumentCreation = false
        allowsPickingMultipleItems = false

    }
    

    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    private func parseCSV(documentPath: URL) ->[UserProfile] {
        
        do {
            let content = try String(contentsOf: documentPath, encoding: String.Encoding.utf8)
            let csvString = content
            let csv = try CSVReader(string: csvString,
                                     hasHeaderRow: true)
            
            if let headerRow = csv.headerRow {
            print("\(headerRow)")
            var users = [UserProfile]()
            while csv.next() != nil {
                guard let name = csv[Constants.CSVId.user], let mainCategory = csv[Constants.CSVId.mainCategory], let subCategory = csv[Constants.CSVId.subCategory], let detail = csv[Constants.CSVId.detail] else { return [UserProfile]()}
                let user = UserProfile(name: name, mainCategory: mainCategory, subCategory: subCategory, detail: detail)
                users.append(user)
                

                }
                return users
            }
           
        } catch let err {
            print(err)
        }
        return [UserProfile]()
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        let users = parseCSV(documentPath: sourceURL)
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

