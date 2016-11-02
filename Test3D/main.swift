//
//  main.swift
//  Test3D
//
//  Created by Paul Herz on 11/1/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

//: Playground - noun: a place where people can play

import Cocoa

let π = 3.14159265358979

var p = Point(1.0, 0.0, 0.0)

var x = [String]()
var y = [String]()

let stepCount = 50
let radialStep = (2*π)/Double(stepCount)
let rotation = TransformMatrix.rotateZ(gamma: radialStep)
let scale = TransformMatrix.scale(byFactor: Point(1.0, 0.5, 1.0))

x.append(String(p.x))
y.append(String(p.y))

for _ in 0..<stepCount {
	p.apply(rotation)
	let p1 = scale * p
	x.append(String(p1.x))
	y.append(String(p1.y))
}

print("x=[", x.joined(separator: ", "), "];")
print("y=[", y.joined(separator: ", "), "];")
