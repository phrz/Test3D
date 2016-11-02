//
//  ContextView.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Cocoa

class ContextView: NSImageView {
	
	private(set) var context: Context
	
	init(context: Context) {
		self.context = context
		
		super.init(frame: NSRect(x: 0, y: 0, width: 600, height: 400))
		
		self.context.delegate = self
		self.context.reset()
		
		imageScaling = .scaleAxesIndependently
		wantsLayer = true
		layer!.backgroundColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
		layer!.magnificationFilter = kCAFilterNearest
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ContextView: ContextDelegate {
	func present(image: Image) {
		self.image = image
	}
}
