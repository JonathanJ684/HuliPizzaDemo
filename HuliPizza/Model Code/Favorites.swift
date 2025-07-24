import SwiftUI

/// A Model for storing favorite menu items
class Favorites{
    /// Just an array, nothing to see here
    var favorites:[MenuItem]
    
    ///Initializing is to a blank favorites array.
    init(){
        self.favorites = []
    }
    
    ///A function to exclude one `MenuItem` array from another `MenuItem` array. Any matching elements are removed from the larger array.  Use for keeping items in the menu unique.
    static func excluded(from:[MenuItem], by:[MenuItem])->[MenuItem]{
            let firstSet:Set<MenuItem> = Set(from) //Convert to sets
            let secondSet:Set<MenuItem> = Set(by)
            let newSet = firstSet.symmetricDifference(secondSet) //Use sets to come up with a new, smaller set.
            return Array(newSet).sorted{$0.id < $1.id} //return as a sorted array by id.
            
        }
    
    
}
