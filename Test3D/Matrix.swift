//
//  Matrix.swift
//  Test3D
//
//  Created by Paul Herz on 11/1/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

class Matrix {
	enum MatrixError: Error {
		case badDimensions
	}
	
	fileprivate(set) var rows: Int
	fileprivate(set) var columns: Int
	fileprivate var content: [Double]
	
	var size: Int {
		get {
			return rows * columns
		}
	}
	
	init() {
		self.rows = 0
		self.columns = 0
		self.content = []
	}
	
	init(_ r: Int, _ c: Int) {
		self.rows = r
		self.columns = c
		
		self.content = [Double](repeating: 0.0, count: Int(rows*columns))
	}
	
	convenience init(_ contentArray: [[Double]]) {
		self.init(0,0)
		self.from(array: contentArray)
	}
	
	func from(array contentArray: [[Double]]) {
		self.content = []
		
		// take a row-major (human readable) 2D array
		let r = contentArray.count
		
		var c = 0
		if r > 0 {
			c = contentArray[0].count
		}
		
		for row in contentArray {
			// if this row is the wrong size, stuff goes bad.
			guard row.count == c else {
				print("Size mismatch in Matrix::from")
				self.content = []
				return
			}
			self.content.append(contentsOf: row)
		}
		
		self.rows = r
		self.columns = c
	}
	
	static func from(array contentArray: [[Double]]) -> Matrix {
		let m = Matrix()
		m.from(array: contentArray)
		return m
	}
	
	func from(matrix other: Matrix) {
		self.rows = other.rows
		self.columns = other.columns
		self.content = other.content
	}
	
	static func makeIdentity(size: Int) -> Matrix {
		let m = Matrix(size, size)
		for i in 0..<size {
			m[i,i] = 1.0
		}
		return m
	}
	
	// linear indexing
	subscript(index: Int) -> Double {
		get {
			return self.content[index]
		}
		set(newValue) {
			self.content[index] = newValue
		}
	}
	
	// (row, column) indexing
	subscript(_ r: Int, _ c: Int) -> Double {
		get {
			return self[linearIndex(r,c)]
		}
		set(newValue) {
			self[linearIndex(r,c)] = newValue
		}
	}
	
	func linearIndex(_ r: Int, _ c: Int) -> Int {
		return r * self.columns + c
	}
}

extension Matrix {
	static func *(left: Matrix, right: Matrix) -> Matrix {
		assert(left.columns == right.rows)
		let result = Matrix(left.rows, right.columns)
		
		for k in 0..<right.columns {
			for j in 0..<left.columns {
				for i in 0..<left.rows {
					result[i,k] += left[i,j] * right[j,k]
				}
			}
		}
		
		return result
	}
	
	static func *=(left: inout Matrix, right: Matrix) {
		left = left * right
	}
}

extension Matrix: Equatable {
	static func ==(left: Matrix, right: Matrix) -> Bool {
		return left.content == right.content
	}
}

extension Matrix: CustomStringConvertible {
	var description: String {
		get {
			var rep = ""
			for r in 0..<rows {
				for c in 0..<columns {
					rep += "    \(self[r,c])"
				}
				rep += "\n"
			}
			return rep
		}
	}
}

func product(matrix left: Matrix, vector right: [Double]) -> [Double] {
	guard left.columns == right.count else {
		print("Warning: incompatible matrix-vector dimensions")
		return []
	}
	
	var result = [0.0, 0.0, 0.0, 0.0]
	
	let m = left.rows
	let n = left.columns
	
	// iterate result elements: forall[i 0...m-1]{r_i = sum[j 0...n-1](a_i,j * x_j)}
	for i in 0..<m {
		// iterate addends of ith cell [j 0...n-1](a_i,j * x_j)
		for j in 0..<n {
			result[i] += (left[i,j] * right[j])
		}
	}
	return result
}

func product(matrix left: Matrix, vector right: Vec4) -> Vec4 {
	let x = [right.0, right.1, right.2, right.3]
	let result = product(matrix: left, vector: x)
	return (result[0], result[1], result[2], result[3])
}
