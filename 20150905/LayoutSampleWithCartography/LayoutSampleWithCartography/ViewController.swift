//
//  ViewController.swift
//  LayoutSampleWithCartography
//
//  Created by fhisa on 2015/09/04.
//  Copyright (c) 2015 Hisakuni Fujimoto. All rights reserved.
//

import UIKit
import Cartography

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
        layout(mainView, infoView) {
            $0.height == $0.superview!.height * (3.0 / 4.0)
            $0.leading == $0.superview!.leading + 8
            $0.top == $0.superview!.top + 8
            $0.trailing == $0.superview!.trailing - 8
            $1.top == $0.bottom + 8
            $1.leading == $1.superview!.leading + 8
            $1.trailing == $1.superview!.trailing - 8
            $1.bottom == $1.superview!.bottom - 8
        }
    }

    private func setupPhoneLandscapeLayout() {
        mainView.hidden = false
        infoView.hidden = false
        miniView.hidden = false
        layout(mainView, infoView, miniView) {
            $0.width == $0.superview!.width * (2.0 / 3.0)
            $0.top == $0.superview!.top + 8
            $0.trailing == $0.superview!.trailing - 8
            $0.bottom == $0.superview!.bottom - 8
            $1.height == $0.height * (4.0 / 7.0)
            $1.top == $1.superview!.top + 8
            $1.leading == $1.superview!.leading + 8
            $1.trailing == $1.superview!.leading - 8
            $2.leading == $2.superview!.leading + 8
            $2.top == $1.bottom + 8
            $2.trailing == $0.leading - 8
            $2.bottom == $2.superview!.bottom - 8
        }
//        baseView.removeConstraints(baseView.constraints())
//        baseView.addConstraints([
//            mainView[.Width] * 3 == baseView[.Width] * 2,
//            mainView[.Top] == baseView[.Top] + 8,
//            mainView[.Trailing] == baseView[.Trailing] - 8,
//            mainView[.Bottom] == baseView[.Bottom] - 8,
//            infoView[.Height] * 7 == mainView[.Height] * 4,
//            infoView[.Top] == baseView[.Top] + 8,
//            infoView[.Leading] == baseView[.Leading] + 8,
//            infoView[.Trailing] == mainView[.Leading] - 8,
//            miniView[.Leading] == baseView[.Leading] + 8,
//            miniView[.Top] == infoView[.Bottom] + 8,
//            miniView[.Trailing] == mainView[.Leading] - 8,
//            miniView[.Bottom] == baseView[.Bottom] - 8,
//            ])
    }

    private func setupPadPortraitLayout() {
        setupPhonePortraitLayout()
    }

    private func setupPadLandscapeLayout() {
        setupPhoneLandscapeLayout()
    }
}
