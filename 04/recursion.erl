-module(recursion).

-export([tail_fac/1, duplicate/1, tail_duplicate/1]).

tail_fac(N) -> tail_fac(N, 1).
tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N-1, N * Acc).

duplicate([]) -> [];
duplicate([H | T]) -> [H, H | duplicate(T)].

tail_duplicate(List) -> tail_duplicate(List, []).
tail_duplicate([], Acc) -> lists:reverse(Acc);
tail_duplicate([H | T], Acc) -> tail_duplicate(T, [H, H | Acc]).