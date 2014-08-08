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
}
