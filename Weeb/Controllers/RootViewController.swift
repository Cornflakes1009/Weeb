//
//  RootViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 9/8/21.
//

import UIKit
import StoreKit

class RootViewController: UIViewController {
    
    let backgroundView: UIImageView = {
        let image = UIImageView()
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weeb"
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
        label.textColor = whiteColor
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = whiteColor
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return button
    }()
    
    let playLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's play!"
        label.textColor = whiteColor
        label.textAlignment = .center
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More Apps", for: .normal)
        button.setTitleColor(whiteColor, for: .normal)
        button.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Bottom Stack View
    let supportButton: AppButton = {
        let button = AppButton(title: "Support")
        button.addTarget(self, action: #selector(supportTapped), for: .touchUpInside)
        return button
    }()
    
    let scoresButton: AppButton = {
        let button = AppButton(title: "Scores")
        button.addTarget(self, action: #selector(scoresTapped), for: .touchUpInside)
        return button
    }()
    
    let aboutButton: AppButton = {
        let button = AppButton(title: "About")
        button.addTarget(self, action: #selector(aboutTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenHeight = UIScreen.main.bounds.size.height
        screenWidth = UIScreen.main.bounds.size.width
        varyForScreenSizes(screenHeight: screenHeight)
        setupViews()
        
        playLabel.startBlink()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        // this is to handle dismissing any view controller back to this one
        resetGame()
        playLabel.startBlink()
        
        if completedGame && numOfGamesPlayed >= 3 {
            SKStoreReviewController.requestReview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playLabel.stopBlink()
    }
    
    @objc func willEnterForeground() {
        playLabel.stopBlink()
        playLabel.startBlink()
    }

    // MARK: - Setting Up Views
    private func setupViews() {
        cellHeight = screenHeight / 10
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        titleLabel.font = logoFont
        
        playButton.setImage(playButtonImage, for: .normal)
        view.addSubview(playButton)
        playButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(playLabel)
        playLabel.anchor(top: playButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        playLabel.centerXAnchor.constraint(equalTo: playButton.centerXAnchor).isActive = true
        playLabel.font = appFont
        
        setupBottomStackView()
        
        view.addSubview(moreButton)
        moreButton.anchor(top: nil, left: nil, bottom: bottomStackView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -20, paddingRight: 0, width: 300, height: 25)
        moreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK:- Setting Up the Bottom StackView
    var bottomStackView = UIStackView()
    func setupBottomStackView() {
        bottomStackView = UIStackView(arrangedSubviews: [aboutButton, scoresButton, supportButton])
        bottomStackView.distribution = .fillEqually
        bottomStackView.axis = .horizontal
        bottomStackView.alignment = .center
        bottomStackView.spacing = 5

        view.addSubview(bottomStackView)
        bottomStackView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: -10, paddingRight: 5, width: 0, height: 25)
        
        moreButton.titleLabel?.font  = secondaryButtonFont
        supportButton.titleLabel?.font  = secondaryButtonFont
        aboutButton.titleLabel?.font    = secondaryButtonFont
        scoresButton.titleLabel?.font   = secondaryButtonFont
    }
    
    // Button Actions
    @objc func playTapped() {
        let vc = AnimeListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moreTapped() {
        if let url = URL(string: appStoreLink) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func supportTapped() {
        let vc = SupportViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func scoresTapped() {
        let vc = ScoresViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func aboutTapped() {
        let vc = AboutViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
