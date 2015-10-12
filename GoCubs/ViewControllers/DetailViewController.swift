//
//  DetailViewController.swift
//  GoCubs
//
//  Created by Ellen Shapiro (Vokal) on 9/29/15.
//  Copyright © 2015 Vokal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Properties

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var game: CubsGame? {
        didSet {
            // Update the view with the new detail item.
            self.configureViewForDetailItem()
        }
    }
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureViewForDetailItem()
    }

    //MARK: - Setup
    
    func configureViewForDetailItem() {
        if let cubsGame = self.game {
            if let label = self.detailDescriptionLabel {
                label.text = cubsGame.result.type.rawValue
            }
            
            self.title = dateFormatter.stringFromDate(cubsGame.date)
        }
    }
}
