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
//        userTableView.isHidden = true
        categoryCollectionView.isHidden = true
        userTableViewConstraint.constant = -109
    }
    
    func initializeViewModel(users:[UserProfile]) {
        viewModel = UsersViewModel(users: users)
    }
    
    @IBAction func open(_ sender: UIButton) {
    }
    

}

extension StartViewController: UITableViewDelegate {
    
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
        categoryCollectionView.isHidden = false
        userTableViewConstraint.constant = 2
        selectedItem = indexPath.row
        categoryCollectionView.reloadData()
    }
    
}

extension StartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIds.collectionView, for: indexPath) as? CategoryCollectionViewCell
        guard let mainaCategory = viewModel?.users[selectedItem].mainCategory, let subCategory = viewModel?.users[selectedItem].subCategory else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
            cell?.setUpView(dataName:mainaCategory)
        } else if indexPath.row == 1{
            cell?.setUpView(dataName:subCategory)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    
}
