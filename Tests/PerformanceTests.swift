
import XCTest
import Foundation
import AnyCodable
import ZippyJSON

@testable import Airport

let count = 10000 // 1, 10, 100, 1000, or 10000
let data = airportsJSON(count: count)

class PerformanceTests: XCTestCase {
    override class var defaultPerformanceMetrics: [XCTPerformanceMetric] {
        return [
            XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_WallClockTime"),
            XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TransientHeapAllocationsKilobytes")
        ]
    }
    
    //
    // MARK: - Codable
    //
    
    func testPerformanceCodable() {
        self.measure {
            let decoder = JSONDecoder()
            let airports = try! decoder.decode([Airport].self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    //
    // MARK: - JSONSerialization
    //
    
    func testPerformanceJSONSerialization() {
        self.measure {
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
            XCTAssertEqual(json.count, count)
        }
    }
    
    func testPerformanceJSONSerializationMappingToCodableType() {
        self.measure {
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
            let airports = json.map{ Airport(json: $0) }
            XCTAssertEqual(airports.count, count)
        }
    }
    
    //
    // MARK: - AnyJSON (from Supabase Realtime)
    //
    
    func testPerformanceAnyJSON() {
        self.measure {
            let decoder = AnyJSON.decoder
            let airports = try! decoder.decode(JSONArray.self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    func testPerformanceAnyJSONWithCodable() {
        self.measure {
            let decoder = AnyJSON.decoder
            let decodedJSON = try! decoder.decode(AnyJSON.self, from: data)
            let airports = try! decodedJSON.decode(as: [Airport].self)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    //
    // MARK: - AnyCodable
    //
    
    func testPerformanceAnyCodable() {
        self.measure {
            let decoder = AnyJSON.decoder
            let airports = try! decoder.decode([AnyCodable].self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    //
    // MARK: - ZippyJSON
    //
    
    func testZippyJSONDecoder() {
        self.measure {
            let decoder = ZippyJSONDecoder()
            let airports = try! decoder.decode([Airport].self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
}
