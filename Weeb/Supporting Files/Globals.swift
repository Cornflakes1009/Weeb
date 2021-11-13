//
//  Globals.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/6/21.
//

import UIKit

// MARK: - AdMob
let bannerAdUnitID          = "ca-app-pub-6504174477930496/2326071089"
let interstitialAdUnitID    = "ca-app-pub-6504174477930496/5401997467"
let appID                   = "ca-app-pub-6504174477930496~8704600611"

// MARK: - Images
let backgroundImage = UIImage(named: "wallpaper")!
let popupBackgroundImage = UIImage(named: "crissXcross")
let stardustImage = UIImage(named: "stardust")

// MARK: - Colors
let whiteColor      = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 1)
let frostColor      = UIColor.rgb(red: 255, green: 255, blue: 255, alpha: 0.1)
let backGroundColor = UIColor.rgb(red: 235, green: 156, blue: 24, alpha: 1)
let grayColor       = UIColor.rgb(red: 87, green: 87, blue: 89, alpha: 1)
let blackColor      = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 1)
let lightPinkColor  = UIColor.rgb(red: 255, green: 216, blue: 230, alpha: 1)

// MARK: - Sizes
var screenHeight: CGFloat       = 0
var cellHeight: CGFloat         = 0
var aboutImageHeight: CGFloat   = 0
var inputHeight: CGFloat        = 0

// MARK: - Fonts
let boldFont            = UIFont.preferredFont(forTextStyle: .headline).bold()
var logoFont            = UIFont(name: "Pocket Monk", size: 92)
var appFont             = UIFont(name: "Noto Sans Myanmar", size: 17)
var secondaryButtonFont = UIFont(name: "Optima", size: 15)
var buttonFont          = UIFont(name: "Optima Bold", size: 20)
var secondaryTitleFont  = UIFont(name: "Optima Bold", size: 60)
var finalScoreFont      = UIFont(name: "Optima Bold", size: 60)
var italicFont          = UIFont(name: "Optima-Italic", size: 13.5)

// MARK: - App Variables
let categories = ["Naruto", "One Punch Man", "Maid Sama!", "Vampire Knight", "Death Note", "Toradora!", "Bleach", "Your Name", "Akame ga Kill!", "Beastars", "Rascal Does Not Dream of Bunny Girl Senpai", "Erased", "Code Geass", "The Way of the Househusband"]
var correctlyAnswered       = 0
let popUpViewAlpha          =   CGFloat(1)

// MARK: - Reset Game
func resetGame() {
    questionList        = []
    questionIndex       = 0
    correctlyAnswered   = 0
}

let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
let backButtonImage = UIImage(systemName: "chevron.left.square", withConfiguration: backButtonImageConfig)

let playButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light, scale: .large)
let playButtonImage = UIImage(systemName: "play.circle", withConfiguration: playButtonImageConfig)

// MARK:- Persistent Storage
let defaults                =   UserDefaults.standard
var totalNumberOfQuestions  =   defaults.integer(forKey: "totalNumberOfQuestions")
var totalNumberOfCorrect    =   defaults.integer(forKey: "totalNumberOfCorrect")
var numOfGamesPlayed        =   defaults.integer(forKey: "numOfGamesPlayed")
