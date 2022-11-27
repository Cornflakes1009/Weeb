//
//  ScoresViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/10/21.
//

import UIKit

class ScoresViewController: UIViewController {
    
    let percentageAnsweredCorrectly = round(Double(totalNumberOfCorrect) / Double(totalNumberOfQuestions) * 100)
    
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
    
    // MARK:- Scores
    let scoresTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Scores"
        label.font = secondaryTitleFont
        label.textAlignment = .center
        label.textColor = whiteColor
        return label
    }()
    
    let totalNumberOfQuestionsLabel: UILabel = {
        let label = UILabel()
        label.font = appFont
        label.textColor = whiteColor
        label.text = "Questions Answered: \(totalNumberOfQuestions)"
        return label
    }()
    
    let totalNumberCorrectLabel: UILabel = {
        let label = UILabel()
        label.font = appFont
        label.textColor = whiteColor
        label.text = "Correctly Answered: \(totalNumberOfCorrect)"
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = appFont
        label.textColor = whiteColor
        return label
    }()
    
    let numOfGamesPlayedLabel: UILabel = {
        let label = UILabel()
        label.font = appFont
        label.textColor = whiteColor
        label.text = "Games Played: \(numOfGamesPlayed)"
        return label
    }()
    
    lazy var resetScoresButton: QuestionButton = {
        let button = QuestionButton(title: "Reset All Scores")
        button.addTarget(self, action: #selector(backtoMenuTapped), for: .touchUpInside)
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
        
        view.addSubview(scoresTitleLabel)
        scoresTitleLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        setupStackView()
    }
    
    // MARK:- StackView
    var stackView = UIStackView()
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [totalNumberCorrectLabel, totalNumberOfQuestionsLabel, numOfGamesPlayedLabel, percentageLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        let stackViewHeight = screenHeight * 0.5
        
        if percentageAnsweredCorrectly.isNaN {
            percentageLabel.text = "Percent Correct: N/A"
        } else {
            percentageLabel.text = "Percent Correct: \(percentageAnsweredCorrectly)%"
        }
        
        view.addSubview(stackView)
        stackView.anchor(top: scoresTitleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: stackViewHeight)
    }
    
    // MARK: - Button Functions
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        resetGame()
    }
    
    @objc func backtoMenuTapped() {
        resetGame()
        dismiss(animated: true, completion: nil)
        
    }
}
