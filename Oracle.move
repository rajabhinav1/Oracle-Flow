// creating multiple module wrapper for dynamic collection of cryptoassets display and validation 

module Wrapper1 {

// Get empty vector 
    use 0x1::Vector;
    
    // creating structure types for box and vector

    struct Box<T> {
        value: T
    }

    struct Wrapper1<T> {
        boxes: vector<Box<T>>
    }

// Assigning the values 
    public fun create_box<T>(value: T): Box<T> {
        Box { value }
    }

    // this method will be inaccessible for non-copyable contents
    public fun value<T: copy>(box: &Box<T>): T {
        *&box.value
    }
// Assigning the box a vector
    public fun create<T>(): wrapper1<T> {
        Shelf {
            boxes: Vector::empty<Box<T>>()
        }
    }

    // box value is moved to the vector
    
    public fun put<T>(wrapper1: &mut wrapper1<T>, box: Box<T>) {
        Vector::push_back<Box<T>>(&mut shelf.boxes, box);
    }

    public fun remove<T>(shelf: &mut Shelf<T>): Box<T> {
        Vector::pop_back<Box<T>>(&mut shelf.boxes)
    }
    
    // a collection is successfully made using the vector

    public fun size<T>(wrapper1: &Wrapper1<T>): u64 {
        Vector::length<Box<T>>(&wrapper1.boxes)
    }
}
// The operation is same as wrapper 1 , the additional module is to make the collection more dynamic and optimize on memory allocation and speed

Module Wrapper2 {

    use 0x1::Vector;

    struct Box<T> {
        value: T
    }

    struct Wrapper2<T> {
        boxes: vector<Box<T>>
    }

    public fun create_box<T>(value: T): Box<T> {
        Box { value }
    }

    // this method will be inaccessible for non-copyable contents
    public fun value<T: copy>(box: &Box<T>): T {
        *&box.value
    }

    public fun create<T>(): Wrapper2<T> {
        Shelf {
            boxes: Vector::empty<Box<T>>()
        }
    }

    // box value is moved to the vector
    public fun put<T>(wrapper2: &mut Wrapper2<T>, box: Box<T>) {
        Vector::push_back<Box<T>>(&mut wrapper2.boxes, box);
    }

    public fun remove<T>(shelf: &mut Wrapper2<T>): Box<T> {
        Vector::pop_back<Box<T>>(&mut shelf.boxes)
    }
 // Get the size of second dynamic vector
    public fun size<T>(wrapper2: &Wrapper2<T>): u64 {
        Vector::length<Box<T>>(&shelf.boxes)
    }
}

module Wrapper3 {

    use 0x1::Vector;

    struct Box<T> {
        value: T
    }

    struct Wrapper3<T> {
        boxes: vector<Box<T>>
    }

    public fun create_box<T>(value: T): Box<T> {
        Box { value }
    }    public fun value<T: copy>(box: &Box<T>): T {
        *&box.value
    }

    public fun create<T>(): Wrapper3<T> {
        Shelf {
            boxes: Vector::empty<Box<T>>()
        }
    }

    // box value is moved to the vector
    public fun put<T>(wrapper3: &mut Wrapper3<T>, box: Box<T>) {
        Vector::push_back<Box<T>>(&mut wrapper3.boxes, box);
    }

    public fun remove<T>(shelf: &mut Wrapper3<T>): Box<T> {
        Vector::pop_back<Box<T>>(&mut wrapper3.boxes)
    }

    public fun size<T>(shelf: &Wrapper3<T>): u64 {
        Vector::length<Box<T>>(&wrapper3.boxes)
    }
}

// calling the vector to create a collection 

script {
    use {{sender}}::cryptocoinaddress;

    fun main() {

        // create wrapper 1 , wrapper 2 and 2 boxes of type u64
        let Wrapper1 = Wrapper1::create<u64>();
        let Wrapper2=Wrapper2::create<u64>();
        let box_1 = Wrapper1::create_box<u64>(99);
        let box_2 = Wrapper2::create_box<u64>(999);

        // put both boxes to shelf
        Wrapper1::put(&mut shelf, box_1);
        Wrapper2::put(&mut shelf, box_2);

        // prints size - 2
        0x1::Debug::print<u64>(&Shelf::size<u64>(&wrapper1));
        0x1::Debug::print<u64>(&Shelf::size<u64>(&wrapper2));

        // then take one from shelf (last one pushed)
        let take_back = Wrapper1::remove(&mut shelf);
        let value     = Wrapper1::value<u64>(&take_back);

        // verify that the box we took back is one with 999
        assert(value == 999, 1);

        // and print size again - 1
        0x1::Debug::print<u64>(&Shelf::size<u64>(&shelf));
    }
}
