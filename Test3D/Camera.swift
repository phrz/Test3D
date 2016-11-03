//
//  Camera.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Foundation

struct Camera {
	var position: Point
	var target: Point
	
	func toViewMatrix() -> TransformMatrix {
		
		// [CITE] DirectX documentation, LookAt
		//
		// Where (Xt, Yt, Zt) is the camera position,
		// the vectors:
		//     Z = normalize(target - position)
		//     X = normalize(cross(Up, Z))
		//     Y = cross(Z,X)
		//    up = (0,1,0) [y-up system]
		//
		//[[        X_x,           Y_x,         Z_x, 0]
		// [        X_y,           Y_y,         Z_y, 0]
		// [        X_z,           Y_z,         Z_z, 0]
		// [-dot(X,pos),   -dot(Y,pos), -dot(Z,pos), 1]]
		
		let up = Point(0,1,0)
		
		let Z = normalize(target - position)
		let X = normalize(cross(up, Z))
		let Y = cross(Z, X)
		
		let dX = -1.0 * dot(X, position)
		let dY = -1.0 * dot(Y, position)
		let dZ = -1.0 * dot(Z, position)
		
		let tf = TransformMatrix()
		tf.from(array:
			[[X.x, Y.x, Z.x, 0],
			 [X.y, Y.y, Z.y, 0],
			 [X.z, Y.z, Z.z, 0],
			 [ dX,  dY,  dZ, 0]]
		)
		
		return tf
	}
}
