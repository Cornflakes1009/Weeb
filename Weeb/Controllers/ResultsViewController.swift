//
//  ResultsViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/10/21.
//

import UIKit

class ResultsViewController: UIViewController {

    let backgroundView: UIImageView = {
        let image = UIImageView()
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your final score was:"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = whiteColor
        label.font = secondaryTitleFont
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(correctlyAnswered)/\(questionList.count)"
        label.textAlignment = .center
        label.textColor = whiteColor
        label.font = finalScoreFont
        return label
    }()
    
    let shareButton: AppButton = {
        let button = AppButton(title: "Share")
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    let backToMenuButton: QuestionButton = {
        let button = QuestionButton(title: "Back to Menu")
        button.addTarget(self, action: #selector(backtoMenuTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        completedGame = true
    }
    
    // MARK: - Setting Up Views
    private func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(backToMenuButton)
        backToMenuButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: cellHeight)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 200)
        
        view.addSubview(scoreLabel)
        scoreLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        view.addSubview(shareButton)
        shareButton.anchor(top: nil, left: nil, bottom: backToMenuButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: screenWidth * 0.3, height: cellHeight / 2)
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Button Actions
    @objc func shareTapped() {
        let items = ["Look at my score! \(correctlyAnswered)/\(questionList.count) \n\n\(weebLink)"]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func backtoMenuTapped() {
        resetGame()
        dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
