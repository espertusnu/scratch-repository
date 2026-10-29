use context dcic2024

orange-triangle = triangle(35, "solid", "orange")
orange-triangle

# Square 1
side-length = 20
color = "blue"
square(side-length, "solid", color)

# Square 2
square(20, "solid", "blue")

# Shadowing
#side-length = 7

# Yellow circle on black rectangle
yellow-circle = circle(30, "solid", "yellow")
black-rectangle = rectangle(60, 80, "solid", "black")
above(yellow-circle, black-rectangle)
overlay(yellow-circle, black-rectangle)
