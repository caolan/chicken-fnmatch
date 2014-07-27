# chicken-fnmatch 

CHICKEN Scheme bindings for fnmatch(3). Provides glob-like pattern matching for
filenames using shell wildcard patterns.

## Example use

```scheme
(fnmatch "dir/*.scm" "dir/foo.scm") ;; => #t
(fnmatch "dir/*.scm" "dir/foo.txt") ;; => #f
```

## API

### fnmatch

```scheme
(fnmatch path pattern #!key (escape #t) (pathname #t) (period #f))
```

Tests a pathname against a pattern, returning #t for a match or #f for
no match.

#### Keyword arguments:

- __escape:__ when set to #f, treat backslash as an ordinary character, instead
              of an escape character
- __pathname:__ match a slash in string only with a slash in pattern and not by
                an asterisk (*) or a question mark (?) metacharacter, nor by a
                bracket expression ([]) containing a slash
- __period:__ a leading period in string has to be matched exactly by a period
              in pattern. A period is considered to be leading if it is the
              first character in string, or if both 'pathname' is set to #t
              and the period immediately follows a slash
