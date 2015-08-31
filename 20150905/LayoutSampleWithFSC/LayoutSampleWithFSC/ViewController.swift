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
        super.viewDidLoad()

        baseView = createView(UIColor.lightGrayColor())
        view.addSubview(baseView)
        view.addConstraints([
            baseView[.Leading] == view[.Leading],
            baseView[.Trailing] == view[.Trailing],
            baseView[.Top] == view[.Top],
            baseView[.Bottom] == view[.Bottom],
            ])

        mainView = createView(UIColor.cyanColor())
        baseView.addSubview(mainView)
        mainView.addConstraint(mainView[.Width] == mainView[.Height])

        infoView = createView(UIColor.greenColor())
        baseView.addSubview(infoView)

        additionalView = createView(UIColor.yellowColor())
        additionalView.hidden = true
        baseView.addSubview(additionalView)

        if traitCollection.userInterfaceIdiom == .Phone {
            setupPhonePortraitLayout()
        }
        else {
            setupPadPortraitLayout()
        }
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        let isPhone = traitCollection.userInterfaceIdiom == .Phone
        let isPad = traitCollection.userInterfaceIdiom == .Pad
        let isPortrait = size.width < size.height

        if isPhone {
            if isPortrait {
                setupPhonePortraitLayout()
            }
            else {
                setupPhoneLandscapeLayout()
            }
        }
        else if isPad {
            if isPortrait {
                setupPadPortraitLayout()
            }
            else {
                setupPadLandscapeLayout()
            }
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

    private func setupPhonePortraitLayout() {
        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraints([
            mainView[.Leading] == baseView[.Leading] + 8.0,
            mainView[.Trailing] == baseView[.Trailing] - 8.0,
            mainView[.Top] == baseView[.Top] + 8.0,
            ])
    }

    private func setupPhoneLandscapeLayout() {
        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraints([
            mainView[.Top] == baseView[.Top] + 8.0,
            mainView[.Bottom] == baseView[.Bottom] - 8.0,
            mainView[.Trailing] == baseView[.Trailing] - 8.0,
        ])
    }

    private func setupPadPortraitLayout() {
        setupPhonePortraitLayout()
    }

    private func setupPadLandscapeLayout() {
        setupPhoneLandscapeLayout()
    }
}
