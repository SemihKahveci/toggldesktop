//
//  TimeInputViewController.swift
//  TogglDesktop
//
//  Created by Nghia Tran on 5/3/19.
//  Copyright © 2019 Alari. All rights reserved.
//

import Cocoa

final class TimeInputViewController: NSViewController {

    enum Component {
        case duration
        case start
        case end
        case none
    }

    // MARK: OUTLET

    @IBOutlet weak var durationContainerView: NSView!
    @IBOutlet weak var timeStackView: NSStackView!
    @IBOutlet weak var clockContainerView: NSView!
    @IBOutlet weak var durationLbl: NSTextField!
    @IBOutlet weak var startLbl: NSTextField!
    @IBOutlet weak var startContainerView: NSView!
    @IBOutlet weak var endLbl: NSTextField!
    @IBOutlet weak var endContainerView: NSView!

    // MARK: Variables

    var selectedComponent: Component = .none {
        didSet {
            if isAppearing {
                layoutContent()
            }
        }
    }
    private var isAppearing = false
    var timeEntry: TimeEntryViewItem! {
        didSet {
            if isAppearing {
                layoutContent()
            }
        }
    }
    private lazy var durationInputView: TimeInputView = initDurationInputView()
    private lazy var startInputView: TimeInputView = initStartInputView()
    private lazy var endInputView: TimeInputView = initEndInputView()
    private lazy var clockView: ClockView = initClockView()
    private var selectedTimeInput: TimeInputView? {
        switch selectedComponent {
        case .duration:
            return durationInputView
        case .start:
            return startInputView
        case .end:
            return endInputView
        case .none:
            return nil
        }
    }

    // MARK: View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        layoutContent()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        isAppearing = true
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        isAppearing = false
    }

    private func layoutContent() {
        durationInputView.render(with: timeEntry.started, isSelected: selectedComponent == .duration)
        startInputView.render(with: timeEntry.started, isSelected: selectedComponent == .start)
        endInputView.render(with: timeEntry.ended, isSelected: selectedComponent == .end)

        // Clock
        if let selectedInputView = selectedTimeInput {
            clockView.isHidden = false
            clockView.config(with: selectedInputView)
        } else {
            clockView.isHidden = true
        }
    }
}

// MARK: Private

extension TimeInputViewController {

    fileprivate func initCommon() {

    }

    fileprivate func initDurationInputView() -> TimeInputView {
        let inputView = TimeInputView.xibView() as TimeInputView
        inputView.updateLayout(with: .full)
        inputView.translatesAutoresizingMaskIntoConstraints = false
        durationContainerView.addSubview(inputView)
        inputView.topAnchor.constraint(equalTo: durationLbl.bottomAnchor, constant: 10).isActive = true
        inputView.leftAnchor.constraint(equalTo: durationContainerView.leftAnchor, constant: 20).isActive = true
        return inputView
    }

    fileprivate func initStartInputView() -> TimeInputView {
        let inputView = TimeInputView.xibView() as TimeInputView
        inputView.updateLayout(with: .compact)
        inputView.translatesAutoresizingMaskIntoConstraints = false
        startContainerView.addSubview(inputView)
        inputView.topAnchor.constraint(equalTo: startLbl.bottomAnchor, constant: 0).isActive = true
        inputView.leftAnchor.constraint(equalTo: startContainerView.leftAnchor, constant: 10).isActive = true
        return inputView
    }

    fileprivate func initEndInputView() -> TimeInputView {
        let inputView = TimeInputView.xibView() as TimeInputView
        inputView.updateLayout(with: .compact)
        inputView.translatesAutoresizingMaskIntoConstraints = false
        endContainerView.addSubview(inputView)
        inputView.topAnchor.constraint(equalTo: endLbl.bottomAnchor, constant: 0).isActive = true
        inputView.leftAnchor.constraint(equalTo: endContainerView.leftAnchor, constant: 10).isActive = true
        return inputView
    }

    fileprivate func initClockView() -> ClockView {
        let clock = ClockView.xibView() as ClockView
        clock.translatesAutoresizingMaskIntoConstraints = false
        clockContainerView.addSubview(clock)
        clock.edgesToSuperView()
        return clock
    }
}