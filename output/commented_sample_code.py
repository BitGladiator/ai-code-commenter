def fibonacci(n):  # define a function named fibonacci that takes one parameter n
    a, b = 0, 1  # initialize two variables: a holds the "current" Fibonacci number (0), b holds the "next" (1)
    for _ in range(n):  # loop exactly n times; '_' is used because the loop index itself is not needed
        print(a)  # print the current Fibonacci number
        a, b = b, a + b  # update both variables simultaneously:
                        # new a becomes the old b (next number),
                        # new b becomes the sum of the old a and old b (the subsequent number)

def is_prime(num):  # define a function to test whether num is a prime number
    if num <= 1:  # by definition, numbers <= 1 are not prime
        return False  # return False immediately for num <= 1
    for i in range(2, int(num ** 0.5) + 1):  # test potential divisors from 2 up to floor(sqrt(num))
        # using sqrt(num) is sufficient because if num had a divisor > sqrt(num),
        # it would be paired with a divisor < sqrt(num) which we would have already tested
        if num % i == 0:  # if i divides num evenly (remainder zero)
            return False  # num is composite, so return False
    return True  # no divisors found, num is prime (return True)

if __name__ == "__main__":  # this block runs only when the script is executed directly (not when imported)
    fibonacci(10)  # call fibonacci to print the first 10 Fibonacci numbers (starting from 0)
    print(is_prime(29))  # call is_prime on 29 and print the boolean result (expected: True)

Additional notes:
- Running this script prints the 10 Fibonacci numbers: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 (each on its own line), followed by "True".
- Complexity:
  - fibonacci: O(n) time, O(1) extra space (it prints values rather than storing them).
  - is_prime: O(sqrt(num)) time in the worst case.
- Possible improvements:
  - Have fibonacci return a list of values instead of printing, making it more reusable.
  - Add input validation (e.g., ensure n is a non-negative integer).
  - For large primes, use more advanced primality tests (Miller–Rabin) or optimizations (skip even divisors).
  - Add docstrings and type hints for clarity.
