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
	mutating func apply(_ transform: TransformMatrix) {
		let newV = transform * self
		self.x = newV.x
		self.y = newV.y
		self.z = newV.z
	}
	func magnitude() -> Double {
		return sqrt(x*x + y*y + z*z)
	}
}

func normalize(_ p: Point) -> Point {
	let mag = p.magnitude()
	return Point(p.x/mag, p.y/mag, p.z/mag)
}

func cross(_ a: Point, _ b: Point) -> Point {
	var result = Point.zero
	result.x = a.y * b.z - a.z * b.y
	result.y = a.z * b.x - a.x * b.z
	result.z = a.x * b.y - a.y * b.x
	return result
}

func dot(_ a: Point, _ b: Point) -> Double {
	return a.x*b.x + a.y*b.y + a.z*b.z
}

extension Point {
	static func +(left: Point, right: Point) -> Point {
		var result = left
		result.x += right.x
		result.y += right.y
		result.z += right.z
		return result
	}
	
	static func -(left: Point, right: Point) -> Point {
		var result = left
		result.x -= right.x
		result.y -= right.y
		result.z -= right.z
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
