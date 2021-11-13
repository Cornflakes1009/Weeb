//
//  CategoryCell.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/6/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    var categoryImageView = UIView()
    var categoryImage = UIImageView()
    var cellButton = UIButton(type: .system)
    var cellView = UIView()
    var categoryLabel = UILabel()
    
    // MARK: - Initializing the Cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellView()
        configureCategoryLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(image: String) {
        categoryImage.image = UIImage(named: image)
    }
    
    // MARK: - Setting Up Views
    func configureCellView() {
        addSubview(cellView)
        cellView.alpha = 0.75
        cellView.layer.cornerRadius = 10
        cellView.backgroundColor = whiteColor
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowRadius = 5.0
        cellView.layer.shadowOpacity = 2.0
        cellView.layer.shadowOffset = CGSize(width: 6, height: 6)
        cellView.layer.masksToBounds = false
        
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cellView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    func configureCategoryLabel() {
        cellView.addSubview(categoryLabel)
        categoryLabel.font = boldFont
        categoryLabel.textColor = blackColor
        categoryLabel.alpha = 0.5
        categoryLabel.lineBreakMode = .byWordWrapping
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
    }
}
