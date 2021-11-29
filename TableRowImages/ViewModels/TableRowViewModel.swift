//
//  TableRowViewModel.swift
//  TableRowImages
//
//  Created by Admin on 27/11/21.
//

import Foundation

protocol TableDataProtocol {
    func animateActivityIndicator(shouldLoad:Bool)
    func getTableResponse(data:TableData)
    func popUpAlertMessage(title:String,message:String,buttonTitle:String)
}

class TableRowViewModel {
    
    var delegate:TableDataProtocol?
    var vcDelegate : TableRowHomeViewController?
    var weatherObj = TableData()
    
    func getTableRowData(){
         self.vcDelegate?.animateActivityIndicator(shouldLoad: true)
        let url = WebConstants.tableDataUrl
        TableRowApiManager.getTableDateRowDetails(urlString: url) { [weak self]
            (response,error) in
            self?.vcDelegate?.animateActivityIndicator(shouldLoad: false)
            DispatchQueue.main.async{
            if let tableResponse = response{
                self?.delegate?.getTableResponse(data: tableResponse)
              }
            else{
                self?.vcDelegate?.popUpAlertMessage(title: "Error", message: error ?? "Something went wrong. Please try again later", buttonTitle: "OK")
            }
            }
        }
    }
}
