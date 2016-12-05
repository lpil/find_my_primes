# FindMyPrimes

## Usage

Start the REPL with the application running.

```
$ iex -S mix
```

Interact with the application using `FindMyPrimes.table/1` and `FindMyPrimes.async_table/1`.


### `FindMyPrimes.table/1`

```elixir
iex> 3 |> FindMyPrimes.table |> IO.write
# |    |  2 |  3 |  5 |
# |  2 |  4 |  6 | 10 |
# |  3 |  6 |  9 | 15 |
# |  5 | 10 | 15 | 25 |
:ok
```

Generates the prime multiplication table for the given number. The client blocks
until it recieves the result.

The client is blocked but the server uses worker processes to do the number
crunching so it can continue to respond to requests.


### `FindMyPrimes.async_table/1`

```elixir
iex> {:ok, ref} = 3 |> FindMyPrimes.async_table
iex> receive do {:prime_table, ^ref, x} -> IO.write(x) end
# |    |  2 |  3 |  5 |
# |  2 |  4 |  6 | 10 |
# |  3 |  6 |  9 | 15 |
# |  5 | 10 | 15 | 25 |
:ok
```

Generates the prime multiplication table for the given number. The client
recieves the result as a regular message.

The table is sent back with a reference that can be matched against the return
value of the function to pair calls with responses.


## Next Steps

- `O(n)` prime generation.
- More tests for Manager and Worker modules.
- Prime memoisation could be fun.
- Accept requests over TCP? :)
