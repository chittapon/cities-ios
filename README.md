# iOS City List

## Installation
```
pod install
```

## Search Algorithm
Using binary search from [swift-algorithm-club](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search).

And apply with array extension to return matching more than one element.

## The code and explanation
* To using binary search: the array must be sorted.
```
func binarySearchFilter(key: Element) -> [Element] {

    guard let middleIndex = binarySearch(key: key) else { return [] }

    /// Find left side start from middle index
    var lowerBound = middleIndex
    while lowerBound > startIndex {
        if self[lowerBound - 1] != key {
            break
        } else {
            lowerBound -= 1
        }
    }

    /// Find right side start from middle index
    var upperBound = middleIndex
    while upperBound < endIndex - 1 {
        if self[upperBound + 1] != key {
            break
        } else {
            upperBound += 1
        }
    }

    return Array(self[lowerBound...upperBound])
}
```
After we got the middle index from [binarySearch](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search) then we need to check element in left and right side until current element doesn't match with the key.
Then we can know lower bound and upper bound index that elements matching.

## Note
The important thing is how we implement `Comparable` and `Equatable`.
```
static func < (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
    return lhs.name.lowercased() < rhs.name.lowercased()
}

static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
    return lhs.name.lowercased().hasPrefix(rhs.name.lowercased())
}
```
In search case insensitive, This code convert string to lowercase for comparing element and search text is match with prefix or not.
You will see difference result of search String type and CityViewModel type in `BinarySearchTests`.

String need to match exactly with search text but `CityViewModel` can match insensitive case with prefix.
