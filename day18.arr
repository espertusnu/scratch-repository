use context dcic2024

data BookRecord:
  | book(title :: String, author :: String, pages :: Number)
end

cap = book("Crime and Punishment", "Fyodor Dosteyevsky", 300)

f451 = book("Fahrenheit 451", "Ray Bradbury", 150)