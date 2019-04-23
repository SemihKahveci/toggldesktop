//
//  DateCellViewItem.swift
//  TogglDesktop
//
//  Created by Nghia Tran on 4/19/19.
//  Copyright © 2019 Alari. All rights reserved.
//

import Cocoa

final class DateCellViewItem: NSCollectionViewItem {

    // MARK: OUTLET

    @IBOutlet weak var titleLbl: NSTextField!
    @IBOutlet weak var backgroundBox: NSBox!
    @IBOutlet weak var monthLbl: NSTextField!
    @IBOutlet weak var hoverView: NSBox!

    // MARK: Public

    override func awakeFromNib() {
        super.awakeFromNib()
        initCommon()
        initTracking()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        initCommon()
    }

    func render(with info: DateInfo, highlight: Bool) {
        titleLbl.stringValue = "\(info.day)"
        backgroundBox.isHidden = !highlight
        if info.isFirstDayOfMonth {
            monthLbl.isHidden = false
            monthLbl.stringValue = info.monthTitle
        } else {
            monthLbl.isHidden = true
        }
    }

    private func initCommon() {
        monthLbl.isHidden = true
        backgroundBox.isHidden = true
        hoverView.alphaValue = 0.0
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSCursor.arrow.set()
        hoverView.animator().alphaValue = 0.0
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        NSCursor.pointingHand.set()
        hoverView.animator().alphaValue = 1.0
    }

    private func initTracking() {
        let trackingArea = NSTrackingArea(rect: view.bounds,
                                          options: [.activeInKeyWindow, .inVisibleRect, .mouseEnteredAndExited],
                                          owner: self,
                                          userInfo: nil)
        view.addTrackingArea(trackingArea)
    }
}