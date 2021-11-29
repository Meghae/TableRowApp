//
//  TableRowHomeViewController.swift
//  TableRowImages
//
//  Created by Admin on 29/11/21.
//

import UIKit

class TableRowHomeViewController: UITableViewController {
    
    var tableRowViewModel = TableRowViewModel()
    private var tableArray = [Rows]()
    private var arrayOfImages = [UIImage]()
    
    let cellId = "cellId"
    var products : [Rows]  = [Rows]()
    var tableActivityView = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RowTableViewCell", bundle: nil), forCellReuseIdentifier: "RowTableViewCell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableActivityView.center = self.view.center
        self.view.addSubview(tableActivityView)
        self.tableRowViewModel.delegate = self
        self.tableRowViewModel.vcDelegate = self
        self.tableRowViewModel.getTableRowData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableArray.count != 0){
            return self.tableArray.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableDataItem = self.tableArray[indexPath.row]
        let cellIdentifier = "RowTableViewCell"
        var cell:RowTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RowTableViewCell
        if(cell == nil)
        {
            let nibArray:NSArray!  = Bundle.main.loadNibNamed(cellIdentifier, owner: self, options:nil) as NSArray?
            cell = nibArray.object(at: 0) as? RowTableViewCell
        }
        cell.displayTitleLabel.text = tableDataItem.title
        cell.displaySubTitleLabel.text = tableDataItem.titleDescription
        
        if let url = URL(string: tableDataItem.imageHref ?? ""){
            self.downloadImage(from: url, cell: cell)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 8 {
            return 350
        }else{
            return 220
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

extension TableRowHomeViewController: TableDataProtocol {
    
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
            if obj.title != nil {
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
    
    func downloadImage(from url: URL, cell:RowTableViewCell) {
        getData(from: url) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() {
                if let image = UIImage(data: data){
                    cell.displayImg.image = image
                }else{
                    cell.displayImg.image = UIImage(named: "desert")
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
