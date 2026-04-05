# Writing

- keep prose terse

# Code style

- preserve existing code comments unless they are wrong or the user asks to change them
- keep diffs minimal and preserve existing naming and formatting unless the change requires otherwise
- prefer the Principle of Least Surprise over cleverness when choosing value shapes, ids, naming, and control flow
- prefer simplicity and transparent program flow over abstraction and indirection
- prefer inline values over single-use variables unless a local is needed for narrowing or clarity
- avoid speculative fallbacks, defensive guards, and dead code paths for cases not present in the current data

# PR descriptions

- start with problem, then solution
- do not use `## Summary`
- do not add empty or near-empty `## Testing` sections
- after the prose, add checked checkboxes for completed changes
- checkbox items must describe positive completed changes only
- do not add checkbox items for things kept unchanged or not done
