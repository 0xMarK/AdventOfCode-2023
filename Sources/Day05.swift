import Foundation
import Algorithms

struct Day05: AdventDay {
  
  init(data: String) {
    self.data = data
    fetchData()
  }
  
  var data: String
  
  private var seeds: [Int] = []
  
  private var seedToSoilRanges: [CorrespondanceRange] = []
  
  private var soilToFertilizerRanges: [CorrespondanceRange] = []
  
  private var fertilizerToWaterRanges: [CorrespondanceRange] = []
  
  private var waterToLightRanges: [CorrespondanceRange] = []
  
  private var lightToTemperatureRanges: [CorrespondanceRange] = []
  
  private var temperatureToHumidityRanges: [CorrespondanceRange] = []
  
  private var humidityToLocationRanges: [CorrespondanceRange] = []
  
  private mutating func fetchData() {
    let lines = data.components(separatedBy: "\n")
    fetchSeeds(lines: lines)
    seedToSoilRanges = fetchRanges(lines: lines, title: "seed-to-soil")
    soilToFertilizerRanges = fetchRanges(lines: lines, title: "soil-to-fertilizer")
    fertilizerToWaterRanges = fetchRanges(lines: lines, title: "fertilizer-to-water")
    waterToLightRanges = fetchRanges(lines: lines, title: "water-to-light")
    lightToTemperatureRanges = fetchRanges(lines: lines, title: "light-to-temperature")
    temperatureToHumidityRanges = fetchRanges(lines: lines, title: "temperature-to-humidity")
    humidityToLocationRanges = fetchRanges(lines: lines, title: "humidity-to-location")
  }
  
  private mutating func fetchSeeds(lines: [String]) {
    if let firstLine = lines.first {
      let keyValue = firstLine.split(separator: ": ")
      if keyValue.count > 1 {
        seeds = keyValue[1].split(separator: " ").compactMap { Int($0) }
      }
    }
  }
  
  private mutating func fetchRanges(lines: [String], title: String) -> [CorrespondanceRange] {
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
      }
    }
    if let destination {
      return destination
    } else {
      return source
    }
  }
  
  func part1() -> Any {
    var minLocation: Int = .max
    for seed in seeds {
      let soil = destination(source: seed, ranges: seedToSoilRanges)
      let fertilizer = destination(source: soil, ranges: soilToFertilizerRanges)
      let water = destination(source: fertilizer, ranges: fertilizerToWaterRanges)
      let light = destination(source: water, ranges: waterToLightRanges)
      let temperature = destination(source: light, ranges: lightToTemperatureRanges)
      let humidity = destination(source: temperature, ranges: temperatureToHumidityRanges)
      let location = destination(source: humidity, ranges: humidityToLocationRanges)
      if location < minLocation {
        minLocation = location
      }
    }
    return minLocation
  }
  
  func part2() -> Any {
    return 0
  }
  
}

private struct CorrespondanceRange {
  let destinationRangeStart: Int
  let sourceRangeStart: Int
  let rangeLength: Int
}
