//
//  QuestionSelectionViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/10/21.
//

import UIKit
import GoogleMobileAds

class QuestionSelectionViewController: UIViewController, GADBannerViewDelegate {
    
    var jsonString = ""
    var buttonsArray = [UIButton]()
    
    let backgroundView: UIImageView = {
        let image = UIImageView()
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = whiteColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Select the number of questions you'd like to answer."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = appFont
        label.textColor = whiteColor
        return label
    }()
    
    var bannerView: GADBannerView!
    
    let tenQuestionButton: QuestionButton = {
        let button = QuestionButton(title: "10 QUESTIONS")
        button.addTarget(self, action: #selector(tenQuestionsTapped), for: .touchUpInside)
        return button
    }()
    
    let twentyFiveQuestionButton: QuestionButton = {
        let button = QuestionButton(title: "25 QUESTIONS")
        button.addTarget(self, action: #selector(twentyFiveQuestionsTapped), for: .touchUpInside)
        return button
    }()
    
    let fiftyQuestionButton: QuestionButton = {
        let button = QuestionButton(title: "50 QUESTIONS")
        button.addTarget(self, action: #selector(fiftyQuestionsTapped), for: .touchUpInside)
        return button
    }()
    
    let allQuestionButton: QuestionButton = {
        let button = QuestionButton(title: "All QUESTIONS (\(questionList.count))")
        button.addTarget(self, action: #selector(allQuestionsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBannerView()
    }
    
    // MARK: - Setting Up Views
    private func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(instructionLabel)
        instructionLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 100)
        
        setupStackView()
    }
    
    // MARK:- Setting Up the StackView
    var stackView = UIStackView()
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: countQuestions())
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        let buttonCount = buttonsArray.count
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: CGFloat(buttonCount) * cellHeight)
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Setup Banner
    private func setupBannerView() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = bannerAdUnitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        bannerView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func countQuestions() -> [UIButton] {
        if questionList.count >= 50 {
            buttonsArray = [tenQuestionButton, twentyFiveQuestionButton, fiftyQuestionButton, allQuestionButton]
        } else if questionList.count >= 25 {
            buttonsArray = [tenQuestionButton, twentyFiveQuestionButton, allQuestionButton]
        }
        return buttonsArray
    }
    
    private func segueToQuestionVC() {
        let vc = QuestionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Button Functions
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
        resetGame()
    }
    
    @objc func tenQuestionsTapped() {
        pickNumberOfQuestions(numberOfQuestions: 10)
        segueToQuestionVC()
    }
    
    @objc func twentyFiveQuestionsTapped() {
        pickNumberOfQuestions(numberOfQuestions: 25)
        segueToQuestionVC()
    }
    
    @objc func fiftyQuestionsTapped() {
        pickNumberOfQuestions(numberOfQuestions: 50)
        segueToQuestionVC()
    }
    
    @objc func allQuestionsTapped() {
        pickNumberOfQuestions(numberOfQuestions: questionList.count)
        segueToQuestionVC()
    }
}
