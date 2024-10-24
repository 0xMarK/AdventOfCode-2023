import Foundation
import Algorithms

struct Day05: AdventDay {
  
  init(data: String) {
    self.data = data
    fetchData()
  }
  
  var data: String
  
  private var seedsPart1: [Int] = []
  
  private var seedsPart2: [Int] = []
  
  private var seedToSoilRanges: [CorrespondanceRange] = []
  
  private var soilToFertilizerRanges: [CorrespondanceRange] = []
  
  private var fertilizerToWaterRanges: [CorrespondanceRange] = []
  
  private var waterToLightRanges: [CorrespondanceRange] = []
  
  private var lightToTemperatureRanges: [CorrespondanceRange] = []
  
  private var temperatureToHumidityRanges: [CorrespondanceRange] = []
  
  private var humidityToLocationRanges: [CorrespondanceRange] = []
  
  private mutating func fetchData() {
    let lines = data.components(separatedBy: "\n")
    seedToSoilRanges = fetchRanges(lines: lines, title: "seed-to-soil")
    soilToFertilizerRanges = fetchRanges(lines: lines, title: "soil-to-fertilizer")
    fertilizerToWaterRanges = fetchRanges(lines: lines, title: "fertilizer-to-water")
    waterToLightRanges = fetchRanges(lines: lines, title: "water-to-light")
    lightToTemperatureRanges = fetchRanges(lines: lines, title: "light-to-temperature")
    temperatureToHumidityRanges = fetchRanges(lines: lines, title: "temperature-to-humidity")
    humidityToLocationRanges = fetchRanges(lines: lines, title: "humidity-to-location")
  }
  
  private func fetchSeedsPart1() -> [Range<Int>] {
    let lines = data.split(separator: "\n")
    guard let firstLine = lines.first else { return [] }
    let keyValue = firstLine.split(separator: ": ")
    guard keyValue.count > 1 else { return [] }
    return keyValue[1].split(separator: " ").compactMap {
      guard let number = Int($0) else { return nil }
      return Range<Int>(number...number)
    }
  }
  
  private func fetchSeedsPart2() -> [Range<Int>] {
    var seeds: [Range<Int>] = []
    let values = fetchSeedsPart1()
    for (i, v) in values.enumerated() {
      guard i % 2 == 0 else { continue }
      let range = (v.startIndex)..<(v.startIndex + values[i + 1].startIndex)
      seeds.append(range)
    }
    return seeds
  }
  
  private func fetchRanges(lines: [String], title: String) -> [CorrespondanceRange] {
    var ranges: [CorrespondanceRange] = []
    guard let seedToSoilLineIndex = lines.firstIndex(where: { $0.hasPrefix(title) }) else { return [] }
    for i in (seedToSoilLineIndex + 1)..<lines.count {
      guard !lines[i].isEmpty else { break }
      let items = String(lines[i]).split(separator: " ")
      ranges.append(CorrespondanceRange(
        destinationRangeStart: Int(items[0]) ?? 0,
        sourceRangeStart: Int(items[1]) ?? 0,
        rangeLength: Int(items[2]) ?? 0
      ))
    }
    return ranges
  }
  
  private func destination(source: Int, ranges: [CorrespondanceRange]) -> Int {
    var destination: Int?
    for range in ranges {
      if source >= range.sourceRangeStart,
         source < range.sourceRangeStart + range.rangeLength {
        let offset = source - range.sourceRangeStart
        destination = range.destinationRangeStart + offset
        break
      }
    }
    if let destination {
      return destination
    } else {
      return source
    }
  }
  
  private func subtractRanges(inputRange: Range<Int>, intersectionRange: Range<Int>) -> Set<Range<Int>> {
    guard inputRange.overlaps(intersectionRange) else {
      return [inputRange]
    }
    var resultRanges: Set<Range<Int>> = []
    if intersectionRange.lowerBound > inputRange.lowerBound {
      resultRanges.insert(inputRange.lowerBound..<intersectionRange.lowerBound)
    }
    if intersectionRange.upperBound < inputRange.upperBound {
      resultRanges.insert(intersectionRange.upperBound..<inputRange.upperBound)
    }
    return resultRanges
  }
  
  private func intersection(inputRanges: Set<Range<Int>>, correspondanceRanges: [CorrespondanceRange]) -> Set<Range<Int>> {
    var outputRanges: Set<Range<Int>> = []
    var additionalInputRanges: Set<Range<Int>> = []
    for inputRange in inputRanges {
      var hasIntersection = false
      for correspondanceRange in correspondanceRanges {
        let sourceRange = correspondanceRange.sourceRangeStart..<(correspondanceRange.sourceRangeStart + correspondanceRange.rangeLength)
        
        let intersection = inputRange.clamped(to: sourceRange)
        if !intersection.isEmpty {
          hasIntersection = true
          let offset = correspondanceRange.destinationRangeStart - correspondanceRange.sourceRangeStart
          outputRanges.insert((intersection.lowerBound + offset)..<(intersection.upperBound + offset))
          
          let subtractedInputRanges = subtractRanges(inputRange: inputRange, intersectionRange: intersection)
          additionalInputRanges.formUnion(subtractedInputRanges)
        }
      }
      if !hasIntersection {
        outputRanges.insert(inputRange)
      }
    }
    
    for inputRange in additionalInputRanges {
        var hasIntersection = false
        for correspondanceRange in correspondanceRanges {
          let sourceRange = correspondanceRange.sourceRangeStart..<(correspondanceRange.sourceRangeStart + correspondanceRange.rangeLength)
          
          let intersection = inputRange.clamped(to: sourceRange)
          if !intersection.isEmpty {
            hasIntersection = true
            let offset = correspondanceRange.destinationRangeStart - correspondanceRange.sourceRangeStart
            outputRanges.insert((intersection.lowerBound + offset)..<(intersection.upperBound + offset))
          }
        }
        if !hasIntersection {
          outputRanges.insert(inputRange)
        }
    }
    return outputRanges
  }
  
  private func minLocation(seeds: [Range<Int>]) -> Int {
    let soilRanges = intersection(inputRanges: Set(seeds), correspondanceRanges: seedToSoilRanges)
    let fertilizerRanges = intersection(inputRanges: soilRanges, correspondanceRanges: soilToFertilizerRanges)
    let waterRanges = intersection(inputRanges: fertilizerRanges, correspondanceRanges: fertilizerToWaterRanges)
    let lightRanges = intersection(inputRanges: waterRanges, correspondanceRanges: waterToLightRanges)
    let temperatureRanges = intersection(inputRanges: lightRanges, correspondanceRanges: lightToTemperatureRanges)
    let humidityRanges = intersection(inputRanges: temperatureRanges, correspondanceRanges: temperatureToHumidityRanges)
    let locationRanges = intersection(inputRanges: humidityRanges, correspondanceRanges: humidityToLocationRanges)
    var minLocation: Int = .max
    for locationRange in locationRanges {
      if locationRange.lowerBound < minLocation {
        minLocation = locationRange.lowerBound
      }
    }
    return minLocation
  }
  
  func part1() -> Any {
    print("Part 1 started")
    return minLocation(seeds: fetchSeedsPart1())
  }
  
  func part2() -> Any {
    print("Part 2 started")
    return minLocation(seeds: fetchSeedsPart2())
  }
  
}

private struct CorrespondanceRange {
  let destinationRangeStart: Int
  let sourceRangeStart: Int
  let rangeLength: Int
}
