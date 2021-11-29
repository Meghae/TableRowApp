//
//  TableRowHomeViewController.swift
//  TableRowImages
//
//  Created by Admin on 29/11/21.
//

import UIKit

class TableRowHomeViewController: UITableViewController {

    private let myArray: NSArray = ["First","Second","Third"]
    var tableRowViewModel = TableRowViewModel()
//    private var dataTableView: UITableView!
    private var tableArray = [Rows]()
    
    let cellId = "cellId"
    var products : [Rows]  = [Rows]()
    var tableActivityView = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

      

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableActivityView.center = self.view.center
        self.view.addSubview(tableActivityView)
        self.tableRowViewModel.delegate = self
        self.tableRowViewModel.vcDelegate = self
        tableView.register(RowDataTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.estimatedRowHeight = 150
        
        self.tableRowViewModel.getTableRowData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableArray.count != 0){
        return self.tableArray.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RowDataTableViewCell
        let tableDataItem = self.tableArray[indexPath.row]
        cell.row = tableDataItem
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 9 {
        return 350
    }else{
         return 200
    }
}
    
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

extension TableRowHomeViewController: TableDataProtocol {
   
   //  activity indicator loader
    func animateActivityIndicator(shouldLoad:Bool){
        if shouldLoad{
           DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = false
                self.view.alpha = 0.5
                self.tableActivityView.startAnimating()
            }
        }else{
          DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
                self.view.alpha = 1
                self.tableActivityView.stopAnimating()
            }
        }
    }
    
    // show popup alert message
    func popUpAlertMessage(title:String,message:String,buttonTitle:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //getting back the data from viewModel
    func getTableResponse(data:TableData){
        for obj in  data.rows ?? []{
            if obj.title != nil{
                self.tableArray.append(obj)
            }
        }
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.barTintColor = UIColor.lightGray
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: data.title ?? "" )
        navBar.setItems([navItem], animated: false)
        tableView.reloadData()
    }
}
