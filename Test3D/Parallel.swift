//
//  Parallel.swift
//  Test3D
//
//  Created by Paul Herz on 11/1/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

class Parallel {
	class func each<T>(collection: [T], function: (T) -> Void) {
		DispatchQueue.concurrentPerform(iterations: collection.count) {
			function(collection[$0])
		}
	}
	
	class func each(_ range: CountableRange<Int>, function: (Int) -> Void) {
		let indices = [Int](range.lowerBound..<range.upperBound)
		Parallel.each(collection: indices, function: function)
	}
	
	class func each(_ range: CountableClosedRange<Int>, function: (Int) -> Void) {
		let indices = [Int](range.lowerBound...range.upperBound)
		Parallel.each(collection: indices, function: function)
	}
}
