//
//  MasterViewController.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EntryDetailProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    let entryViewModel = EntryViewModel(entryRepo: WebEntryRepository.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        tableView.refreshControl?.beginRefreshing()
        fetchEntries()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshEntries),
                                            for: UIControlEvents.valueChanged)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if splitViewController!.isCollapsed {
            if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        self.tableView.reloadData()
    }
    
    @objc func refreshEntries() {
        fetchEntries()
    }
    
    private func fetchEntries() {
        entryViewModel.getAllEntries {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let entry = entryViewModel.entries?[indexPath.row] else { return }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailEntry = entry
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell
        let entry = entryViewModel.entries?[indexPath.row]
        cell.delegate = self
        cell.entry = entry
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let entry = entryViewModel.entries?[indexPath.row] {
            self.entryViewModel.markedRead(entry) {
                DispatchQueue.main.async {
                    tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                }
            }
        }
    }
    
    @IBAction func dismissAllBTNTapped(_ sender: Any) {
        clearAll()
    }
    
    private func clearAll() {
        self.entryViewModel.dismissAll {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - EntryDetailProtocol
    func dismissEntry(_ entry: Entry) {
        self.entryViewModel.dismissEntry(entry) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

