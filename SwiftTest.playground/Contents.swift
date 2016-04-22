//: Playground - noun: a place where people can play

import Cocoa
let intValue = 0
let valueA:Float = 0

var fileCount = 9
print("There are \(fileCount) file in the table")
let firstName = "Wen"
let lastName = "Tan"
var myName = firstName + " " + lastName

if fileCount > 0 {
	print("\(fileCount) is not 0")
}

for i in 0 ..< 10 {
	print("i =\(i)")
}

for i in 1..<10 {
	print("i is \(i)")
}
//while fileCount < 100 {
//	print("Hello, It's me")
//	fileCount++
//}
//
//repeat {
//	print("Hello, Aloha!")
//	fileCount++
//}while fileCount < 200
//
//jLoop: for var j = 0; j < 100; ++j {
//	kLoop: for var k = 10; k < 50; ++k {
//		print("k number is \(k)")
//		if k == 48 {
//			break kLoop
//		}
//	}
//	print("j number is \(j)")
//}

var a32BitInt: Int32 = 10
//var a64BitInt: Int64 = Int64.max

var someFloat = Float.NaN
if someFloat.isNaN {
	print("Some float is NAN")
}else{
	print("Some float has its value")
}


var myPuppy = "This is my dog puppy"
var dogs = ["Helln","Jack","Eve"]
var cats: Array<String>
cats = ["a","b","c"]
var primaryIds = [1,2,3]
print(primaryIds.count)
primaryIds.append(6)
primaryIds.insert(7, atIndex: 3)
primaryIds.removeAtIndex(0)
primaryIds.removeLast()
primaryIds.removeRange(Range(start: 2,end: 3))
primaryIds.removeAll()
print(primaryIds.isEmpty)

var coordA = CGPoint(x: 1, y: 1)
var coordB = CGPoint(x: 2, y: 2)
var coords = [coordA,coordB]
var copyOfCoords = coords
coordA.x = 3
//basic struct is value type doesn't change when source value change
print("coordA:\(coordA),coordB:\(coordB),coords:\(coords),copyOfCoords:\(copyOfCoords)")

var lists = ["NumberOfMilk":9,"MoneyLeft":1000,"distanceFromHome":10029]
lists["NumberOfMilk"]
let dict = ["Tom":"Cat"]
dict["Tom"]
let a :Int?

func maxInt(lhs:Int, rhs:Int) ->Int {
	if lhs > rhs {
		return lhs
	}
	return rhs
}

maxInt(3, rhs: 8)

func maxValue<T:Comparable>(lhs:T, rhs:T ) ->T {
	if lhs > rhs {
		return lhs
	}
	return rhs
}

maxValue(48.0, rhs: 333.211)
maxValue("a", rhs: "A")

func greetingMaker(greeting:String) ->(String ->String) {
	func greetingFunc(name:String) -> String {
		return "\(greeting) by \(name)"
	}
	return greetingFunc
}

var greetingFuncA = greetingMaker("Hello")
greetingFuncA("Wen")

var aFewNumbers = [1,2,3]
var squares = aFewNumbers.map ({ (num: Int ) -> Int in
	return num * num
})

let indexSizeAndValue = (9,10,"Hi")

switch indexSizeAndValue {
case (0,_,let value) :
	print("The first value is \(value)")
case let (index,size,"Hi") where index == (size-1):
	print("The last value is empty")
case let (index,size,value) where index == (size-1):
	print("The last value is \(value)")
case let (index,_,value):
	print("The value at index \(index) is \(value)")
}

func addString(aString:String, bString:String) -> Int? {
	let myString = aString + bString
	let myInt = Int(myString)

	return myInt
}
addString("12", bString: "323")

let aString = "23"
let b = Int(aString)

struct Student{
	let name: String
	var age: Int
	var school: String
}

var me = Student(name: "Wen", age: 22, school: "SCAU")
me.age = 33













