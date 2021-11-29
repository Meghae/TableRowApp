//
//  RowDataTableViewCell.swift
//  TableRowImages
//
//  Created by Admin on 28/11/21.
//

import UIKit
import Alamofire

class RowDataTableViewCell: UITableViewCell {
    private var arrayOfImages = [UIImage]()
    
    var row : Rows? {
        didSet {
            if let url = URL(string: row?.imageHref ?? ""){
                self.downloadImage(from: url)
            }
            rowNameLabel.text = row?.title
            rowDescriptionLabel.text = row?.titleDescription
        }
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() {
                if let image = UIImage(data: data){
                    self.arrayOfImages.append(image)
                    self.rowImage.image = image
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
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

