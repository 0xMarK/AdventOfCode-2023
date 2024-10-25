import XCTest
@testable import AdventOfCode

final class Day03Tests: XCTestCase {
    let testDataPart1 = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
    
    func testPart1() throws {
        let challenge = Day03(data: testDataPart1)
        XCTAssertEqual(String(describing: challenge.part1()), "4361")
    }
    
    let testDataPart11 = """
    ......#...
    ..592.....
    .*538..6&.
    617*......
    ........%1
    467..114..
    ...*......
    ..35..633.
    .........#
    $......58.
    ..592.....
    ......755.
    ...$.*....
    .664..598.
    """
    
    func testPart11() throws {
        let challenge = Day03(data: testDataPart11)
        XCTAssertEqual(String(describing: challenge.part1()), "5078")
    }
    
    // MARK: Part 2 -
    
    let testDataPart2 = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
    
    func testPart2() throws {
        let challenge = Day03(data: testDataPart2)
        XCTAssertEqual(String(describing: challenge.part2()), "467835")
    }
    
    let testDataPart21 = """
    617*58....
    ......12..
    ....*.....
    .664.598..
    .432.654..
    ....*.....
    .....+.58.
    ..234*....
    """
    
    func testPart21() throws {
        let challenge = Day03(data: testDataPart21)
        XCTAssertEqual(String(describing: challenge.part2()), "715386")
    }
}
