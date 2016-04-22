//Collections
import UIKit

//1---Arrays and Mutability----------------------------------------

//arrays have value semantics, means value never shared
//a copy is made when assigning an existing array to a new variable

var x = [1,2,3]
var y = x
y.append(4)

let a = NSMutableArray(array: [1,2,3])
let b :NSArray = a
//prevent changing using copy method
let c = a.copy() as! NSArray
a.insertObject(4, atIndex: 3)
//although b is immutable, but it is still changed, value same as a.
b
c

//Swift library using a technique called copy-on-write, 
//make sure data is copied when necessary
//it means it is only doing copy until certain change func is called
//-------------------------------------------------------------------

//2---Transforming Arrays--------------------------------------------

//normal way to square fibs arrays
let fibs = [0,1,1,2,3,5]
var squared:[Int] = []
for fib in fibs {
	squared.append(fib * fib)
}
print(squared)

let squared2 = fibs.map{fib in fib * fib}
print(squared2)

//Common pattern of parameterizing behavior in Swift library

//map, flatMap: transform an element

//each element plus 2
let fib1 = fibs.map{ fib in ((fib > 2) ? (fib+2 as Int?) : nil)}
fib1
//
let fib2 = fibs.flatMap{ fib in ((fib > 2) ? (fib+2 as Int?) : nil)}
fib2

//filter: should an elemnt be included
let fib3 = fibs.filter{fib in fib > 3}
fib3

//reduce: fold an element into an aggregate value
//sort, lexicographicCompare: order value
//indexOf, contains: match value
//minElement, maxElement: min and max value
//elementsEqual, startsWith: check equivalent
//split: separater elements

let v = UIColor(colorLiteralRed: 51.0, green: 200.0, blue: 15.0, alpha: 1)
print(v)






