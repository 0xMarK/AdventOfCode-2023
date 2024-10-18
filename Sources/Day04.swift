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
      let winning = winningNumbers(row)
      var points = 0
      if !winning.isEmpty {
        points = 1
        for _ in 1..<winning.count {
          points *= 2
        }
      }
      sum += points
    }
    return sum
  }
  
  func part2() -> Any {
    var sum = 0
    var cardCopies: [Int: Int] = [:]
    for (r, row) in rows.enumerated() {
      let currentCardCopies = cardCopies[r] ?? 1
      sum += currentCardCopies
      let winning = winningNumbers(row)
      for i in (r + 1)..<(r + 1) + winning.count {
        let upcomingCardCopies = cardCopies[i] ?? 1
        cardCopies[i] = upcomingCardCopies + currentCardCopies
      }
    }
    return sum
  }
  
  private func winningNumbers(_ row: String) -> Set<Int> {
    let winningAndAvailable = row.split(separator: ": ")[1].split(separator: " | ")
    let winning = Set(winningAndAvailable[0].split(separator: " ").compactMap { Int(String($0)) })
    let available = Set(winningAndAvailable[1].split(separator: " ").compactMap { Int(String($0)) })
    return available.intersection(winning)
  }
}
