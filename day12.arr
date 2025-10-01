use context dcic2024

weather-data =
  table: date, temperature, precipitation
    row: "2025-01-01", 62, 0.1
    row: "2025-01-02", "45", 3
    row: "2025-01-03", 28, 0.2
    row: "2025-01-04", 55, -1
    row: "2025-01-05", 90, 0
  end

# Normalize the data.
# v temperature is sometimes string, sometimes number
# v create function to normalize temperature
# v transform the temperature column with a function
# - precipitation should be >= 0 but is sometimes negative
# v create function to put temperature into bucket
#   cold: < 40
#   mild: 40-60
#   hot: > 60
# - add column "temp-category" on row values and function we created
# - display data 

fun normalize-temp(v) -> Number:
  doc: "given a number or string, convert to a number (0 if it can't be converted"
  # If it's already a number, return that
  if is-number(v):
    v
  else if is-string(v):
    # If it's a string, convert it or return 0
    string-to-number(v).or-else(0)
  else: # not a number or string
    0
  end
where:
  normalize-temp(10) is 10
  normalize-temp("13") is 13
  normalize-temp("hey") is 0
  normalize-temp(true) is 0
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

fun bucket-temp-for-row(r :: Row) -> String:
  bucket-temp(r["temperature"])
end

with-buckets = build-column(fixed-data, "temp-category", lam(r :: Row): bucket-temp(r["temperature"]) end)
