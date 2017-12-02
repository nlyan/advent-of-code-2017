import streams
import strutils
import sequtils

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

var spreadsheet = readSpreadsheetFile("input.txt")
var checksum = calculateChecksum(spreadsheet)

echo checksum
