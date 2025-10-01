use context dcic2024

include csv
  
voter-data = 
  load-table: VoterID,FirstName,LastName,DOB,Party,Address,City,State,Zip,Phone,Email,LastVoted 
    source: csv-table-file("voters.csv", default-options)
end

filter-with(voter-data, lam(r): r["Party"] == "Democrat" end)

fun blank-to-indep(s :: String) -> String:
  if s == "":
    "Independent"
  else:
    s
  end
end

voters-with-indep = transform-column(voter-data, "Party", blank-to-indep)