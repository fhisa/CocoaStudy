//
//  ViewController.swift
//  LayoutSample
//
//  Created by fhisa on 2015/08/31.
//  Copyright (c) 2015 Hisakuni Fujimoto. All rights reserved.
//

import UIKit
import FormulaStyleConstraint

class ViewController: UIViewController {

    var baseView, mainView, infoView, additionalView: UIView!

    var phonePortraitLayout: [NSLayoutConstraint]!
    var phoneLandscapeLayout: [NSLayoutConstraint]!
    var padPortraitLayout: [NSLayoutConstraint]!
    var padLandscapeLayout: [NSLayoutConstraint]!

    override func viewDidLoad() {

        func setupBaseViewConstraints() {
            view.addConstraints([
                baseView[.Leading] == view[.Leading],
                baseView[.Trailing] == view[.Trailing],
                baseView[.Top] == view[.Top],
                baseView[.Bottom] == view[.Bottom],
                ])
        }

        func initPhonePortraitLayout() {
            phonePortraitLayout = [
                mainView[.Leading] == mainView.superview![.Leading] + 8.0,
                mainView[.Trailing] == mainView.superview![.Trailing] - 8.0,
                mainView[.Top] == mainView.superview![.Top] + 8.0,
                mainView[.Height] == mainView.superview![.Width] - 12.0,
            ]
        }

        func initPhoneLandscapeLayout() {
            phoneLandscapeLayout = [
                mainView[.Top] == mainView.superview![.Top] + 8.0,
                mainView[.Bottom] == mainView.superview![.Bottom] - 8.0,
                mainView[.Trailing] == mainView.superview![.Trailing] - 8.0,
                mainView[.Width] == mainView.superview![.Height] - 12.0,
            ]
        }
        
        func initPadPortraitLayout() {
            padPortraitLayout = phonePortraitLayout
        }
        
        func initPadLandscapeLayout() {
            padLandscapeLayout = [
                mainView[.Top] == mainView.superview![.Top] + 8.0,
                mainView[.Trailing] == mainView.superview![.Trailing] - 8.0,
                mainView[.Height] == CGFloat(3.0 / 4.0) * mainView.superview![.Height] - 12.0,
                mainView[.Width] == mainView[.Height],
            ]
        }
        
        super.viewDidLoad()

        baseView = createView(UIColor.lightGrayColor())
        view.addSubview(baseView)
        setupBaseViewConstraints()

        mainView = createView(UIColor.cyanColor())
        baseView.addSubview(mainView)

        infoView = createView(UIColor.greenColor())
        baseView.addSubview(infoView)

        additionalView = createView(UIColor.yellowColor())
        additionalView.hidden = true
        baseView.addSubview(additionalView)

        initPhonePortraitLayout()
        initPhoneLandscapeLayout()
        initPadPortraitLayout()
        initPadLandscapeLayout()

        switch traitCollection.userInterfaceIdiom {
        case .Pad:
            switchLayout(padPortraitLayout)
        case .Phone:
            switchLayout(phonePortraitLayout)
        default:
            println("unknown idiom:\(traitCollection.userInterfaceIdiom.rawValue)")
        }
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {

        let isPhone = traitCollection.userInterfaceIdiom == .Phone
        let isPad = traitCollection.userInterfaceIdiom == .Pad
        let isPortrait = size.width < size.height

        if isPhone {
            switchLayout(isPortrait ? phonePortraitLayout : phoneLandscapeLayout)
        }
        else if isPad {
            switchLayout(isPortrait ? padPortraitLayout : padLandscapeLayout)
        }
    }

    private func createView(bgColor: UIColor?) -> UIView {
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        if let bgColor = bgColor { view.backgroundColor = bgColor }
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.redColor().CGColor
        return view
    }

    private func switchLayout(constraints: [NSLayoutConstraint]) {
        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraints(constraints)
    }
}

