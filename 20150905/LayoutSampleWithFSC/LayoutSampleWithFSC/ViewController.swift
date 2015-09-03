//
//  ViewController.swift
//  LayoutSampleWithFSC
//
//  Created by fhisa on 2015/09/03.
//  Copyright (c) 2015 Hisakuni Fujimoto. All rights reserved.
//

import UIKit
import FormulaStyleConstraint

class ViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!

    var mainView: UIView!
    var infoView: UIView!
    var miniView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView = createView(UIColor.cyanColor())
        baseView.addSubview(mainView)
        infoView = createView(UIColor.greenColor())
        baseView.addSubview(infoView)
        miniView = createView(UIColor.yellowColor())
        baseView.addSubview(miniView)

        setupPortraitLayout()
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if size.height > size.width {
            setupPortraitLayout()
        }
        else {
            setupLandscapeLayout()
        }
    }

    private func createView(bgcolor: UIColor) -> UIView {
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = bgcolor
        view.layer.borderColor = UIColor.redColor().CGColor
        view.layer.borderWidth = 1
        return view
    }

    private func setupPortraitLayout() {
        switch traitCollection.userInterfaceIdiom {
        case .Phone:
            setupPhonePortraitLayout()
        case .Pad:
            setupPadPortraitLayout()
        default:
            println("unknown device:\(traitCollection.userInterfaceIdiom.rawValue)")
        }
    }

    private func setupLandscapeLayout() {
        switch traitCollection.userInterfaceIdiom {
        case .Phone:
            setupPhoneLandscapeLayout()
        case .Pad:
            setupPadLandscapeLayout()
        default:
            println("unknown device:\(traitCollection.userInterfaceIdiom.rawValue)")
        }
    }

    private func setupPhonePortraitLayout() {
        mainView.hidden = false
        infoView.hidden = false
        miniView.hidden = true
        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraints([
            mainView[.Height] * 4 == baseView[.Height] * 3,
            mainView[.Leading] == baseView[.Leading] + 8,
            mainView[.Top] == baseView[.Top] + 8,
            mainView[.Trailing] == baseView[.Trailing] - 8,
            infoView[.Top] == mainView[.Bottom] + 8,
            infoView[.Leading] == baseView[.Leading] + 8,
            infoView[.Trailing] == baseView[.Trailing] - 8,
            infoView[.Bottom] == baseView[.Bottom] - 8,
            ])
    }

    private func setupPhoneLandscapeLayout() {
        mainView.hidden = false
        infoView.hidden = false
        miniView.hidden = false
        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraints([
            mainView[.Width] * 3 == baseView[.Width] * 2,
            mainView[.Top] == baseView[.Top] + 8,
            mainView[.Trailing] == baseView[.Trailing] - 8,
            mainView[.Bottom] == baseView[.Bottom] - 8,
            infoView[.Height] * 7 == mainView[.Height] * 4,
            infoView[.Top] == baseView[.Top] + 8,
            infoView[.Leading] == baseView[.Leading] + 8,
            infoView[.Trailing] == mainView[.Leading] - 8,
            miniView[.Leading] == baseView[.Leading] + 8,
            miniView[.Top] == infoView[.Bottom] + 8,
            miniView[.Trailing] == mainView[.Leading] - 8,
            miniView[.Bottom] == baseView[.Bottom] - 8,
            ])
    }

    private func setupPadPortraitLayout() {
        setupPhonePortraitLayout()
    }

    private func setupPadLandscapeLayout() {
        setupPhoneLandscapeLayout()
    }
}
