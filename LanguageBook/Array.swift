import Foundation

extension Array {

    /// Attempt to cast array elements as per the supplied casting function ignoring any elements
    /// which fails the casting test (returning nil). The casting function should generally
    /// be of the form `{ $0 as TargetType }`.
    func cast<TX>(caster: T -> TX?) -> [TX] {
        return self.map(caster).filter({ $0 != nil }).map({ $0! })
    }
    
    /// Runs the supplied action on each element of the array without any modification to the array.
    /// Returns the original array upon finish.
    func each(action: T -> ()) -> [T] {
        for element in self { action(element) }
        return self
    }
    
    func flattenMap<U>(transform: (T) -> [U]) -> [U] {
        var result: [U] = []
        for list in self.map(transform) {
            result += list
        }
        
        return result
    }
    
    func min<U: Comparable>(quantifier: (T) -> U) -> T { return minMax(quantifier).min }
    func max<U: Comparable>(quantifier: (T) -> U) -> T! { return minMax(quantifier).max }
    
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
