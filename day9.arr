use context dcic2024

include csv
include data-source

## Code from Intro
items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

fun calc-distance(r :: Row) -> Number:
  doc: "does distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  num-sqrt(num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"]))
where:
  calc-distance(items.row-n(0)) is-roughly num-sqrt(num-sqr(23) + num-sqr(-87))
  calc-distance(items.row-n(3)) is-roughly num-sqrt(num-sqr(-9) + num-sqr(64))
end

items-with-dist = build-column(items, "distance", calc-distance)

fun subtract-1(n :: Number) -> Number:
  doc: "subtracts 1 from input"
  n - 1
where:
  subtract-1(10) is 9
  subtract-1(0) is -1
  subtract-1(-3.5) is -4.5
end

moved-items = transform-column(items, "x-coordinate", subtract-1)

## Class Exercise: items

# Move all items 10% closer

fun reduce-by-ten-percent(n :: Number) -> Number:
  doc: "calculates ninety percent of its input"
  0.9 * n
where:
  reduce-by-ten-percent(1) is 0.9
  reduce-by-ten-percent(-100) is -90
  reduce-by-ten-percent(0) is 0
end

items-with-closer-x = transform-column(items, "x-coordinate", reduce-by-ten-percent)
items-with-closer-xy = transform-column(items-with-closer-x, "y-coordinate", reduce-by-ten-percent)

# Find closest item

fun calc-rounded-distance(r :: Row) -> Number:
  doc: "does distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  num-round(calc-distance(r))
where:
  calc-rounded-distance(items.row-n(0)) is 90
  calc-rounded-distance(items.row-n(3)) is 65
end

closer-items-with-dist = build-column(items-with-closer-xy, "distance", calc-rounded-distance)

sorted-closer-items = order-by(closer-items-with-dist, "distance", false) # error

closest-item = sorted-closer-items.row-n(0)

# Obfuscate names

fun obfuscate(item :: String) -> String:
  doc: "Replaces each character in item with 'X'"
  string-repeat("X", string-length(item))
where:
  obfuscate("ring") is "XXXX"
  obfuscate("") is ""
end

obfuscated-items = transform-column(items, "item", obfuscate)

# Load the employee earnings csv file

earnings = load-table:
  name :: String,
  department-name :: String,
  title :: String,
  regular :: String,
  retro :: String,
  other :: String,
  overtime :: String,
  injured :: String,
  detail :: String,
  quinn-education :: String,
  total-gross :: String,
  postal :: String
    
  source: csv-table-url("https://data.boston.gov/dataset/418983dc-7cae-42bb-88e4-d56f5adcf869/resource/579a4be3-9ca7-4183-bc95-7d67ee715b6d/download/employee_earnings_report_2024.csv", default-options) 
end
    
# Calculate the total earnings excluding DETAIL column

fun string-to-number-unsafe(s :: String) -> Number:
  doc: "Converts the given string to a number, returning 0 if not well formatted"
  string-to-number(string-replace(s, ",", "")).or-else(0)
where:
  string-to-number-unsafe("1234") is 1234
  string-to-number-unsafe("-1.3") is -1.3
  string-to-number-unsafe("hello") is 0
end

fun calc-earnings-without-detail(r :: Row) -> Number:
  doc: "Calculates earnings excluding detail"
  string-to-number-unsafe(r["total-gross"]) - string-to-number-unsafe(r["detail"])
end

earnings-without-details = build-column(earnings, "total-without-detail", calc-earnings-without-detail)

# Sort by highest paid
order-by(earnings-without-details, "total-without-detail", false)

# Sort by lowest paid
order-by(earnings-without-details, "total-without-detail", true)

