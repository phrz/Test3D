//
//  ContextViewController.swift
//  Test3D
//
//  Created by Paul Herz on 11/2/16.
//  Copyright © 2016 Paul Herz. All rights reserved.
//

import Cocoa

class ContextViewController {
	
	var view: ContextView
	var context: Context
	
	init() {
		self.context = Context(width: 300, height: 200)
		view = ContextView(context: context)
		view.frame = NSRect(x: 0, y: 0, width: 600, height: 400)
		
		// Setup:
		let π = 3.1415926535
		var myCube = Mesh.cube
		myCube.position = Point(0,0,5)
		myCube.rotation = Point(0,π/4,0)
		
		let myCamera = Camera(position: Point(0,0,0), target: Point(0,0,1))
		let meshes: [Mesh] = [myCube]
		
		// Step 1: Clear screen
		self.context.clear()
		
		// Step 2: Update world
		// do nothing
		
		// Step 3: Render into back buffer
		self.context.render(camera: myCamera, meshes: meshes)
		
		// Step 4: Copy to front buffer
		self.context.flush()
		
		/*let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
			// do something
			self.context.flush()
			self.context.clear()
		}
		timer.fire()*/
	}
	
	
}
