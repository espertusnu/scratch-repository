use context dcic2024

data Vehicle:
  | bike
  | car(make :: String, year :: Number)
  | truck(make :: String, year :: Number, capacity :: Number)
end

my-bike = bike
my-car = car("Nissan", 2022)
some-truck = truck("Ford", 2016, 10000)

fun vehicle-age(vehicle :: Vehicle, cur-year :: Number) -> Number:
  doc: "returns the age of a vehicle (or 0 for a bike)"
  cases (Vehicle) vehicle:
    | bike => 0
    | car(make, year) => cur-year - year
    | truck(make, year, capacity) => cur-year - year
  end
where:
  vehicle-age(my-bike, 2025) is 0
  vehicle-age(my-car, 2025) is 3
  vehicle-age(some-truck, 2030) is 14
end

data Grade:
  | letter(character :: String)
  | percent(number :: Number)
  | pass-fail(boolean :: Boolean)
end

grade-a = letter("A")
percent92 = percent(92)
pass = pass-fail(true)

fun grade-to-gpa(grade :: Grade) -> Number:
  doc: "returns the GPA for a given grade"
  cases (Grade) grade:
    | letter(c) =>
      if c == "A":
        4.0
      else if c == "B":
        3.0
      else if c == "C":
        2.0
      else if c == "D":
        1.0
      else:
        0
      end
    | percent(n) =>
      if n >= 90:
        4.0
      else if n >= 80:
        3.0
      else if n >= 70:
        2.0
      else if n >= 60:
        1.0
      else:
        0
      end
    | pass-fail(b) =>
      if b:
        4.0
      else:
        0
      end
  end
where:
  grade-to-gpa(letter("B")) is 3.0
  grade-to-gpa(percent(90)) is 4.0
  grade-to-gpa(pass-fail(false)) is 0
end

data PaymentMethod:
  | cash
  | credit(card-number :: String, expiry :: String)
  | checking(bank-account :: String, routing :: String, check-number :: Number)
end

payment-1 = cash
payment-2 = credit("1111-2222-3333-4444", "09/26")
payment-3 = checking("987654321", "111", 55)

fun payment-summary(payment :: PaymentMethod) -> String:
  doc: "produce a textual payment summary"
  cases (PaymentMethod) payment:
    | cash => "Cash payment"
    | credit(n, e) => "Card ending in " + string-substring(n, string-length(n) - 4, string-length(n))
    | checking(ba, r, n) => "Check #" + num-to-string(n)
  end
where:
  payment-summary(payment-1) is "Cash payment"
  payment-summary(payment-2) is "Card ending in 4444"
  payment-summary(payment-3) is "Check #55"
end

data WeatherReport:
  | sunny(temp :: Number)
  | rainy(temp :: Number, precip :: Number)
  | snowy(temp :: Number, precip :: Number, wind-speed :: Number)
end

sunny-day = sunny(80)
rainy-day = rainy(65, 0.2)
snowy-day = snowy(20, 2.0, 40.0)

fun is-severe(weather :: WeatherReport) -> Boolean:
  doc: "determines if weather is severe"
  cases (WeatherReport) weather:
    | sunny(t) => t > 95.0
    | rainy(t, p) => p > 2.0
    | snowy(t, p,w ) => w > 30.0
  end
where:
  is-severe(sunny-day) is false
  is-severe(rainy-day) is false
  is-severe(snowy-day) is true
end