//
//  SupportViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/10/21.
//

import UIKit
import MessageUI

class SupportViewController: UIViewController, MFMailComposeViewControllerDelegate {

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
    
    let contactTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Us"
        label.font = secondaryTitleFont
        label.textAlignment = .center
        label.textColor = whiteColor
        return label
    }()
    
    let supportText = """
        Sometimes I make mistakes. Sometimes the app might crash or I made a typo. Sometimes I get trivia just wrong or the stories change. I am happy to hear from you so please don't hesitate to contact me!
        """
    
    let supportTextView: UITextView = {
        let tv = UITextView()
        tv.font = appFont
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = true
        
        return tv
    }()
    
    lazy var emailButton: QuestionButton = {
        let button = QuestionButton(title: "Email")
        button.titleLabel?.font = buttonFont
        button.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
        return button
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
        
        view.addSubview(contactTitleLabel)
        contactTitleLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        view.addSubview(supportTextView)
        supportTextView.anchor(top: contactTitleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 0)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        supportTextView.attributedText = NSAttributedString(string: supportText, attributes: attributes)
        supportTextView.textColor = whiteColor
        supportTextView.font = appFont
        
        view.addSubview(emailButton)
        emailButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: cellHeight)
    }
    
    // MARK: - Email Functionality
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["spelldevelopment@gmail.com"])
            mail.setSubject("Weeb")
            mail.setMessageBody("<p>Hello, Spell Development. I have a question, issue, or general inquiry.</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    
    // MARK: - Button Functions
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        resetGame()
    }
    
    @objc func emailTapped() {
        sendEmail()
    }
}
