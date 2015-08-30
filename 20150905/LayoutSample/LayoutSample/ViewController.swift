//
//  ViewController.swift
//  LayoutSample
//
//  Created by fhisa on 2015/08/31.
//  Copyright (c) 2015 Hisakuni Fujimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var baseView, mainView, infoView, additionalView: UIView!

    var phonePortraitLayout: [NSLayoutConstraint]!
    var phoneLandscapeLayout: [NSLayoutConstraint]!
    var padPortraitLayout: [NSLayoutConstraint]!
    var padLandscapeLayout: [NSLayoutConstraint]!

    override func viewDidLoad() {

        func setupBaseViewConstraints() {
            view.addConstraints([
                NSLayoutConstraint(
                    item: baseView, attribute: .Leading,
                    relatedBy: .Equal,
                    toItem: view, attribute: .Leading,
                    multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(
                    item: baseView, attribute: .Trailing,
                    relatedBy: .Equal,
                    toItem: view, attribute: .Trailing,
                    multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(
                    item: baseView, attribute: .Top,
                    relatedBy: .Equal,
                    toItem: topLayoutGuide, attribute: .Bottom,
                    multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(
                    item: baseView, attribute: .Bottom,
                    relatedBy: .Equal,
                    toItem: bottomLayoutGuide, attribute: .Top,
                    multiplier: 1.0, constant: 0.0),
                ])
        }

        func initPhonePortraitLayout() {
            phonePortraitLayout = [
                NSLayoutConstraint(
                    item: mainView, attribute: .Leading,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Leading,
                    multiplier: 1.0, constant: 8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Trailing,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Trailing,
                    multiplier: 1.0, constant: -8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Top,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Top,
                    multiplier: 1.0, constant: 8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Height,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Width,
                    multiplier: 1.0, constant: -12.0),
            ]
        }

        func initPhoneLandscapeLayout() {
            phoneLandscapeLayout = [
                NSLayoutConstraint(
                    item: mainView, attribute: .Top,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Top,
                    multiplier: 1.0, constant: 8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Bottom,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Bottom,
                    multiplier: 1.0, constant: -8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Trailing,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Trailing,
                    multiplier: 1.0, constant: -8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Width,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Height,
                    multiplier: 1.0, constant: -12.0),
            ]
        }
        
        func initPadPortraitLayout() {
            padPortraitLayout = phonePortraitLayout
        }
        
        func initPadLandscapeLayout() {
            padLandscapeLayout = [
                NSLayoutConstraint(
                    item: mainView, attribute: .Top,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Top,
                    multiplier: 1.0, constant: 8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Trailing,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Trailing,
                    multiplier: 1.0, constant: -8.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Height,
                    relatedBy: .Equal,
                    toItem: mainView.superview, attribute: .Height,
                    multiplier: 3.0 / 4.0, constant: -12.0),
                NSLayoutConstraint(
                    item: mainView, attribute: .Width,
                    relatedBy: .Equal,
                    toItem: mainView, attribute: .Height,
                    multiplier: 1.0, constant: 0.0),
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

