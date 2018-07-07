//
//  DetailViewController.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var authorLB: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    var detailEntry: Entry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard detailEntry != nil else { return }
        populateView()
    }
    
    func populateView() {
        self.titleLB.text = detailEntry.title
        self.authorLB.text = detailEntry.author
        self.postImageView.setImageFrom(link: detailEntry.thumbnail)
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        openFullImage()
    }
    
    private func openFullImage() {
        if let fullImage = detailEntry.fullImage {
            UIApplication.shared.open(URL(string : fullImage)!, options: [:], completionHandler: { (status) in })
        }
    }
}

