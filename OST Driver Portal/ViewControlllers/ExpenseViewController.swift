//
//  ExpenseViewController.swift
//  OST Driver Portal
//
//  Created by Rizwan Ali on 18/02/2020.
//  Copyright © 2020 Rapidzz. All rights reserved.
//

import UIKit
import SideMenu

class ExpenseViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- VARIABLES
    var expences = ExpenseListViewModel()
    
    //MARK:- Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllExpences()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        // Define the menu
        let menu = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
        menu?.enableSwipeToDismissGesture = true
        menu?.leftSide = false
        present(menu!, animated: true, completion: nil)
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        getAllExpences()
//        mainContainer?.delegate = self
//        mainContainer?.setTitleAndButton(title: TitleName.Expenses, isHideBtnBack: false, isHideBtnHome: false)
//        mainContainer?.btnHome.setImage(UIImage(named: "more"), for: .normal)
//        
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        mainContainer?.btnHome.setImage(UIImage(named: "house"), for: .normal)
//    }
   
    //MARK:- Custom methods
    fileprivate func refreshData(_ expences: ExpenseListViewModel) {
        self.expences = expences
        print(expences.expenseList)
        if expences.expenseList.count > 0 {
            self.tableView.backgroundView = nil
        }else {
            self.tableView.setNoDataMessage()
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func addExpenseBtnAction(_ sender: UIButton) {
        callAddController()
    }
    
    func callAddController() {
//        let storyboard = UIStoryboard(name: StoryboardNames.Detail, bundle: nil)
        let addExpenseVC = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.AddExpenseViewController) as! AddExpenseViewController
        self.navigationController?.pushViewController(addExpenseVC, animated: true)
    }
    
    fileprivate func removeExpense(with id:Int) {
        if let index = expences.expenseList.firstIndex(where: {$0.id == id}) {
            self.expences.removeObjectWith(id: id)
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
    
    func callBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- API Calls
extension ExpenseViewController {
    fileprivate func getAllExpences() {
        let params:ParamsAny = [DictKeys.driver_id:Global.shared.user?.id ?? kIntDefault]
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        GCD.async(.Background) {
            ExpenseService.shared().loadAllExpenses(params: params) { (message, success, expences) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        self.refreshData(expences!)
                    }else {
                        self.tableView.setNoDataMessage(message)
//                        self.showAlertView(message: message)
                    }
                }
            }
        }
    }
    
    fileprivate func deleteExpense(with expenseId:Int) {
        ActivityIndicator.shared().show()
//        self.startActivityWithMessage()
        let params:ParamsAny = [DictKeys.expenseId:expenseId]
        GCD.async(.Background) {
            ExpenseService.shared().deleteExpense(params: params) { (message, success) in
                GCD.async(.Main) {
                    ActivityIndicator.shared().hide()
//                    self.stopActivity()
                    if success {
                        self.removeExpense(with: expenseId)
                    }
//                    self.showAlertView(message: message)
                }
            }
        }
    }
}

extension ExpenseViewController: ExpenseTableViewCellDelegate {
    func callViewDetail(_ expense:ExpenseViewModel) {
//        let storyboard = UIStoryboard(name: StoryboardNames.Detail, bundle: nil)
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.ViewDetailsViewController) as! ViewDetailsViewController
        Global.shared.expenseViewModel = expense
        detailvc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController?.navigationController?.present(detailvc, animated: true, completion: nil)
    }
    
    func callEditDetail(_ expense:ExpenseViewModel) {
//        let storyboard = UIStoryboard(name: StoryboardNames.Detail, bundle: nil)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.AddExpenseViewController) as! AddExpenseViewController
        controller.isEditExpense = true
        controller.expenseId = expense.id
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapDelete(_ expense: ExpenseViewModel) {
        
        // create the alert
        let alert = UIAlertController(title: ALERT_TITLE_APP_NAME, message: PopupMessages.deleteExpenseMessage, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                    self.deleteExpense(with: expense.id)
                }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
        
//        self.showAlertView(message: PopupMessages.deleteExpenseMessage, title: ALERT_TITLE_APP_NAME, doneButtonTitle: LocalStrings.Yes, doneButtonCompletion: { (_) in
//
//        }, cancelButtonTitle: LocalStrings.Cancel, cancelButtonCompletion: nil)
    }
    
}

//MARK:- ESTENSION TABLE VIEW METHOD
extension ExpenseViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expences.expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.expenseCell) as! ExpenseTableViewCell
        cell.configure(with: self.expences.expenseList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
