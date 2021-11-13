//
//  ConfigureVaryingViews.swift
//  Weeb
//
//  Created by HaroldDavidson on 10/31/21.
//

import UIKit


// MARK: Screen Sizes - h x w
/*
 
 https://developer.apple.com/library/archive/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Displays/Displays.html
 
 iPhones
 12 Pro Max, 13 Pro Max           =       926 x 428     100%
 12, 12 Pro, 13 Pro               =       844 x 390     91%
 11 Pro, Xs, X, 12m, 13m          =       812 x 375     88%
 11 Pro Max, 11, Xs Max, XR       =       896 x 414     97%
 8+, 7+                           =       736 x 414     79%
 8, 7, 6s, 6s+, 6+, 6, SE2        =       667 x 375     72%
 SE, Touch 7                      =       568 x 320     61%


 iPads
 12.9" Pro 1-2                    =       1366 x 1024
 10.5" Pro, Air 3                 =       1112 x 834
 9.7" Pro, Air 2, Mini 5          =       1024 x 768
*/

enum Devices: CGFloat {
    case twelveProMaxHeight         =     926
    case twelveHeight               =     844
    case elevenAndProMaxHeight      =     896
    case elevenProHeight            =     812
    case eightPlusHeight            =     736
    case eightHeight                =     667
    case sEHeight                   =     568
    case bigiPadProHeight           =     1366
    case airThreeHeight             =     1112
    case airTwoHeight               =     1024
}

func varyForScreenSizes(screenHeight: CGFloat) {
    switch screenHeight {
    case Devices.twelveProMaxHeight.rawValue:
        logoFont                =   UIFont(name: "Pocket Monk", size: 150)
        secondaryButtonFont     =   UIFont(name: "Optima", size: 23)
        appFont                 =   UIFont(name: "Roboto Mono", size: 23)
        buttonFont              =   UIFont(name: "Optima Bold", size: 25)
        finalScoreFont          =   UIFont(name: "Roboto Mono", size: 100)
        secondaryTitleFont      =   UIFont(name: "Optima Bold", size: 60)
        break
    case Devices.twelveHeight.rawValue:
        logoFont                =   UIFont(name: "Pocket Monk", size: 137)
        secondaryButtonFont     =   UIFont(name: "Optima", size: 21)
        appFont                 =   UIFont(name: "Roboto Mono", size: 21)
        buttonFont              =   UIFont(name: "Optima Bold", size: 23)
        finalScoreFont          =   UIFont(name: "Roboto Mono", size: 91)
        secondaryTitleFont      =   UIFont(name: "Optima Bold", size: 55)
        break
    case Devices.elevenAndProMaxHeight.rawValue:
        logoFont                =   UIFont(name: "Pocket Monk", size: 145)
        secondaryButtonFont     =   UIFont(name: "Optima", size: 22)
        appFont                 =   UIFont(name: "Roboto Mono", size: 22)
        buttonFont              =   UIFont(name: "Optima Bold", size: 24)
        finalScoreFont          =   UIFont(name: "Roboto Mono", size: 97)
        secondaryTitleFont      =   UIFont(name: "Optima Bold", size: 58)
        break
    case Devices.elevenProHeight.rawValue:
        logoFont                =   UIFont(name: "Pocket Monk", size: 132)
        secondaryButtonFont     =   UIFont(name: "Optima", size: 20)
        appFont                 =   UIFont(name: "Roboto Mono", size: 20)
        buttonFont              =   UIFont(name: "Optima Bold", size: 22)
        finalScoreFont          =   UIFont(name: "Roboto Mono", size: 88)
        secondaryTitleFont      =   UIFont(name: "Optima Bold", size: 53)
        break
    case Devices.eightPlusHeight.rawValue:
        logoFont                =   UIFont(name: "Pocket Monk", size: 119)
        secondaryButtonFont     =   UIFont(name: "Optima", size: 18)
        appFont                 =   UIFont(name: "Roboto Mono", size: 18)
        buttonFont              =   UIFont(name: "Optima Bold", size: 20)
        finalScoreFont          =   UIFont(name: "Roboto Mono", size: 79)
        secondaryTitleFont      =   UIFont(name: "Optima Bold", size: 47)
        break
    case Devices.eightHeight.rawValue:
        logoFont                =   UIFont(name: "Pocket Monk", size: 108)
        secondaryButtonFont     =   UIFont(name: "Optima", size: 17)
        appFont                 =   UIFont(name: "Roboto Mono", size: 17)
        buttonFont              =   UIFont(name: "Optima Bold", size: 18)
        finalScoreFont          =   UIFont(name: "Roboto Mono", size: 72)
        secondaryTitleFont      =   UIFont(name: "Optima Bold", size: 43)
        break
    case Devices.sEHeight.rawValue:
        logoFont                =   UIFont(name: "Pocket Monk", size: 92)
        secondaryButtonFont     =   UIFont(name: "Optima", size: 14)
        appFont                 =   UIFont(name: "Roboto Mono", size: 14)
        buttonFont              =   UIFont(name: "Optima Bold", size: 15)
        finalScoreFont          =   UIFont(name: "Roboto Mono", size: 61)
        secondaryTitleFont      =   UIFont(name: "Optima Bold", size: 37)
        break
    case Devices.bigiPadProHeight.rawValue:
        break
    case Devices.airThreeHeight.rawValue:
        break
    case Devices.airTwoHeight.rawValue:
        break
    default:
        
        break
    }
}
