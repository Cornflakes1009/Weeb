//
//  TestViewController.swift
//  Weeb
//
//  Created by HaroldDavidson on 11/14/21.
//

import UIKit

class TestViewController: UIViewController {

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
    
    let testLabel:UILabel = {
        let label = UILabel()
        label.text = "Select the number of questions you'd like to answer."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = appFont
        label.textColor = whiteColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(instructionLabel)
        //instructionLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testLabel)
        NSLayoutConstraint.activate([
            testLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            testLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            testLabel.heightAnchor.constraint(equalToConstant: 200),
            testLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
