import Foundation
import Algorithms

struct Day06: AdventDay {
    
    var data: String
    
    private var rows: [String] {
        data.split(separator: "\n").compactMap { String($0) }
    }
    
    func part1() -> Any {
        print("Part 1 started")
        let table = table()
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
    
    func part2() -> Any {
        print("Part 2 started")
        return 0
    }
    
    private func table() -> [Int: Int] {
        var table: [Int: Int] = [:]
        let parsedRows = rows.compactMap { $0.split(separator: ":").last?.split(separator: " ").compactMap { Int($0) } }
        guard parsedRows.count > 1 else { return [:] }
        for (i, time) in parsedRows[0].enumerated() {
            table[time] = parsedRows[1][i]
        }
        return table
    }
}
