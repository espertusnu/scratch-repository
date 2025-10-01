use context dcic2024

# INTRO

weather-data =
  table: date, temperature, precipitation
    row: "2025-01-01", 62, 0.1
    row: "2025-01-02", "45", 3
    row: "2025-01-03", 28, 0.2
    row: "2025-01-04", 55, -1
    row: "2025-01-05", 90, 0
  end

fun normalize-temp(v) -> Number:
  doc: "given a number or a string that represents a number, converts to a number"
  if is-string(v): 
    string-to-number(v).or-else(0)
  else: 
    v
  end
where:
  normalize-temp(10) is 10
  normalize-temp("13") is 13
end

fixed-data = transform-column(weather-data, "temperature", normalize-temp)

fun bucket-temp(t :: Number) -> String:
  doc: "numbers < 40 turn into 'cold', >=40 and < 60 to 'mild' and >=60 to 'hot'"
  if t < 40:
    "cold"
  else if t < 60:
    "mild"
  else:
    "hot"
  end
where:
  bucket-temp(-10) is "cold"
  bucket-temp(0) is "cold"
  bucket-temp(39.9) is "cold"
  bucket-temp(40) is "mild"
  bucket-temp(58) is "mild"
  bucket-temp(60) is "hot"
  bucket-temp(100) is "hot"
end

with-buckets = build-column(fixed-data, "temp-category", lam(r :: Row) -> String: bucket-temp(r["temperature"]) end)


# EXERCISE 1 PLAN
# 1. Decide how to treat negative precipitation.
# 2. Write function bucket-precip with these conversions:
#    - "dry" (<= 0)
#    - "drizzly" (< 1)
#    - "wet"
# 3. Add column "precip-category" using bucket-precip.
# 4. Display precip-category data.

fun bucket-precip(amount :: Number) -> String:
  doc: "numbers <= 0 turn into 'dry', >= 1 turn into 'wet', otherwise 'drizzly'"
  if amount <= 0:
    "dry"
  else if amount >= 1:
    "wet"
  else:
    "drizzly"
  end
where:
  bucket-precip(-1) is "dry"
  bucket-precip(0) is "dry"
  bucket-precip(0.5) is "drizzly"
  bucket-precip(1.0) is "wet"
  bucket-precip(1.5) is "wet"
end

with-precip-buckets = build-column(with-buckets, "precip-category", lam(r :: Row) -> String: bucket-precip(r["precipitation"]) end)

freq-bar-chart(with-precip-buckets, "precip-category")

employees =
  table: full-name :: String, department :: String
    row: "Jordan Smith", "Sales"
    row: "Alexandra Lee", "Engineering"
    row: "Sam", "Marketing"
    row: "Ng, Alice", "Operations"
  end


# EXERCISE 2 PLAN
# 0. Decide what to do for a mononym (like "Zendaya") or for a 3-part name (like "Millie Bobby Brown").
# 1. Write function get-first-name(s :: String).
# 2. Write function get-last-name(s :: String).
# 3. Add column "first-name" with get-first-name.
# 4. Add column "last-name" with get-last-name.

fun get-first-name(s :: String) -> String:
  doc: "extracts first name (or only name) based on presence and position of space or comma"
  if string-contains(s, ", "):
    # Assume that there is only one comma and whatever
    # appears after the comma is the first name.
    comma-pos = string-index-of(s, ", ")
    string-substring(s, comma-pos + 2, string-length(s))
  else if string-contains(s, " "):
    # Assume that everything before the first
    # space is the first name.
    space-pos = string-index-of(s, " ")
    string-substring(s, 0, space-pos)
  else:
    # Otherwise, use the full string.
    s
  end 
where:
  get-first-name("Zendaya") is "Zendaya"
  get-first-name("Tom Holland") is "Tom"
  get-first-name("Taylor-Joy, Anna") is "Anna"
  get-first-name("Millie Bobby Brown") is "Millie"
  get-first-name("John Alexis Guerra Gomez") is "John"
  # This does not seem right
  get-first-name("Bad Bunny") is "Bad"
end

fun get-last-name(s :: String) -> String:
  doc: "extracts last name from string based on presence and position of space or comma"
  if string-contains(s, ", "):
    # Assume that there is only one comma and whatever
    # appears before the comma is the last name.
    comma-pos = string-index-of(s, ", ")
    string-substring(s, 0, comma-pos)
  else if string-contains(s, " "):
    # Assume that everything after the first
    # space is the last name.
    space-pos = string-index-of(s, " ")
    string-substring(s, space-pos + 1, string-length(s))
  else:
    # Otherwise, assume no last name.
    ""
  end 
where:
  get-last-name("Zendaya") is ""
  get-last-name("Tom Holland") is "Holland"
  get-last-name("Taylor-Joy, Anna") is "Taylor-Joy"
  # This is not right
  get-last-name("Millie Bobby Brown") is "Bobby Brown"
  # This ideally should be "Guerra Gomez"
  get-last-name("John Alexis Guerra Gomez") is "Alexis Guerra Gomez"
  # This is so not right
  get-last-name("Bad Bunny") is "Bunny"
end

employees-with-first-names = build-column(employees, "first-name", lam(r :: Row): get-first-name(r["full-name"]) end)

employees-with-first-and-last-names = build-column(employees-with-first-names, "last-name", lam(r :: Row): get-last-name(r["full-name"]) end)

employees-with-first-and-last-names