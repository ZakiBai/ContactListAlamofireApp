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



    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

   
    // MARK: - Network Manager
    private func downloadData() {
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let contacts):
                self?.contacts = contacts
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    


}
