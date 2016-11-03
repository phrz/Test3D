//
//  TransformMatrix.swift
//  Test3D
//
//  Created by Paul Herz on 11/1/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

class TransformMatrix: Matrix {
	
	override init() {
		super.init()
		self.from(matrix: Matrix.makeIdentity(size: 4))
	}
	
	static func translate(by p: Point) -> TransformMatrix {
		let t = TransformMatrix()
		t[0,3] = p.x
		t[1,3] = p.y
		t[2,3] = p.z
		return t
	}
	
	static func scale(byFactor p: Point) -> TransformMatrix {
		let t = TransformMatrix()
		t[0,0] = p.x
		t[1,1] = p.y
		t[2,2] = p.z
		return t
	}
	
	static func rotateZ(alpha: Double) -> TransformMatrix {
		// [CITE] http://inside.mines.edu/fs_home/gmurray/ArbitraryAxisRotation/
		
		let t = TransformMatrix()
		
		/*
		   [[1,      0,       0, 0]
		    [0, cos(α), -sin(α), 0]
		    [0, sin(α),  cos(α), 0]
		    [0,      0,       0, 1]]
		*/
		
		let cos_alpha = cos(alpha)
		let sin_alpha = sin(alpha)
		
		t[1,1] = cos_alpha
		t[1,2] = -1.0 * sin_alpha
		t[2,1] = sin_alpha
		t[2,2] = cos_alpha
		
		return t
	}
	
	static func rotateY(beta: Double) -> TransformMatrix {
		// [CITE] http://inside.mines.edu/fs_home/gmurray/ArbitraryAxisRotation/
		
		let t = TransformMatrix()
		
		/*
		   [[ cos(β), 0, sin(β), 0]
			[     0,  1,      0, 0]
		    [-sin(β), 0, cos(β), 0]
		    [     0,  0,      0, 1]]
		*/
		
		let cos_beta = cos(beta)
		let sin_beta = sin(beta)
		
		t[0,0] = cos_beta
		t[0,2] = sin_beta
		t[2,0] = -1.0 * sin_beta
		t[2,2] = cos_beta		
		
		return t
	}
	
	static func rotateX(gamma: Double) -> TransformMatrix {
		// [CITE] http://inside.mines.edu/fs_home/gmurray/ArbitraryAxisRotation/
		
		let t = TransformMatrix()
		
		/*
		   [[cos(γ), -sin(γ), 0, 0]
		    [sin(γ),  cos(γ), 0, 0]
		    [     0,       0, 1, 0]
			[     0,       0, 0, 1]]
		*/
		
		let cos_gamma = cos(gamma)
		let sin_gamma = sin(gamma)
		
		t[0,0] = cos_gamma
		t[0,1] = -1.0 * sin_gamma
		t[1,0] = sin_gamma
		t[1,1] = cos_gamma
		
		return t
	}
}

extension TransformMatrix {
	static func *(left: TransformMatrix, right: TransformMatrix) -> TransformMatrix {
		assert(left.columns == right.rows)
		let result = TransformMatrix()
		
		for k in 0..<right.columns {
			for j in 0..<left.columns {
				for i in 0..<left.rows {
					result[i,k] += left[i,j] * right[j,k]
				}
			}
		}
		
		return result
	}
	
	static func *=(left: inout TransformMatrix, right: TransformMatrix) {
		left = left * right
	}
}

func *(left: TransformMatrix, right: Point) -> Point {
	return Point(product(matrix: left, vector: right.vec4()))
}
