//
//  Point.swift
//  Test3D
//
//  Created by Paul Herz on 11/1/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

typealias Vec4 = (Double, Double, Double, Double)

struct Point {
	var x: Double
	var y: Double
	var z: Double
	static let zero = Point(0,0,0)
	init(_ x: Double, _ y: Double, _ z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}
	init(_ v: Vec4) {
		self.x = v.0
		self.y = v.1
		self.z = v.2
	}
	func vec4() -> Vec4 {
		return (self.x, self.y, self.z, 1.0)
	}
}

extension Point {
	static func +(left: Point, right: Point) -> Point {
		var result = left
		result.x += right.x
		result.y += right.y
		result.z += right.z
		return result
	}
	
	static func +=(left: inout Point, right: Point) {
		left.x += right.x
		left.y += right.y
		left.z += right.z
	}
}

extension Point: Equatable {
	static func ==(left: Point, right: Point) -> Bool {
		return (left.x==right.x && left.y==right.y && left.z==right.z)
	}
}
