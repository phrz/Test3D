//
//  ContextViewController.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Cocoa

class ContextViewController {
	
	var view: ContextView
	var context: Context
	
	init() {
		self.context = Context(width: 300, height: 200)
		view = ContextView(context: context)
		view.frame = NSRect(x: 0, y: 0, width: 600, height: 400)
		
		let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
			for _ in 0...100 {
				self.randomDot()
			}
			self.context.flush()
			self.context.clear()
		}
		timer.fire()
	}
	
	func random(_ r: ClosedRange<Int>) -> Int {
		let span = abs(r.upperBound-r.lowerBound)
		return Int(arc4random_uniform(UInt32(span)))+r.lowerBound
	}
	
	func randomDot() {
		let w = context.width
		let h = context.height
		let red = Pixel(r: 255, g: 0, b: 0)
		context.put(pixel: red, x: random(0...w), y: random(0...h))
	}
}
