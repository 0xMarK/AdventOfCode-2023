import XCTest
@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    let testData = """
    Time:      7  15   30
    Distance:  9  40  200
    """
    
    func testPart1() throws {
        let challenge = Day06(data: testData)
        let result = challenge.part1()
        XCTAssertEqual(String(describing: result), "288")
    }
    
    // MARK: Part 2 -
    
    func testPart2() throws {
        let challenge = Day06(data: testData)
        let result = challenge.part2()
        XCTAssertEqual(String(describing: result), "71503")
    }
    
}
