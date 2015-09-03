//
//  ViewController.swift
//  SquareSampleWithFSC
//
//  Created by fhisa on 2015/09/04.
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

        mainView.removeConstraints(mainView.constraints())
        mainView.addConstraint(mainView[.Width] == mainView[.Height])

        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraint(mainView[.Leading] == baseView[.Leading] + 8)
        baseView.addConstraint(mainView[.Top] == baseView[.Top] + 8)
        baseView.addConstraint(mainView[.Trailing] == baseView[.Trailing] - 8)
        baseView.addConstraint(infoView[.Top] == mainView[.Bottom] + 8)
        baseView.addConstraint(infoView[.Leading] == baseView[.Leading] + 8)
        baseView.addConstraint(infoView[.Trailing] == baseView[.Trailing] - 8)
        baseView.addConstraint(infoView[.Bottom] == baseView[.Bottom] - 8)
    }

    private func setupPhoneLandscapeLayout() {
        mainView.hidden = false
        infoView.hidden = false
        miniView.hidden = false

        mainView.removeConstraints(mainView.constraints())
        mainView.addConstraint(mainView[.Width] == mainView[.Height])

        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraint(mainView[.Top] == baseView[.Top] + 8)
        baseView.addConstraint(mainView[.Trailing] == baseView[.Trailing] - 8)
        baseView.addConstraint(mainView[.Bottom] == baseView[.Bottom] - 8)
        baseView.addConstraint(infoView[.Height] * 7 == mainView[.Height] * 4)
        baseView.addConstraint(infoView[.Top] == baseView[.Top] + 8)
        baseView.addConstraint(infoView[.Leading] == baseView[.Leading] + 8)
        baseView.addConstraint(infoView[.Trailing] == mainView[.Leading] - 8) // warning
        baseView.addConstraint(miniView[.Leading] == baseView[.Leading] + 8)
        baseView.addConstraint(miniView[.Top] == infoView[.Bottom] + 8)
        baseView.addConstraint(miniView[.Trailing] == mainView[.Leading] - 8) // warning
        baseView.addConstraint(miniView[.Bottom] == baseView[.Bottom] - 8)
    }

    private func setupPadPortraitLayout() {
        setupPhonePortraitLayout()
    }

    private func setupPadLandscapeLayout() {
        setupPhoneLandscapeLayout()
    }
}
