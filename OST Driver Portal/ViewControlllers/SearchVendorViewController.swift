//
//  SearchVendorViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 25/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit

class SearchVendorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    weak var delegate: VendorsDelegate!
    var vendorList = [VendorViewModel]()
    var filteredList = [VendorViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filteredList = self.vendorList
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.txtSearch.addTarget(self, action: #selector(self.search), for: .editingChanged)
    }
    
    @IBAction func actionClose(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchVendorViewController {
    @objc fileprivate func search() {
        let text = self.txtSearch.text!
        if text.count > 0 {
            self.filteredList = self.vendorList.filter {$0.name.lowercased().contains(text.lowercased())}
        }else {
            self.filteredList = self.vendorList
        }
        self.tableView.reloadData()
    }
}

//MARK: - EXTENSION TABLE VIEW METHODS
extension SearchVendorViewController: UITableViewDelegate, UITableViewDataSource{
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("\(vendorArray.coun)")
        return self.filteredList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vendorCell =  tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.vendorCell) as! SearchVendorTableViewCell
        vendorCell.lblTitle.text = filteredList[indexPath.row].name

        return vendorCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if let del = self.delegate{
        delegate.didSelect(vendor: filteredList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    
}






