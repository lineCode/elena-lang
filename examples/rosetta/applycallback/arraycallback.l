/// Apply a callback to an array

import system'routines.

PrintSecondPower =
    (:n) [ console writeLine:(n * n) ].

program =
[
    (1, 2, 3, 4, 5, 6, 7, 8, 9, 10) run each:PrintSecondPower.
].
