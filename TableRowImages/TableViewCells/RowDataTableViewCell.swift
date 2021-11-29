//
//  RowDataTableViewCell.swift
//  TableRowImages
//
//  Created by Admin on 28/11/21.
//

import UIKit
import Alamofire

class RowDataTableViewCell: UITableViewCell {
    
    var row : Rows? {
        didSet {
            //            if let url = URL(string: row?.imageHref ?? ""){
            //                DispatchQueue.global().async {
            //                    if let data = try? Data(contentsOf: url) {
            //                        DispatchQueue.main.async {
            //                            self.rowImage.image = UIImage(data: data)
            //                        }
            //                    }else{
            //                        DispatchQueue.main.async {
            //                            let image = UIImage(named: "desert")
            //                            self.rowImage.image =  image
            //                        }
            //                    }
            //                }
            //            }
            //
            
            if  let url = URL(string: row?.imageHref ?? ""){

                 DispatchQueue.global().async {
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                    if let data = data {
                        DispatchQueue.main.async {
                            self?.rowImage.image = UIImage(data: data)
                        }
                    }else {
                           DispatchQueue.main.async {
                        let image = UIImage(named: "desert")
                        self?.rowImage.image = image
                        }
                    }
                }
                dataTask.resume()
            }
    }
            
//            Alamofire.request(row?.imageHref ?? "").response { response in
//                if let data = response.data {
//                    let image = UIImage(data: data)
//                    self.rowImage.image = image
//                } else {
//                    let image = UIImage(named: "desert")
//                    self.rowImage.image = image
//                }
//            }
           
            rowNameLabel.text = row?.title
            rowDescriptionLabel.text = row?.titleDescription
        }
    }
    
    private let rowNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let rowDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let rowImage : UIImageView = {
        let image = UIImage(named: "")
        let imgView = UIImageView.init(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rowImage)
        addSubview(rowNameLabel)
        addSubview(rowDescriptionLabel)
        rowImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 80, enableInsets: false)
        rowNameLabel.anchor(top: topAnchor, left: rowImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width - 100, height: 0, enableInsets: false)
        rowDescriptionLabel.anchor(top: rowNameLabel.bottomAnchor, left: rowImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width - 100, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}















////
////  ProductCell.swift
////  Sample_TableView
////
////  Created by Esat Kemal Ekren on 5.04.2018.
////  Copyright © 2018 Esat Kemal Ekren. All rights reserved.
////
//
//import UIKit
//
//protocol ProductCellDelegate {
//    func increaseNumber(cell: ProductCell,number : Int)
//    func decreaseNumber(cell: ProductCell,number : Int)
//}
//
//class ProductCell : UITableViewCell {
//    var delegate : ProductCellDelegate?
//    let minValue = 0
//
//    var product : Product? {
//        didSet {
//            productImage.image = product?.productImage
//            productNameLabel.text = product?.productName
//            productDescriptionLabel.text = product?.productDesc
//        }
//    }
//
//
//    private let productNameLabel : UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.boldSystemFont(ofSize: 16)
//        lbl.textAlignment = .left
//        return lbl
//    }()
//
//
//    private let productDescriptionLabel : UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 16)
//        lbl.textAlignment = .left
//        lbl.numberOfLines = 0
//        return lbl
//    }()
//
//    //    private let decreaseButton : UIButton = {
//    //        let btn = UIButton(type: .custom)
//    //        btn.setImage(#imageLiteral(resourceName: "minusTb"), for: .normal)
//    //        btn.imageView?.contentMode = .scaleAspectFill
//    //        return btn
//    //    }()
//    //
//    //    private let increaseButton : UIButton = {
//    //        let btn = UIButton(type: .custom)
//    //        btn.setImage(#imageLiteral(resourceName: "addTb"), for: .normal)
//    //        btn.imageView?.contentMode = .scaleAspectFill
//    //        return btn
//    //    }()
//    //    var productQuantity : UILabel =  {
//    //        let label = UILabel()
//    //        label.font = UIFont.boldSystemFont(ofSize: 16)
//    //        label.textAlignment = .left
//    //        label.text = "1"
//    //        label.textColor = .black
//    //        return label
//    //
//    //    }()
//
//    private let productImage : UIImageView = {
//        let imgView = UIImageView(image: #imageLiteral(resourceName: "glasses"))
//        imgView.contentMode = .scaleAspectFit
//        imgView.clipsToBounds = true
//        return imgView
//    }()
//
//    //    @objc func decreaseFunc() {
//    //        changeQuantity(by: -1)
//    //
//    //    }
//    //
//    //    @objc func increaseFunc() {
//    //        changeQuantity(by: 1)
//    //    }
//    //
//
//    //    func changeQuantity(by amount: Int) {
//    //        var quality = Int(productQuantity.text!)!
//    //        quality += amount
//    //        if quality < minValue {
//    //            quality = 0
//    //            productQuantity.text = "0"
//    //        } else {
//    //            productQuantity.text = "\(quality)"
//    //        }
//    //        delegate?.decreaseNumber(cell: self, number: quality)
//    //
//    //    }
//
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(productImage)
//        addSubview(productNameLabel)
//        addSubview(productDescriptionLabel)
//        //        addSubview(decreaseButton)
//        //        addSubview(productQuantity)
//        //        addSubview(increaseButton)
//
//        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
//        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
//        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
//
//
//        //        let stackView = UIStackView(arrangedSubviews: [decreaseButton,productQuantity,increaseButton])
//        //        stackView.distribution = .equalSpacing
//        //        stackView.axis = .horizontal
//        //        stackView.spacing = 5
//        //        addSubview(stackView)
//        //        stackView.anchor(top: topAnchor, left: productNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
//
//        //        increaseButton.addTarget(self, action: #selector(increaseFunc), for: .touchUpInside)
//        //        decreaseButton.addTarget(self, action: #selector(decreaseFunc), for: .touchUpInside)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//}
