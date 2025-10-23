use context dcic2024

data PaymentMethod:
  | cash
  | credit(card-number :: String, expiry :: String)
  | checking(bank-account :: String, routing :: String, check-number :: Number)
end

cash-payment = cash
cc-payment = credit("1111 2222 3333 4444", "10/2026")
check1000 = checking("01169422", "892632", 1000)

fun display-payment(p :: PaymentMethod) -> String:
  cases (PaymentMethod) p:
    | cash => "Paid in cash"
    | credit(cn, exp) => "Paid by credit card expiring on " + exp
    | checking(acc, rout, num) => "Paid by check from account " + acc
  end
end