//
//  AppDelegate.swift
//  Test3DUI
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Cocoa
import SnapKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	var contextViewController: ContextViewController?

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		contextViewController = ContextViewController()
		window.contentView?.addSubview(self.contextViewController!.view)
		
		contextViewController?.view.snp.makeConstraints {(make) in
			make.edges.equalTo(window.contentView!)
		}
		
		window.setFrame(NSRect(x: 0, y: 0, width: 600, height: 400), display: true)
		window.center()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

