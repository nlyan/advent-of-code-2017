import streams
import strutils
import sequtils
import algorithm
import math

type
  Row = seq[int]
  Spreadsheet = seq[Row]

proc readSpreadsheetFile (path: string): Spreadsheet =
  var fs = newFileStream(path, fmRead)
  var spreadsheet: Spreadsheet = @[]
  var line = ""
  while fs.readLine(line):
    var row: Row = line.splitWhitespace().map(parseInt)
    if row.len != 0:
      spreadsheet.add(row)
  return spreadsheet

proc calculateChecksum (spreadsheet: Spreadsheet): int =
  result = 0
  for row in spreadsheet:
    var mini = row.foldl(min(a,b))
    var maxi = row.foldl(max(a,b))
    result += maxi - mini
  return result

# TODO: remove the need to mutate the rows by replacing above folds with a presort

iterator divisiblePairs (row: var Row): tuple[num: int, denom: int] =
  for i, upper in row.pairs:
    for j in i+1..<row.len:
      if (fmod(float64(upper), float64(row[j])) == 0):
        yield (upper, row[j])

proc calculateDivisiblePairChecksum (spreadsheet: var Spreadsheet): int =
  result = 0
  for row in spreadsheet.mitems:
    row.sort(system.cmp, Descending)
    for num, denom in divisiblePairs(row):
      result += int(num / denom)
  return result

var spreadsheet = readSpreadsheetFile("input.txt")
echo calculateChecksum(spreadsheet)
echo calculateDivisiblePairChecksum(spreadsheet)
