import Foundation
import Algorithms

struct Day03: AdventDay {
    
    var data: String
    
    private var rows: [String] {
        data.split(separator: "\n").compactMap { String($0) }
    }
    
    func part1() -> Any {
        var lines: [Line] = []
        for (r, row) in rows.enumerated() {
            var line = parseLine(input: row)
            let prevLine: Line?
            if r > 0 {
                prevLine = lines[r - 1]
            } else {
                prevLine = nil
            }
            for (i, item) in line.items.enumerated() {
                if i > 0  {
                    let prevItem = line.items[i - 1]
                    if case .symbol = prevItem.type,
                       case .number = item.type,
                       prevItem.endIndex == item.startIndex {
                        line.items[i].isActive = true
                    }
                    if case .symbol = item.type,
                       case .number = prevItem.type,
                       prevItem.endIndex == item.startIndex {
                        line.items[i - 1].isActive = true
                    }
                }
                if case .number = item.type,
                   !item.isActive,
                   let prevLine = prevLine {
                    let startIndex = item.startIndex == row.startIndex ? item.startIndex : row.index(before: item.startIndex)
                    let itemRange = startIndex...item.endIndex
                    for (_, prevLineItem) in prevLine.items.enumerated() {
                        if case .symbol = prevLineItem.type,
                           itemRange.contains(prevLineItem.startIndex) {
                            line.items[i].isActive = true
                        }
                    }
                }
                if case .symbol = item.type,
                   let prevLine = prevLine {
                    for (pi, prevLineItem) in prevLine.items.enumerated() {
                        if case .number = prevLineItem.type,
                           !prevLineItem.isActive {
                            let startIndex = prevLineItem.startIndex == row.startIndex ? prevLineItem.startIndex : row.index(before: prevLineItem.startIndex)
                            let prevLineItemRange = startIndex...prevLineItem.endIndex
                            if prevLineItemRange.contains(item.startIndex) {
                                lines[r - 1].items[pi].isActive = true
                            }
                        }
                    }
                }
            }
            lines.append(line)
        }
        return lines.flatMap { $0.items }.filter { $0.isActive }.map { if case .number(let n) = $0.type { n } else { 0 } }.reduce(0, +)
    }
    
    private func parseLine(input: String) -> Line {
        let pattern = /\d+|[^.\d]/
        let results = input.matches(of: pattern)
        var line = Line(items: [])
        for result in results {
            let o = result.output
            if let i = Int(o) {
                line.items.append(Item(type: .number(i), startIndex: o.startIndex, endIndex: o.endIndex))
            } else {
                line.items.append(Item(type: .symbol(String(o)), startIndex: o.startIndex, endIndex: o.endIndex))
            }
        }
        return line
    }
    
    func part2() -> Any {
        var lines: [Line] = []
        for (r, row) in rows.enumerated() {
            var line = parseLine(input: row)
            let prevLine: Line?
            if r > 0 {
                prevLine = lines[r - 1]
            } else {
                prevLine = nil
            }
            for (i, item) in line.items.enumerated() {
                if i > 0  {
                    let prevItem = line.items[i - 1]
                    if case .symbol(let symbol) = prevItem.type,
                       symbol == "*",
                       case .number = item.type,
                       prevItem.endIndex == item.startIndex {
                        line.items[i - 1].connectedParts.append(item)
                    }
                    if case .symbol(let symbol) = item.type,
                       symbol == "*",
                       case .number = prevItem.type,
                       prevItem.endIndex == item.startIndex {
                        line.items[i].connectedParts.append(prevItem)
                    }
                }
                if let prevLine = prevLine {
                    if case .number = item.type {
                        let startIndex = item.startIndex == row.startIndex ? item.startIndex : row.index(before: item.startIndex)
                        let itemRange = startIndex...item.endIndex
                        for (prevLineItemIndex, prevLineItem) in prevLine.items.enumerated() {
                            if case .symbol(let symbol) = prevLineItem.type,
                               symbol == "*",
                               itemRange.contains(prevLineItem.startIndex) {
                                lines[r - 1].items[prevLineItemIndex].connectedParts.append(item)
                            }
                        }
                    }
                    if case .symbol(let symbol) = item.type,
                       symbol == "*" {
                        for prevLineItem in prevLine.items {
                            if case .number = prevLineItem.type {
                                let startIndex = prevLineItem.startIndex == row.startIndex ? prevLineItem.startIndex : row.index(before: prevLineItem.startIndex)
                                let prevLineItemRange = startIndex...prevLineItem.endIndex
                                if prevLineItemRange.contains(item.startIndex) {
                                    line.items[i].connectedParts.append(prevLineItem)
                                }
                            }
                        }
                    }
                }
            }
            lines.append(line)
        }
        return lines
            .flatMap { $0.items }
            .filter { $0.connectedParts.count == 2}
            .map {
                let values = $0.connectedParts.map { if case .number(let n) = $0.type { return n } else { return 1 } }
                return values.reduce(1, *)
            }
            .reduce(0, +)
    }
}

extension Day03 {
    struct Line {
        var items: [Item]
    }
    
    struct Item {
        enum ItemType {
            case number(Int)
            case symbol(String)
        }
        var isActive: Bool = false
        let type: ItemType
        let startIndex: String.Index
        let endIndex: String.Index
        var connectedParts: [Item] = []
    }
}
