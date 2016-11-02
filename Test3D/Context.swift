//
//  Context.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

protocol ContextDelegate {
	func present(image: Image)
}

class Context {
	
	private(set) var height: Int
	private(set) var width: Int
	private var backBuffer: PHBitmap
	private var frontBuffer: PHBitmap
	private(set) var image: Image?
	public var delegate: ContextDelegate?
	
	public let clearColor: Pixel = Pixel(r: 0, g: 0, b: 0)
	
	init(width: Int, height: Int) {
		self.width = width
		self.height = height
		self.backBuffer = PHBitmap(width: width, height: height)
		self.frontBuffer = PHBitmap(width: width, height: height)
	}
	
	func reset() {
		clear()
		flush()
	}
	
	func clear() {
		backBuffer.clear(color: clearColor)
	}
	
	func flush() {
		frontBuffer.copy(backBuffer)
		image = frontBuffer.toImage()
		if let i = image, let d = delegate {
			d.present(image: i)
		}
	}
	
	func put(pixel: Pixel, x: Int, y: Int) {
		backBuffer.set(pixel: pixel, x: x, y: y)
	}
}
