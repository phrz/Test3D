//
//  main.swift
//  Test3D
//
//  Created by Paul Herz on 11/1/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

//: Playground - noun: a place where people can play

import Cocoa

func r() -> Double {
	return Double(arc4random() % 11)
}

var x = Point(10.0,10.0,10.0)
var I = TransformMatrix()
I.translation = Point(10.0,0,0)
print(I)

print(x.vec4())
x = I * x
print(x)
