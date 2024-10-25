import Foundation
import Algorithms

struct Day06: AdventDay {
    
    var data: String
    
    private var rows: [String] {
        data.split(separator: "\n").compactMap { String($0) }
    }
    
    private var parsedRowsPart1: [[Int]] {
        rows.compactMap {
            $0.split(separator: ":").last?.split(separator: " ").compactMap { Int($0) }
        }
    }
    
    private var parsedRowsPart2: [[Int]] {
        rows.compactMap {
            [Int($0.split(separator: ":").last?.replacingOccurrences(of: " ", with: "") ?? "") ?? 0]
        }
    }
    
    func part1() -> Any {
        print("Part 1 started")
        return totalWinsMultiplied(table: table(parsedRows: parsedRowsPart1))
    }
    
    func part2() -> Any {
        print("Part 2 started")
        return totalWinsMultiplied(table: table(parsedRows: parsedRowsPart2))
    }
    
    private func table(parsedRows: [[Int]]) -> [Int: Int] {
        var table: [Int: Int] = [:]
        guard parsedRows.count > 1 else { return [:] }
        for (i, time) in parsedRows[0].enumerated() {
            table[time] = parsedRows[1][i]
        }
        return table
    }
    
    private func totalWinsMultiplied(table: [Int: Int]) -> Int {
        var totalWinsMultiplied = 1
        for (time, distance) in table {
            var winCount = 0
            for t in 1..<time {
                let travelTime = time - t
                let travelDistance = travelTime * t
                if travelDistance > distance {
                    winCount += 1
                }
            }
            totalWinsMultiplied *= winCount
        }
        return totalWinsMultiplied
    }
}
