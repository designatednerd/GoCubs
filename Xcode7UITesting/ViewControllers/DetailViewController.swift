//
//  DetailViewController.swift
//  Xcode7UITesting
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Properties

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var detailItem: AnyObject? {
        didSet {
            // Update the view with the new detail item.
            self.configureViewForDetailItem()
        }
    }

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureViewForDetailItem()
    }

    //MARK: - Setup
    
    func configureViewForDetailItem() {
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
}
