//
//  PHBitmap.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Cocoa

typealias Image = NSImage

struct Pixel {
	var r: UInt8 = 0
	var g: UInt8 = 0
	var b: UInt8 = 0
	var a: UInt8 = 255
	init(r:UInt8,g:UInt8,b:UInt8) {
		self.r=r
		self.g=g
		self.b=b
	}
	init(r:UInt8,g:UInt8,b:UInt8,a:UInt8) {
		self.r=r
		self.g=g
		self.b=b
		self.a=a
	}
}

class PHBitmap {
	
	static let componentSize: Int = 8
	static let pixelSize: Int = 32
	
	private let colorSpace = CGColorSpaceCreateDeviceRGB()
	private let bmpInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
	
	private(set) var width: Int
	private(set) var height: Int
	var size: Int {
		get {
			return width * height
		}
	}
	var bytesPerRow: Int {
		return width * MemoryLayout<Pixel>.size
	}
	
	private var data: [Pixel]
	
	init(width w: Int, height h: Int) {
		self.width = w
		self.height = h
		self.data = [Pixel](repeating: Pixel(r:0,g:0,b:0,a:255), count: Int(width) * Int(height))
	}
	
	public func clear(color: Pixel) {
		data = data.map { _ in color }
	}
	
	public func set(pixel: Pixel, at index: Int) {
		assert(index >= 0 && index < size)
		assert(pixel.r <= 255 && pixel.g <= 255 && pixel.b <= 255 && pixel.a <= 255)
		data[index] = pixel
	}
	
	public func set(pixel: Pixel, x: Int, y: Int) {
		let index = linearIndex(x: x, y: y)
		set(pixel: pixel, at: index)
	}
	
	public func linearIndex(x: Int, y: Int) -> Int {
		return y * width + x
	}
	
	public func toImage() -> Image {
		let pixels = [Pixel].init(self.data)
		let rawDataSize = Int(size) * MemoryLayout<Pixel>.size
		let provider = CGDataProvider(data:
			//CFDataCreate(nil, &pixels,
			NSData(bytes: pixels, length: rawDataSize)
		)
		
		let cgi = CGImage.init(width: self.width,
		                       height: self.height,
		                       bitsPerComponent: PHBitmap.componentSize,
		                       bitsPerPixel: PHBitmap.pixelSize,
		                       bytesPerRow: self.bytesPerRow,
		                       space: self.colorSpace,
		                       bitmapInfo: self.bmpInfo,
		                       provider: provider!,
		                       decode: nil,
		                       shouldInterpolate: false,
		                       intent: .defaultIntent)
		return Image(cgImage: cgi!, size: NSSize(width: self.width, height: self.height))
	}
	
	public func copy(_ other: PHBitmap) {
		assert(self.width == other.width && self.height == other.height)
		for i in 0..<size {
			data[i] = other.data[i]
		}
	}
}
