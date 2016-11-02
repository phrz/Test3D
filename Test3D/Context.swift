//
//  Context.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

class Context {
	
	private(set) var height: Int
	private(set) var width: Int
	
	private var frontBuffer: PHBitmap
	private var backBuffer: PHBitmap
	
	init(width: Int, height: Int) {
		self.width = width
		self.height = height
		frontBuffer = PHBitmap(width: width, height: height)
		backBuffer = PHBitmap(width: width, height: height)
	}
}
