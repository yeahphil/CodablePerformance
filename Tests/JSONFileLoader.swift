import Foundation

func airportsJSON(count: Int, resourceName: String = "airports") -> Data {
    let bundle = Bundle(for: PerformanceTests.self)
    let resource = "\(resourceName)\(count)"
    guard let url = bundle.url(forResource: resource, withExtension: "json"),
        let data = try? Data(contentsOf: url) else {
        fatalError()
    }
    
    return data
}
