//
//  DetailContactViewController.swift
//  ContactListAlamofireApp
//
//  Created by Zaki on 18.05.2023.
//

import UIKit
import AlamofireImage

final class DetailContactViewController: UIViewController {
    
    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var contactNameLabel: UILabel!
    
    var contact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: contact)
    }
    
    override func viewWillLayoutSubviews() {
        contactImage.layer.cornerRadius = contactImage.bounds.height / 2
    }
    
    private func configure(with contact: Contact) {
        contactNameLabel.text = "\(contact.name.first) \(contact.name.last)"
        
        guard let imageURL = URL(string: contact.picture.large) else { return }
        contactImage.af.setImage(withURL: imageURL)
    }
}

        
