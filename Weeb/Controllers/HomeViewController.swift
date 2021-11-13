//
//  HomeViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/6/21.
//

import UIKit

class AnimeListViewController: UIViewController {
    
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
        label.font = titleFont
        label.textColor = whiteColor
        //label.backgroundColor = UIColor.rgb(red: 255, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
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
    
    var tableView = UITableView()
    
    let peekingView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "anime peeking face.png")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        // this is to handle dismissing any view controller back to this one
        questionList.removeAll()
    }

    // MARK: - Setting Up Views
    private func setupViews() {
        screenHeight = UIScreen.main.bounds.size.height
        cellHeight = screenHeight / 10
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        setupBottomStackView()
        
        view.addSubview(tableView)
        //tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: bottomStackView.topAnchor, right: view.rightAnchor, paddingTop: screenHeight / 2, paddingLeft: 0, paddingBottom: -10, paddingRight: 0, width: 0, height: 0)
        tableView.anchor(top: nil, left: view.leftAnchor, bottom: bottomStackView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: screenHeight / 2)
        
        //view.addSubview(peekingView)
        //peekingView.anchor(top: nil, left: nil, bottom: tableView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        //peekingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    }
    
    // Button Actions
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

extension AnimeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        //cell.set(image: images[indexPath.row])
        //print(categories[indexPath.row])
        
        cell.categoryLabel.text = categories[indexPath.row].uppercased()
        cell.categoryLabel.font = buttonFont
        cell.backgroundColor = .clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Cell tapped: \(indexPath.row)")
        vibrate()
        print(categories[indexPath.row])
        convertJSON(jsonToRead: categories[indexPath.row])
        print(questionList.count)
        if questionList.count < 25 {
            let vc = QuestionViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = QuestionSelectionViewController()
            //vc.jsonString = categories[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.rowHeight = cellHeight
        tableView.isUserInteractionEnabled = true
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.backgroundColor = .none
    }
}
