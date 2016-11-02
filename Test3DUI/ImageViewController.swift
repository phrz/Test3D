//
//  ImageViewController.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Cocoa

class ImageViewController {
	
	var view: NSImageView
	private var bitmap: PHBitmap
	
	init() {
		self.view = NSImageView()
		self.view.imageScaling = .scaleAxesIndependently
		self.view.wantsLayer = true
		self.view.layer!.magnificationFilter = kCAFilterNearest
		self.view.frame = NSRect(x: 0, y: 0, width: 600, height: 400)
		
		self.bitmap = PHBitmap(width: 300, height: 200)
		let array = [UInt8].init(repeating: 0, count: 4 * self.bitmap.size)
		
		print(self.bitmap.size * MemoryLayout<PHBitmap>.size)
		print(array.count * MemoryLayout<UInt8>.size)
		
		self.bitmap.clear(color: Pixel(r: 0, g: 0, b: 0))
		self.view.image = self.bitmap.toImage()
		
	}
}
