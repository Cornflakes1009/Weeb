//
//  QuestionViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/10/21.
//

import UIKit
import GoogleMobileAds

class QuestionViewController: UIViewController, GADBannerViewDelegate {

    private var interstitial: GADInterstitialAd?
    
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
    
    let questionNumberLabel: UILabel = {
        let label = UILabel()
        //label.font = labelFont
        label.textAlignment = .right
        label.textColor = whiteColor
        return label
    }()
    
    var bannerView: GADBannerView!
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "\(questionList[questionIndex].question)"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = whiteColor
        label.font = appFont
        return label
    }()
    
    lazy var optionOneButton: AppButton = {
        let button = AppButton(title: "\(questionList[questionIndex].optionOne)")
        button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var optionTwoButton: AppButton = {
        let button = AppButton(title: "\(questionList[questionIndex].optionTwo)")
        button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK:- Correct Answer View
    let correctAnswerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.backgroundColor = UIColor(patternImage:  popupBackgroundImage!)
        view.layer.cornerRadius = 10
        view.alpha = 0
        view.isOpaque = true
        return view
    }()
    
    let correctAnswerTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry, the correct answer was:"
        label.font = appFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let correctAnswerLabel: UILabel = {
        let label = UILabel()
        label.text = "\(questionList[questionIndex].answer)"
        label.font = appFont
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var nextQuestionButton: AppButton = {
        let button = AppButton(title: "Next Question")
        button.addTarget(self, action: #selector(nextQuestionTapped), for: .touchUpInside)
        button.titleLabel?.font = buttonFont
        return button
    }()
    
    // MARK:- Exit Confirmation
    let exitConfirmationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(patternImage:  popupBackgroundImage!)
        view.alpha = 0
        view.isOpaque = true
        return view
    }()
    
    let exitConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you wish to exit? This will exit the game and you'll lose your current progress"
        label.font = appFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = whiteColor
        return label
    }()
    
    lazy var exitGameCancel: AppButton = {
        let button = AppButton(title: "Cancel")
        button.setTitleColor(blackColor, for: .normal)
        button.titleLabel?.font = buttonFont
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.borderColor = whiteColor.cgColor
        button.titleLabel?.layer.shadowRadius = 0.5
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var exitGameConfirm: AppButton = {
        let button = AppButton(title: "Exit")
        button.setTitleColor(blackColor, for: .normal)
        button.titleLabel?.font = buttonFont
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.rgb(red: 255, green: 0, blue: 0, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 0.5
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupBannerView()
        
        numOfGamesPlayed += 1
        defaults.setValue(numOfGamesPlayed, forKey: "numOfGamesPlayed")
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: interstitialAdUnitID,
                               request: request,
                               completionHandler: { [self] ad, error in
                                if let error = error {
                                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                    return
                                }
                                interstitial = ad
                               }
        )
        
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers =
            [ "ca-app-pub-3940256099942544/4411468910" ] // Sample device ID
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        updateUI()
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        backButton.setImage(backButtonImage, for: .normal)
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(questionNumberLabel)
        questionNumberLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 100, height: 40)
        
        view.addSubview(questionLabel)
        questionLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 150)
        questionLabel.sizeToFit()
        
        setupQuestionStackView()
    }
    
    // MARK:- Setting Up the StackView
    var questionStackView = UIStackView()
    func setupQuestionStackView() {
        questionStackView = UIStackView(arrangedSubviews: [optionOneButton, optionTwoButton])
        questionStackView.distribution = .fillEqually
        questionStackView.axis = .vertical
        questionStackView.spacing = 10
        let buttonCount = questionStackView.arrangedSubviews.count
        
        view.addSubview(questionStackView)
        questionStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        questionStackView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: CGFloat(buttonCount) * cellHeight)
    }
    
    // MARK: - Updating the question label and buttons after each question tapped
    func updateUI() {
        questionLabel.text = "\(questionList[questionIndex].question)"
        optionOneButton.setTitle(questionList[questionIndex].optionOne, for: .normal)
        optionTwoButton.setTitle(questionList[questionIndex].optionTwo, for: .normal)
        
        questionNumberLabel.text = "\(questionIndex + 1)/\(questionList.count)"
    }
    
    // MARK:- Show Correct Answer View
    func showCorrectAnswer() {
        backButton.isEnabled = false
        view.addSubview(correctAnswerView)
        correctAnswerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        UIView.animate(withDuration: 0.5) {
            self.correctAnswerView.alpha = popUpViewAlpha
        }
        
        let currentCorrectAnswer = questionList[questionIndex].answer
        if currentCorrectAnswer == 0 {
            correctAnswerLabel.text = "\(questionList[questionIndex].optionOne)"
        } else if currentCorrectAnswer == 1 {
            correctAnswerLabel.text = "\(questionList[questionIndex].optionTwo)"
        }
        
        correctAnswerView.addSubview(correctAnswerTopLabel)
        correctAnswerTopLabel.anchor(top: correctAnswerView.topAnchor, left: correctAnswerView.leftAnchor, bottom: nil, right: correctAnswerView.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 100)
        
        correctAnswerView.addSubview(correctAnswerLabel)
        correctAnswerLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        correctAnswerLabel.centerXAnchor.constraint(equalTo: correctAnswerView.centerXAnchor).isActive = true
        correctAnswerLabel.centerYAnchor.constraint(equalTo: correctAnswerView.centerYAnchor).isActive = true
        
        correctAnswerView.addSubview(nextQuestionButton)
        nextQuestionButton.anchor(top: nil, left: correctAnswerView.leftAnchor, bottom: correctAnswerView.bottomAnchor, right: correctAnswerView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: -20, paddingRight: 10, width: 0, height: cellHeight)
    }
    
    // MARK:- Exit View
    func presentBackConfirmationsView() {
        backButton.isEnabled = false
        view.addSubview(exitConfirmationView)
        exitConfirmationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)

        exitConfirmationView.addSubview(exitConfirmationLabel)
        exitConfirmationLabel.anchor(top: exitConfirmationView.topAnchor, left: exitConfirmationView.leftAnchor, bottom: nil, right: exitConfirmationView.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingBottom: 0, paddingRight: 20, width: 0, height: 200)
        
        setupExitStackView()
        
        UIView.animate(withDuration: 0.5) {
            self.exitConfirmationView.alpha = popUpViewAlpha
        }
    }
    
    // MARK:- Exit StackView
    var exitStackView = UIStackView()
    func setupExitStackView() {
        exitStackView = UIStackView(arrangedSubviews: [exitGameCancel, exitGameConfirm])
        let exitStackViewWidth = UIScreen.main.bounds.size.width - 80
        exitStackView.distribution = .fillEqually
        exitStackView.axis = .horizontal
        exitStackView.spacing = 10
        
        exitConfirmationView.addSubview(exitStackView)
        exitStackView.centerXAnchor.constraint(equalTo: exitConfirmationView.centerXAnchor).isActive = true
        exitStackView.centerYAnchor.constraint(equalTo: exitConfirmationView.centerYAnchor).isActive = true
        exitStackView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: exitStackViewWidth, height: cellHeight)
    }
    
    // MARK:- Check if Answer Tapped is Correct
    func checkIfCorrect(buttonNumber: Int) {
        totalNumberOfQuestions += 1
        defaults.setValue(totalNumberOfQuestions, forKey: "totalNumberOfQuestions")
        
        if buttonNumber == questionList[questionIndex].answer {
            totalNumberOfCorrect += 1
            correctlyAnswered += 1
            defaults.setValue(totalNumberOfCorrect, forKey: "totalNumberOfCorrect")
            if questionIndex + 1 != questionList.count {
                questionIndex += 1
                updateUI()
            } else {
                showInterstitial()
                
                let vc = ResultsViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showCorrectAnswer()
        }
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
        bannerView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    // MARK: - Button Functions
    @objc func backTapped() {
        presentBackConfirmationsView()
    }
    
    @objc func answerTapped(_ sender: UIButton!) {
        // check if selected button has correct answer, if not, present a view with correct answer
        if sender == optionOneButton {
            checkIfCorrect(buttonNumber: 0)
        } else if sender == optionTwoButton {
            checkIfCorrect(buttonNumber: 1)
        }
    }
    
    @objc func nextQuestionTapped() {
        if questionIndex + 1 != questionList.count {
            questionIndex += 1
            updateUI()
        } else {
            showInterstitial()
            
            let vc = ResultsViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        
        UIView.animate(withDuration: 1) {
            self.correctAnswerView.alpha = 0
        }
        backButton.isEnabled = true
    }
    
    @objc func confirmTapped() {
        resetGame()
        dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func cancelTapped() {
        UIView.animate(withDuration: 1) {
            self.exitConfirmationView.alpha = 0
        }
        backButton.isEnabled = true
    }
    
    // MARK:- AdMob Functions
    func showInterstitial() {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
}
