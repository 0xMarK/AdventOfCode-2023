import XCTest
@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day01Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testDataPart1 = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
    
    func testPart1() throws {
        let challenge = Day01(data: testDataPart1)
        XCTAssertEqual(String(describing: challenge.part1()), "142")
    }
    
    let testDataPart2 = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
    
    func testPart2() throws {
        let challenge = Day01(data: testDataPart2)
        XCTAssertEqual(String(describing: challenge.part2()), "281")
    }
    
    // "gneightwo5txxzpkctwojvrcgbd9"
    // "seven542nkngvnndrrlrmfbxdntwonehhc"
    // "fmcmjgvbfonesix3ninemninefivethree"
    let testDataPart21 = """
    bfonesix3ninemninefivethree
    """
    
    func testPart21() throws {
        let challenge = Day01(data: testDataPart21)
        XCTAssertEqual(String(describing: challenge.part2()), "13")
    }
}
