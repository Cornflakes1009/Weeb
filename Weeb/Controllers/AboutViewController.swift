//
//  AboutViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/10/21.
//

import UIKit

class AboutViewController: UIViewController {

    let backgroundView: UIImageView = {
        let image = UIImageView()
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = whiteColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About Weeb"
        label.font = secondaryTitleFont
        label.textAlignment = .center
        label.textColor = whiteColor
        return label
    }()
    
    let aboutText = """
        Weeb is the product of this anime lover's endless hours watching anime. I made Weeb to share some trivia on some of my favorite shows and I hope that you'll enjoy it as much as I enjoyed making it. The trivia is purely based off the anime and normally English dubbed when available so sometimes that causes some mistakes. I do not own nor am I associated with any of the creators or owners of the shows from which the trivia was created. As time goes on, I will add more trivia as I complete more shows. Feel free to reach out to suggest shows, point out my mistakes, or just say 'hello!'.
        """
    
    let aboutTextView: UITextView = {
        let tv = UITextView()
        tv.font = appFont
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = true
        
        return tv
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    // MARK: - Setting Up Views
    private func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(aboutLabel)
        aboutLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        view.addSubview(aboutTextView)
        aboutTextView.anchor(top: aboutLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 0)
        
        //aboutTextView.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: screenHeight * 0.7)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        aboutTextView.attributedText = NSAttributedString(string: aboutText, attributes: attributes)
        aboutTextView.textColor = whiteColor
        aboutTextView.font = appFont
    }
    
    // MARK: - Button Functions
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        resetGame()
    }
}
