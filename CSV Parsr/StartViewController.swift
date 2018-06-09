//
//  StartViewController.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 19.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var userTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var viewModel: UsersViewModel?
    private var selectedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initializeViewModel(users:[UserProfile],categories:[Category], products: [Product]) {
        viewModel = UsersViewModel(users: users, categories: categories, products: products)
    }
    
    @IBAction func open(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UserTableViewController {
            guard let user = sender as? (UserProfile?,[String]?,[[String]]) else {return}
            destinationVC.configure(user: user.0!, categoryNames: user.1, itemNames: user.2)
        }
    }
}

extension StartViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//        performSegue(withIdentifier: "id", sender: viewModel?.users[indexPath.row])
//    }
}

extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: Constants.CellIds.tableView, for: indexPath) as? UserTableViewCell
        guard let user = viewModel?.users[indexPath.row] else {return UITableViewCell()}
        cell?.setUpView(user:user)
                return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
  
}

extension StartViewController: UICollectionViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryIds = viewModel?.users[indexPath.row].category.map{$0.id}
        let nieco = viewModel?.users[indexPath.row].category.map{$0.items}
       
        
        var result = [[String]]()
        for i in nieco!{
            let nieco = i.map{$0.id}
            let xxx = viewModel?.returnProductnames(ids: nieco)
            result.append(xxx!)
        }
        
        let sender = (viewModel?.users[indexPath.row],viewModel?.returnNameForCategory(id:categoryIds as! [String]), result)
        performSegue(withIdentifier: "id", sender: sender)
    }
    
}

extension StartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.categories.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIds.collectionView, for: indexPath) as? CategoryCollectionViewCell
        guard let category = viewModel?.categories[indexPath.row].name else {return
            UICollectionViewCell()}
        cell?.setUpView(dataName: category)
        return cell ?? UICollectionViewCell()
    }
    
    
}
