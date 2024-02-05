# Advent of Code 2023 Swift Project

[![Language](https://img.shields.io/badge/language-Swift-red.svg)](https://swift.org)

Daily programming puzzles at [Advent of Code](<https://adventofcode.com/>), by
[Eric Wastl](<http://was.tl/>). This is a project with Advent of Code solutions.

The template was taken from https://github.com/apple/swift-aoc-starter-example.

## Challenges

The challenges assume three files (replace 00 with the day of the challenge).

- `Sources/Data/Day00.txt`: the input data provided for the challenge
- `Sources/Day00.swift`: the code to solve the challenge
- `Tests/Day00.swift`: any unit tests that you want to include

To start a new day's challenge, make a copy of these files, updating 00 to the 
day number.

```diff
// Add each new day implementation to this array:
let allChallenges: [any AdventDay] = [
-  Day00()
+  Day00(),
+  Day01(),
]
```

Then implement part 1 and 2. The `AdventOfCode.swift` file controls which challenge
is run with `swift run`. Add your new type to its `allChallenges` array. By default 
it runs the most recent challenge.

The `AdventOfCode.swift` file controls which day's challenge is run
with `swift run`. By default that runs the most recent challenge in the package.

To supply command line arguments use `swift run AdventOfCode`. For example,
`swift run -c release AdventOfCode --benchmark 3` builds the binary with full
optimizations, and benchmarks the challenge for day 3.

## Linting and Formatting

Challenge source code can be linted and formatted automatically using the
included dependency on `swift-format`.

Lint source code with the following command:

```shell
$ swift package lint-source-code
```

Format source code with the following command:

```shell
$ swift package format-source-code
Plugin ‘Format Source Code’ wants permission to write to the package directory.
Stated reason: “This command formats the Swift source files”.
Allow this plugin to write to the package directory? (yes/no)
```

To avoid the interactive prompt when formatting source code, use the 
`--allow-writing-to-package-directory` flag.
 
```shell
$ swift package format-source-code --allow-writing-to-package-directory
```

swift-format will use the built-in default style to lint and format code. A
`.swift-format` configuration file can be used to customize the style used, see
[Configuration](https://github.com/apple/swift-format/blob/main/Documentation/Configuration.md)
for more details. 
