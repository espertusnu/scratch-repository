use context dcic2024

#import math as M
import statistics as S
include math
  
cafe-data =
  table: day :: String, drinks-sold :: Number
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end

sales = cafe-data.get-column("drinks-sold")

