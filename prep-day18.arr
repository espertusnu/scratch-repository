use context dcic2024
include csv
include data-source

data BookRecord:
  | book(title :: String, author :: String, pages :: Number)
end

the-dispossessed = book("The Dispossessed", "Ursula K. Le Guin", 387)
to-the-lighthouse = book("To the Lighthouse", "Virginia Woolf", 209)
brave-new-world = book("Brave New World", "Aldous Huxley", 268)

fun summary-string(b:: BookRecord) -> String:
  doc: "produces a string with summary information about a book"
  b.title + " by " + b.author + " (" + num-to-string(b.pages) + " pages)"
where:
  summary-string(the-dispossessed) is "The Dispossessed by Ursula K. Le Guin (387 pages)"
end

fun is-long-book(b:: BookRecord) -> Boolean:
  b.pages > 350
where:
  is-long-book(the-dispossessed) is true
  is-long-book(brave-new-world) is false
end
  
data Podcast:
  | podcast(title :: String, host :: String, feed :: String)
end

wwdtm = podcast("Wait Wait Don't Tell Me", "Peter Sagel", "https://feeds.npr.org/344098539/podcast.xml")

fun podcast-summary-string(p:: Podcast) -> String:
  doc: "produces a string with summary information about a podcast"
  p.title + " (host: "  + p.host + ") " + p.feed
where:
  podcast-summary-string(wwdtm) is "Wait Wait Don't Tell Me (host: Peter Sagel) https://feeds.npr.org/344098539/podcast.xml"
end

recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-url("https://raw.githubusercontent.com/neu-pdi/cs2000-public-resources/refs/heads/main/static/support/5-recipes.csv", default-options)
  sanitize servings using num-sanitizer
  sanitize prep-time using num-sanitizer
end

data RecipeRecord:
  | recipe(title :: String, servings :: Number, prep-time :: Number)
end

fun row-to-recipe(r :: Row) -> RecipeRecord:
  recipe(r["title"], r["servings"], r["prep-time"])
end

recipe-records-table = build-column(recipes, "record", row-to-recipe)