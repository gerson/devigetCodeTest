//
//  EntryTableViewCell.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 06/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import UIKit

protocol EntryDetailProtocol: class {
    func dismissEntry(_ entry: Entry)
}

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var readStatusView: UIView!
    @IBOutlet weak var usernameLB: UILabel!
    @IBOutlet weak var postedTimeLB: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var dismissBTN: UIButton!
    @IBOutlet weak var numOfCommentsLB: UILabel!
    weak var delegate: EntryDetailProtocol?
    
    var entry: Entry! {
        didSet {
            self.usernameLB.text = entry.author
            self.postedTimeLB.text = entry.createdAt?.timeAgo() ?? ""
            self.titleLB.text = entry.title
            self.thumbnailImageView.setImageFrom(link: entry.thumbnail)
            self.numOfCommentsLB.text = "\(entry.numOfcomments ?? 0) comments"
            readStatusView.isHidden = false
            if let isRead = self.entry.read, isRead {
                readStatusView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readStatusView.layer.masksToBounds = true
        readStatusView.layer.cornerRadius = readStatusView.frame.size.width/2
    }
    
    @IBAction func dismissBTNTapped(_ sender: Any) {
        self.delegate?.dismissEntry(entry)
    }
    
}
