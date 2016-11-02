//
//  Mesh.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

struct Mesh {
	public var name: String
	public var vertices: [Point]
	public var position: Point 
	public var rotation: Point
	
	init(name: String, vertices: [Point] = [], position: Point = .zero, rotation: Point = .zero) {
		self.name = name
		self.vertices = vertices
		self.position = position
		self.rotation = rotation
	}
	
	static let cube = Mesh(name: "Cube", vertices: [
		Point(-1, 1, 1),
		Point(1, 1, 1),
		Point(-1, -1, 1),
		Point(-1, -1, -1),
		Point(-1, 1, -1),
		Point(1, 1, -1),
		Point(1, -1, 1),
		Point(1, -1, -1)
	])
}
