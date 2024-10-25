import Foundation
import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    private var rows: [String] {
        data.split(separator: "\n").compactMap { String($0) }
    }
    
    func part1() -> Any {
        rows.compactMap { numberFromStringPart1($0) }.reduce(0, +)
    }
    
    private func numberFromStringPart1(_ string: String) -> Int? {
        guard let first = string.first(where: { $0.isNumber }),
              let last = string.last(where: { $0.isNumber }),
              let resultInt = Int(String(first) + String(last)) else { return nil }
        return resultInt
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        return rows.compactMap { numberFromStringPart2($0) }.reduce(0, +)
    }
    
    let digits = [
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"
    ]
    
    /// Works 2: First - start from start. Last - start from end. (0.021256709 seconds)
    //  private func numberFromStringPart2(_ string: String) -> Int? {
    //    var firstInt = 0
    //    var firstCandidate = ""
    //    for (_, char) in string.enumerated() {
    //      if let int = Int(String(char)) {
    //        firstInt = int
    //        break
    //      }
    //      firstCandidate += String(char)
    //
    //      var hasVariant = false
    //      for (i, digit) in digits.enumerated() {
    //        if firstCandidate == digit {
    //          firstInt = i + 1
    //          break
    //        }
    //        if digit.hasPrefix(firstCandidate) {
    //          hasVariant = true
    //          break
    //        }
    //      }
    //      if firstInt != 0 {
    //        break
    //      }
    //      if !hasVariant {
    //        firstCandidate = String(firstCandidate.dropFirst())
    //      }
    //    }
    //    var lastInt = 0
    //    var lastCandidate = ""
    //    for (_, char) in string.enumerated().reversed() {
    //      if let int = Int(String(char)) {
    //        lastInt = int
    //        break
    //      }
    //      lastCandidate = String(char) + lastCandidate
    //
    //      var hasVariant = false
    //      for (i, digit) in digits.enumerated() {
    //        if lastCandidate == digit {
    //          lastInt = i + 1
    //          break
    //        }
    //        if digit.hasSuffix(lastCandidate) {
    //          hasVariant = true
    //          break
    //        }
    //      }
    //      if lastInt != 0 {
    //        break
    //      }
    //      if !hasVariant {
    //        lastCandidate = String(lastCandidate.dropLast())
    //      }
    //    }
    //    return Int("\(firstInt)\(lastInt)")
    //  }
    
    // -----------------------------
    
    /// Works: RegEx - positive lookahead (FASTEST: 0.013158208 seconds)
    private func numberFromStringPart2(_ string: String) -> Int? {
        let pattern = "(?=(\\d|" + digits.joined(separator: "|") + "))"
        let firstAndLast = findFirstAndLastOccurrences(input: string, pattern: pattern)
        guard let firstString = firstAndLast.firstOccurrence,
              let lastString = firstAndLast.lastOccurrence else { return nil }
        let firstInt: Int
        if let int = Int(firstString) {
            firstInt = int
        } else if let firstIndex = digits.firstIndex(of: firstString) {
            firstInt = firstIndex + 1
        } else {
            firstInt = 0
        }
        let lastInt: Int
        if let int = Int(lastString) {
            lastInt = int
        } else if let lastIndex = digits.lastIndex(of: lastString) {
            lastInt = lastIndex + 1
        } else {
            lastInt = 0
        }
        
        return Int("\(firstInt)\(lastInt)")
    }
    
    private func findFirstAndLastOccurrences(input: String, pattern: String) -> (firstOccurrence: String?, lastOccurrence: String?) {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
            if let firstMatch = matches.first,
               let lastMatch = matches.last {
                let firstSubstring = (input as NSString).substring(with: firstMatch.range(at: 1))
                let lastSubstring = (input as NSString).substring(with: lastMatch.range(at: 1))
                return (firstSubstring, lastSubstring)
            }
        } catch {
            print("Error creating regular expression: \(error)")
        }
        return (nil, nil)
    }
}
