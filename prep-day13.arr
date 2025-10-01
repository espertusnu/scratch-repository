use context dcic2024

import math as M
import statistics as S

include csv

## EXERCISE 1

cafe-data =
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end

days = cafe-data.get-column("day")
"The first day alphabetically is " + M.min(days)

drinks-sold = cafe-data.get-column("drinks-sold")
"The total number of drinks sold is " + num-to-string(M.sum(drinks-sold))

## EXERCISE 2

quiz-scores =
  table: student, quiz1, quiz2, quiz3
    row: "Alice", 85, 92, 78
    row: "Bob", 90, 88, 95
    row: "Charlie", 78, 85, 82
    row: "Diana", 95, 90, 88
  end

quiz1 = quiz-scores.get-column("quiz1")
quiz1-mean = S.mean(quiz1)
"quiz1 mean: " + num-to-string(quiz1-mean)

# Hey, I could write a function to do the above steps.
fun show-column-mean(table :: Table, col-name :: String) -> String:
  doc: "shows the mean of the specified numeric column"
  scores = table.get-column(col-name)
  average = S.mean(scores)
  # If I use num-to-string instead of num-to-string-digits,
  # the result might be displayed as a fraction
  col-name + " mean: " + num-to-string-digits(average, 2)
where:
  show-column-mean(quiz-scores, "quiz1") is "quiz1 mean: 87.00"
end

show-column-mean(quiz-scores, "quiz1")
show-column-mean(quiz-scores, "quiz2")
show-column-mean(quiz-scores, "quiz3")

## EXERCISE 3

nums = [list: 12, 8, 15, 22, 5, 18]
minimum = M.min(nums)
maximum = M.max(nums)
total = M.sum(nums)
"Minimum is " + num-to-string(minimum)
"Maximum is " + num-to-string(maximum)
"Range is " + num-to-string(maximum - minimum)
"Total is " + num-to-string(total)

## EXERCISE 4

employees = load-table:
  name :: String,  department-name :: String, title :: String, regular :: String,
  retro :: String, other :: String, overtime :: String, injured :: String,
  detail :: String, quinn-education :: String, total-gross :: String, postal :: String
  source: csv-table-url("https://data.boston.gov/dataset/418983dc-7cae-42bb-88e4-d56f5adcf869/resource/579a4be3-9ca7-4183-bc95-7d67ee715b6d/download/employee_earnings_report_2024.csv", default-options)
end

# From Day 9
fun string-to-number-unsafe(s :: String) -> Number:
  doc: "Converts the given string to a number, returning 0 if not well formatted"
  string-to-number(string-replace(s, ",", "")).or-else(0)
where:
  string-to-number-unsafe("1234") is 1234
  string-to-number-unsafe("-1.3") is -1.3
  string-to-number-unsafe("hello") is 0
end

employees-with-numeric-regular = transform-column(employees, "regular", string-to-number-unsafe)

# Hey, I can use the earlier function from exercise 2.
show-column-mean(employees-with-numeric-regular, "regular")