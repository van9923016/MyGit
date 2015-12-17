//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


var str = "Hello, playground"

var newStr = "I am itaen"

let size = (20, 40)
switch size {
case let (width, height) where width == height:
	print("Square with sides\(width)")
	width
	height
case (1...10, 1...10):
	print("Small rectangle")
case let (width, height):
	print("Rectangle with width \(width) and height \(height)")
	width
	height
}

let frame = CGRect(x: 0, y: 0, width: 150, height: 150)
let customView = UIView(frame: frame)
customView.backgroundColor = UIColor.redColor()
XCPlaygroundPage.currentPage.liveView = customView
XCPlaygroundPage.currentPage.captureValue(frame, withIdentifier: "View frame")

let imageView = UIImageView(image: [#Image(imageLiteral: "3901e60b331704168c18712c5516393b_b.jpg")#])
imageView.frame = frame






