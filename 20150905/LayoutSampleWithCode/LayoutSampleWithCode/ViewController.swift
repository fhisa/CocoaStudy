//
//  ViewController.swift
//  LayoutSampleWithFSC
//
//  Created by fhisa on 2015/09/03.
//  Copyright (c) 2015 Hisakuni Fujimoto. All rights reserved.
//

import UIKit

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
            NSLayoutConstraint(
                item: mainView, attribute: .Height,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Height,
                multiplier: 3.0 / 4.0, constant: 0),
            NSLayoutConstraint(
                item: mainView, attribute: .Leading,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Leading,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: mainView, attribute: .Top,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Top,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: mainView, attribute: .Trailing,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Trailing,
                multiplier: 1, constant: -8),
            NSLayoutConstraint(
                item: infoView, attribute: .Top,
                relatedBy: .Equal,
                toItem: mainView, attribute: .Bottom,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: infoView, attribute: .Leading,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Leading,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: infoView, attribute: .Trailing,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Trailing,
                multiplier: 1, constant: -8),
            NSLayoutConstraint(
                item: infoView, attribute: .Bottom,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Bottom,
                multiplier: 1, constant: -8),
            ])
    }

    private func setupPhoneLandscapeLayout() {
        mainView.hidden = false
        infoView.hidden = false
        miniView.hidden = false
        baseView.removeConstraints(baseView.constraints())
        baseView.addConstraints([
            NSLayoutConstraint(
                item: mainView, attribute: .Width,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Width,
                multiplier: 2.0 / 3.0, constant: 0),
            NSLayoutConstraint(
                item: mainView, attribute: .Top,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Top,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: mainView, attribute: .Trailing,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Trailing,
                multiplier: 1, constant: -8),
            NSLayoutConstraint(
                item: mainView, attribute: .Bottom,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Bottom,
                multiplier: 1, constant: -8),
            NSLayoutConstraint(
                item: infoView, attribute: .Height,
                relatedBy: .Equal,
                toItem: mainView, attribute: .Height,
                multiplier: 4.0 / 7.0, constant: 0),
            NSLayoutConstraint(
                item: infoView, attribute: .Top,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Top,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: infoView, attribute: .Leading,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Leading,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: infoView, attribute: .Trailing,
                relatedBy: .Equal,
                toItem: mainView, attribute: .Leading,
                multiplier: 1, constant: -8),
            NSLayoutConstraint(
                item: miniView, attribute: .Leading,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Leading,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: miniView, attribute: .Top,
                relatedBy: .Equal,
                toItem: infoView, attribute: .Bottom,
                multiplier: 1, constant: 8),
            NSLayoutConstraint(
                item: miniView, attribute: .Trailing,
                relatedBy: .Equal,
                toItem: mainView, attribute: .Leading,
                multiplier: 1, constant: -8),
            NSLayoutConstraint(
                item: miniView, attribute: .Bottom,
                relatedBy: .Equal,
                toItem: baseView, attribute: .Bottom,
                multiplier: 1, constant: -8),
            ])
    }

    private func setupPadPortraitLayout() {
        setupPhonePortraitLayout()
    }

    private func setupPadLandscapeLayout() {
        setupPhoneLandscapeLayout()
    }
}
