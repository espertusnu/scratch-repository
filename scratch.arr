use context dcic2024

include csv

voter-data = 
  load-table: VoterID,FirstName,LastName,DOB,Party,Address,City,State,Zip,Phone,Email,LastVoted 
    source: csv-table-file("voters.csv", default-options)
end

republicans = filter-with(voter-data, lam(r :: Row) -> Boolean: r["Party"] == "Republican" end)


fun blank-to-indep(s :: String) -> String:
  doc: "replaces an empty string with Independent"
  if s == "":
    "Independent"
  else:
    s
  end
where:
  blank-to-indep("") is "Independent"
  blank-to-indep("blah") is "blah"
end
voters-with-indep = transform-column(voter-data, "Party", blank-to-indep)

fun remove-char(s :: String, char :: String) -> String:
  doc: "remove a character wherever it appears in a string"
  string-replace(s, char, "")
where:
  remove-char("abcba", "a") is "bcb"
  remove-char("abc", "d") is "abc"
  remove-char("", "x") is ""
end

fun normalize-phone(s :: String) -> String:
  doc: "remove parentheses, dashes, spaces, and periods"
  s1 = remove-char(s, "(")
  s2 = remove-char(s1, ")")
  s3 = remove-char(s2, "-")
  s4 = remove-char(s3, " ")
  s5 = remove-char(s4, ".")
  s5
where:
  normalize-phone("(555) 123-4567") is "5551234567"
  normalize-phone("555.987.6543") is "5559876543"
end
  
voter-data-with-normalized-phones = transform-column(voter-data, "Phone", normalize-phone)

fun normalize-date(s :: String) -> String:
  doc: "convert date strings to YYYY-MM-DD format, assuming MM precedes DD in the input"
  if string-contains(s, "-"):
    # If it contained a -, return it unchanged
    s
  else if string-index-of(s, "/") == 4:
    # Convert YYYY/MM/DD to YYYY-MM-DD
    string-replace(s, "/", "-")
  else if string-index-of(s, "/") == 2:
    # Convert MM/DD/YYYY to YYYY-MM-DD
    month = string-substring(s, 0, 2)
    day = string-substring(s, 3, 5)
    year = string-substring(s, 6, 10)
    year + "-" + month + "-" + day
  else:
    # Unrecognized format
    "????"
  end
where:
  normalize-date("1980-05-12") is "1980-05-12"
  normalize-date("05/12/1975") is "1975-05-12"
  normalize-date("1978/07/08") is "1978-07-08"
end

voter-data-with-normalized-dobs = transform-column(voter-data, "DOB", normalize-date)

fun is-digit(char :: String) -> Boolean:
  doc: "Tests whether the input is a digit"
  (char >= "0") and (char <= "9")
where:
  is-digit("!") is false
  is-digit("0") is true
  is-digit("5") is true
  is-digit("9") is true
  is-digit("A") is false
end

fun get-year(s :: String) -> String:
  doc: "gets the year from a date string, assuming a 4-digit year is either at the start or the end of s"
  if (is-digit(string-char-at(s, 0))) and
    (is-digit(string-char-at(s, 1))) and
    (is-digit(string-char-at(s, 2))) and
    (is-digit(string-char-at(s, 3))):
    string-substring(s, 0, 4)
  else:
    string-substring(s, string-length(s) - 4, string-length(s))
  end
where:
  get-year("11/04/2024") is "2024"
  get-year("2023/05/15") is "2023"
  get-year("Oct 10 2022") is "2022"
end

oter-data-with-normalized-last-voted = transform-column(voter-data, "LastVoted", get-year)

fun normalize-voter-data(table :: Table) -> Table:
  doc: "normalizes Phone, DOB, and LastVoted"
  t1 = transform-column(table, "Phone", normalize-phone)
  t2 = transform-column(t1, "DOB", normalize-date)
  t3 = transform-column(t2, "LastVoted", get-year)
  t3
end

normalize-voter-data(voter-data)
  