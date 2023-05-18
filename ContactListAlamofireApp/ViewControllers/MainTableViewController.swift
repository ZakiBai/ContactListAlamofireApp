//
//  MainTableViewController.swift
//  ContactListAlamofireApp
//
//  Created by Zaki on 18.05.2023.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var contacts: [Contact] = []
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        downloadData()
        setupRefreshControl()

    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailContactViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let contact = contacts[indexPath.row]
        detailVC.contact = contact
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 120, height: 120)
        content.imageProperties.cornerRadius = 60
        
        let contact = contacts[indexPath.row]
        content.text = contact.name.first
        content.secondaryText = contact.name.last

        guard let url = URL(string: contact.picture.medium) else { return UITableViewCell() }
        
        networkManager.fetchData(from: url) { result in
            switch result {
            case .success(let imageData):
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        cell.contentConfiguration = content
        return cell
    }
   
    // MARK: - Network Manager
    private func downloadData() {
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let contacts):
                self?.contacts = contacts
                self?.tableView.reloadData()
                if self?.refreshControl != nil {
                    self?.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        let refreshAction = UIAction { [unowned self] _ in
            downloadData()
        }
        refreshControl?.addAction(refreshAction, for: .valueChanged)
    }


}
