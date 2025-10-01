use context dcic2024


prices = table: price
      row: 50
      row: 120
      row: 80
      row: 40
      row: 50
      row: 80
      row: 80
    end


prices-with-tax = build-column(prices, "tax",
  lam(r): r["price"] * 0.105 end)

computer-items = table: item :: String, price :: Number
  row: "mouse", 20
  row: "keyboard", 60
end

fun obfuscate-table(items :: Table) -> Table:
  transform-column(items, "item",
    lam(s): string-repeat("X", string-length(s)) end)
end

obfuscate-table(computer-items)