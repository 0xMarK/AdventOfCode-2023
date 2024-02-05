import Foundation
import Algorithms

struct Day02: AdventDay {
  
  var data: String
  
  private var rows: [String] {
    data.split(separator: "\n").compactMap { String($0) }
  }
  
  private let bag = Cubes(red: 12, green: 13, blue: 14)
  
  func part1() -> Any {
    rows.compactMap { numberFromStringPart1($0) }.reduce(0, +)
  }
  
  private func numberFromStringPart1(_ string: String) -> Int? {
    guard let game = parse(input: string) else { return nil }
    for cubes in game.cubesSet {
      if cubes > bag {
        return nil
      }
    }
    return game.gameID
  }
  
  private func parse(input: String) -> (gameID: Int, cubesSet: [Cubes])? {
    var cubesSet: [Cubes] = []
    var gameID: Int = 0
    
    let gamePattern = /Game (\d+):/
    
    guard let result = input.firstMatch(of: gamePattern),
          let gameInt = Int(result.output.1) else { return nil }
    gameID = gameInt
    
    let cubesPattern2 = /(((?<firstNumber>\d+) (?<firstColor>red|green|blue),? ?)((?<secondNumber>\d+) (?<secondColor>red|green|blue),? ?)?((?<thirdNumber>\d+) (?<thirdColor>red|green|blue))?;?)/
    let cubesResult2 = input.matches(of: cubesPattern2)
    
    for result in cubesResult2 {
      let o = result.output
      let number1 = Int(o.firstNumber) ?? 0
      let color1 = String(o.firstColor)
      let number2 = Int(o.secondNumber ?? "")
      let color2 = String(o.secondColor ?? "")
      let number3 = Int(o.thirdNumber ?? "")
      let color3 = String(o.thirdColor ?? "")
      let cubes = Cubes(number1: number1, color1: color1, number2: number2, color2: color2, number3: number3, color3: color3)
      cubesSet.append(cubes)
    }
    
    return (gameID: gameID, cubesSet: cubesSet)
  }
  
  func part2() -> Any {
    return rows.compactMap { numberFromStringPart2($0) }.reduce(0, +)
  }
  
  private func numberFromStringPart2(_ string: String) -> Int? {
    guard let game = parse(input: string) else { return nil }
    
    var power = Cubes(red: 0, green: 0, blue: 0)
    
    for cubes in game.cubesSet {
      if cubes.red > power.red {
        power.red = cubes.red
      }
      if cubes.green > power.green {
        power.green = cubes.green
      }
      if cubes.blue > power.blue {
        power.blue = cubes.blue
      }
    }
    
    return power.red * power.green * power.blue
  }
  
}

extension Day02 {
  
  struct Cubes {
    
    var red: Int
    var green: Int
    var blue: Int
    
    init(red: Int, green: Int, blue: Int) {
      self.red = red
      self.green = green
      self.blue = blue
    }
    
    init(number1: Int, color1: String, number2: Int?, color2: String?, number3: Int?, color3: String?) {
      var red = 0
      var green = 0
      var blue = 0
      switch color1 {
      case "red":
        red = number1
      case "green":
        green = number1
      case "blue":
        blue = number1
      default:
        break
      }
      switch color2 {
      case "red":
        red = number2 ?? 0
      case "green":
        green = number2 ?? 0
      case "blue":
        blue = number2 ?? 0
      default:
        break
      }
      switch color3 {
      case "red":
        red = number3 ?? 0
      case "green":
        green = number3 ?? 0
      case "blue":
        blue = number3 ?? 0
      default:
        break
      }
      self.red = red
      self.green = green
      self.blue = blue
    }
  }
  
}

extension Day02.Cubes: Equatable {
  
  static func == (lhs: Day02.Cubes, rhs: Day02.Cubes) -> Bool {
    return lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue
  }
  
  static func > (lhs: Day02.Cubes, rhs: Day02.Cubes) -> Bool {
    return lhs.red > rhs.red || lhs.green > rhs.green || lhs.blue > rhs.blue
  }
  
}
