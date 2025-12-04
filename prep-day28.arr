use context dcic2024
data LibraryBook:
  library-book(id :: Number, title :: String, ref copies :: Number)
end
book1 = library-book(101, "Born a Crime", 5)
book2 = library-book(101, "Born a Crime", 5)

book1 == book2