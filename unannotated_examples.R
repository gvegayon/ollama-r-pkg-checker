# Adds two numbers. Returns the last expression without explicit return().
add_two <- function(x, y) {
  x + y
}

# Prints a message n times, then returns the first argument invisibly (side-effect primary).
print_message <- function(text, times = 1) {
  for (i in seq_len(times)) {
    cat(text, "\n")
  }
  invisible(text)
}

# Multi-line definition using the single-indent style for arguments.
scale_and_shift <- function(
  x,
  scale = 1,
  shift = 0
) {
  (x * scale) + shift
}

row_adder <- function(a, b) {
  return(a + b)
}

cv <- \(x) sd(x) / mean(x)
