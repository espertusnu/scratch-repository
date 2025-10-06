use context dcic2024

include csv

import lists as L

## Exercise 1

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

unique-codes = L.distinct(discount-codes
  

unique-codes-uc = L.map(string-to-upper, discount-codes)

unique-codes-uc

# Run distinct again to remove duplicate "NONE",
# which appeared as "none" and "NONE" in original list.
"The number of distinct discount codes is " + num-to-string(L.length(L.distinct(unique-codes-uc)))

## Exercise 2

responses = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]

responses-lc = L.map(string-to-lower, responses)
unique-responses-lc = L.distinct(responses-lc)

fun is-definitive(s :: String) -> Boolean:
  doc: "Returns true if response is not 'maybe' (case insensitive)"
  string-to-lower(s) <> "maybe"
where:
  is-definitive("maybe") is false
  is-definitive("MAyBe") is false
  is-definitive("yah") is true
end

definitive-responses = L.filter(is-definitive, unique-responses-lc)

definitive-responses2 = L.filter(
  lam(s :: String) -> Boolean: string-to-lower(s) <> "maybe" end,
  unique-responses-lc)

## Exercise 3

products =
  table: name, price
    row: "laptop", 999.99
    row: "mouse", 25.50
    row: "keyboard", 75.00
    row: "monitor", 299.99
  end

prices = products.get-column("price")

inexpensive-prices = L.filter(
  lam(price :: Number) -> Boolean: price < 100 end,
  prices)

bargains = L.map(
  lam(price :: Number) -> Number: price * 0.9 end,
  inexpensive-prices)

## Exercise 4

fruits = [list: "apple", "banana", "cherry", "date", "elderberry"]

fruits.get(2)

fruits-with-long-names = L.filter(
  lam(name :: String) -> Boolean: string-length(name) > 5 end,
  fruits)

## Exercise 5

employees = load-table:
  name :: String,  department-name :: String, title :: String, regular :: String,
  retro :: String, other :: String, overtime :: String, injured :: String,
  detail :: String, quinn-education :: String, total-gross :: String, postal :: String
  source: csv-table-url("https://data.boston.gov/dataset/418983dc-7cae-42bb-88e4-d56f5adcf869/resource/579a4be3-9ca7-4183-bc95-7d67ee715b6d/download/employee_earnings_report_2024.csv", default-options)
end

names = employees.get-column("name")

smith-names = L.filter(
  lam(s :: String) -> Boolean: string-contains(string-to-lower(s), "smith") end,
  names)

## Exercise 6

student-names = [list: "alice", "Bob", "CHARLIE", "diana"]

fun capitalize(s :: String) -> String:
  doc: "capitalize the first letter of the string and make the rest of the letters lowercase"
  first-char = string-substring(s, 0, 1)
  rest = string-substring(s, 1, string-length(s))
  string-to-upper(first-char) + string-to-lower(rest)
where:
  capitalize("becky") is "Becky"
  capitalize("DUMBO") is "Dumbo"
end

normalized-names = L.map(capitalize, student-names)
normalized-names