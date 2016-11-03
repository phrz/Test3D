//
//  Context.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

protocol ContextDelegate {
	func present(image: Image)
}

class Context {
	
	private(set) var height: Int
	private(set) var width: Int
	private var backBuffer: PHBitmap
	private var frontBuffer: PHBitmap
	private(set) var image: Image?
	public var delegate: ContextDelegate?
	
	public var aspectRatio: Double {
		get {
			return Double(width)/Double(height)
		}
	}
	
	public let clearColor: Pixel = Pixel(r: 0, g: 0, b: 0)
	
	init(width: Int, height: Int) {
		self.width = width
		self.height = height
		self.backBuffer = PHBitmap(width: width, height: height)
		self.frontBuffer = PHBitmap(width: width, height: height)
	}
	
	func reset() {
		clear()
		flush()
	}
	
	func clear() {
		backBuffer.clear(color: clearColor)
	}
	
	func flush() {
		frontBuffer.copy(backBuffer)
		image = frontBuffer.toImage()
		if let i = image, let d = delegate {
			d.present(image: i)
		}
	}
	
	func put(pixel: Pixel, x: Int, y: Int) {
		backBuffer.set(pixel: pixel, x: x, y: y)
	}
	
	func project(point point3: Point, matrix: TransformMatrix) -> Point {
		let p = matrix * point3
		// translate coordinates to screen system, such that (0,0)
		// is top left.
		let x = p.x /* Double(width)*/ + Double(width)/2.0
		let y = -1.0 * p.y /* Double(height)*/ + Double(height)/2.0
		return Point(x, y, 0.0)
	}
	
	func draw(point: Point) {
		print("Drawing \(point)...")
		// calls put but clips off-screen points.
		let x = Int(round(point.x))
		let y = Int(round(point.y))
		if(x >= 0 && y >= 0 && x < width && y < height) {
			print("Visible!")
			put(pixel: Pixel(r:0,g:255,b:255), x: x, y: y)
		}
		print()
	}
	
	func render(camera: Camera, meshes: [Mesh]) {
		let viewMatrix = camera.toViewMatrix()
		let projectionMatrix = Context.perspective(fov: 0.78, aspect: aspectRatio, nearZ: 0.01, farZ: 1.0)
		for mesh in meshes {
			print("Rendering \(mesh.name)")
			// N.B. rotation first in roll, pitch, yaw order (z,y,x)
			var worldMatrix = TransformMatrix.rotateZ(alpha: mesh.rotation.z)
			worldMatrix *= TransformMatrix.rotateY(beta: mesh.rotation.y)
			worldMatrix *= TransformMatrix.rotateX(gamma: mesh.rotation.x)
			
			// Then translation
			worldMatrix *= TransformMatrix.translate(by: mesh.position)
			
			// Transforms are applied to points in World, View, Projection order.
			let transformMatrix = (worldMatrix * viewMatrix) * projectionMatrix
			for vertex in mesh.vertices {
				print("Original vertex \(vertex)")
				// project 3d to 2d using transform matrix
				let point = project(point: vertex, matrix: transformMatrix)
				print("Drawing point \(point)")
				draw(point: point)
				print()
			}
		}
	}
	
	static func perspective(fov: Double, aspect: Double, nearZ: Double, farZ: Double) -> TransformMatrix {
		// [CITE] https://msdn.microsoft.com/en-us/library/windows/desktop/bb281728(v=vs.85).aspx
		//
		// fov: Y direction fov in radians.
		// aspect: aspect ratio, viewspace w/h.
		// nearZ: near view plane Z.
		// farZ: far view plane Z.
		//
		// w = aspect * h
		// h = cot(fov/2)
		//
		// a = farZ/(nearZ-farZ)
		// b = nearZ*farZ/(nearZ-farZ)
		//
		//[[w, 0, 0,  0]
		// [0, h, 0,  0]
		// [0, 0, a, -1]
		// [0, 0, b,  0]]
		
		let h = 1.0/tan(fov/2.0)
		let w = aspect * h
		
		let a = farZ/(nearZ-farZ)
		let b = nearZ*farZ/(nearZ-farZ)
		
		let tf = TransformMatrix()
		tf.from(array:
			[[w,  0,  0,  0],
			 [0,  h,  0,  0],
			 [0,  0,  a, -1],
			 [0,  0,  b,  0]]
		)
		
		return tf
	}
}



