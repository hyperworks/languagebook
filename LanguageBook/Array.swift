import Foundation

// TODO: Rewrote this in Swift's top-level function style where we can apply more constraints and
//   opt for a more performant impl. Also Swift already has a bunch of sequence manipulation funcs.
//   See uniq() for a start
extension Array {

    /// Finds the first element in the array that matches the given predicate.
    func first(predicate: (T) -> Bool) -> T! {
        for element in self { if predicate(element) { return element } }
        return nil
    }

    /// Attempt to cast array elements as per the supplied casting function ignoring any elements
    /// which fails the casting test (returning nil). The casting function should generally
    /// be of the form `{ $0 as? TargetType }`.
    func cast<TX>(caster: T -> TX?) -> [TX] {
        return self.map(caster).filter({ $0 != nil }).map({ $0! })
    }
    
    /// Runs the supplied action on each element of the array without any modification to the array.
    /// Returns the original array upon finish.
    func each(action: T -> ()) -> [T] {
        for element in self { action(element) }
        return self
    }
    
    /// Maps each single element into an array and return concatenated result.
    func flattenMap<U>(transform: (T) -> [U]) -> [U] {
        var result: [U] = []
        for list in self.map(transform) {
            result += list
        }
        
        return result
    }
    
    // Pairs each element in this array with element from supplied array at the same index position
    // and return an array of tuples. The number of returned elements is the minimum of the length
    // of both arrays.
    func zip<U>(with another: [U]) -> [(T, U)] {
        let count = self.count > another.count ? self.count : another.count
        
        var results: [(T, U)] = []
        results.reserveCapacity(count)
        for var i = 0; i < count; i++ {
            let tuple = (self[i], another[i])
            results.append(tuple)
        }
        
        return results
    }
    
    
    /// Folds the array leftwise into a single value.
    func foldl<U>(var seed acc: U, folder: (U, T) -> U) -> U {
        for item in self { acc = folder(acc, item) }
        return acc
    }
    
    /// Folds the array backwards from the right into a single value.
    func foldr<U>(var seed acc: U, folder: (U, T) -> U) -> U {
        for item in self.reverse() { acc = folder(acc, item) }
        return acc
    }
    
    /// Runs the scanner function for each element with an accumulator and returns the results.
    func scan<U>(var seed acc: U, scanner: (U,  T) -> U) -> [U] {
        return self.map({ acc = scanner(acc, $0); return acc })
    }
    
    /// Similar to map, but with the element index passed to the transform function in addition to
    /// the individual array elements.
    func mapi<U>(transform: (Int, T) -> U) -> [U] {
        let count = self.count
        
        var results: [U] = []
        results.reserveCapacity(count)
        for var i = 0; i < count; i++ {
            results.append(transform(i, self[i]))
        }
        
        return results
    }
    
    /// Finds the minimum item in the array according to the quantifier function.
    func min<U: Comparable>(quantifier: (T) -> U) -> T! { return minMax(quantifier).min }
    
    /// Finds the maximum item in the array according to the quantifier function.
    func max<U: Comparable>(quantifier: (T) -> U) -> T! { return minMax(quantifier).max }
    
    /// Finds the minimum and the maximum item in the array according to the quantifier function.
    func minMax<U: Comparable>(quantifier: (T) -> U) -> (min: T, max: T)! {
        if self.count == 0 { return nil }
        
        var (minItem, minValue) = (self[0], quantifier(self[0]))
        var (maxItem, maxValue) = (minItem, minValue)
        var (largeItem, largeValue): (T, U)
        var (smallItem, smallValue): (T, U)
        
        let startIndex = self.count % 2 == 0 ? 1 : 2
        for var i = startIndex; i < self.count; i += 2 {
            let (item1, v1) = (self[i], quantifier(self[i]))
            let (item2, v2) = (self[i-1], quantifier(self[i-1]))
            
            if v1 > v2 {
                (largeItem, largeValue) = (item1, v1)
                (smallItem, smallValue) = (item2, v2)
            } else {
                (largeItem, largeValue) = (item2, v2)
                (smallItem, smallValue) = (item1, v1)
            }
            
            if smallValue < minValue { (minValue, minItem) = (smallValue, smallItem) }
            if largeValue > maxValue { (maxValue, maxItem) = (largeValue, largeItem) }
        }
        
        return (minItem, maxItem)
    }
}

func uniq<T: protocol<Equatable, Hashable>>(seq: [T]) -> [T] {
    var tally: [T: Bool] = [:]
    var result: [T] = []
    result.reserveCapacity(seq.count)
    
    for item in seq {
        if tally[item]? == true { continue }
        
        tally[item] = true
        result += [item]
    }
    
    return result
}
