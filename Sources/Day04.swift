import Foundation
import Algorithms

struct Day04: AdventDay {
  
  var data: String
  
  private var rows: [String] {
    data.split(separator: "\n").compactMap { String($0) }
  }
  
  func part1() -> Any {
    var sum = 0
    for row in rows {
      let winningAndAvailable = row.split(separator: ": ")[1].split(separator: " | ")
      let winning = Set(winningAndAvailable[0].split(separator: " ").compactMap { Int(String($0)) })
      let available = Set(winningAndAvailable[1].split(separator: " ").compactMap { Int(String($0)) })
      let availableWinning = available.intersection(winning)
      var points = 0
      if !availableWinning.isEmpty {
        points = 1
        for _ in 1..<availableWinning.count {
          points *= 2
        }
      }
      sum += points
    }
    return sum
  }
  
  func part2() -> Any {
    return 0
  }
}
