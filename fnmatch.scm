(module fnmatch (fnmatch)

(import scheme chicken foreign)
(use lolevel)

(foreign-declare "#include <fnmatch.h>")
(define c-fnmatch (foreign-lambda integer "fnmatch" c-string c-string integer))

(define NOESCAPE    (foreign-value "FNM_NOESCAPE" integer))
(define PATHNAME    (foreign-value "FNM_PATHNAME" integer))
(define PERIOD      (foreign-value "FNM_PERIOD" integer))
(define NOMATCH     (foreign-value "FNM_NOMATCH" integer))

(define (flags escape pathname period)
  (bitwise-ior (if (not escape) NOESCAPE 0)
               (if pathname PATHNAME 0)
               (if period PERIOD 0)))


;; Tests a pathname against a pattern, returning #t for a match or #f for
;; no match.
;;
;; Keyword arguments:
;;
;; - escape: when set to #f, treat backslash as an ordinary character, instead
;;           of an escape character
;; - pathname: match a slash in string only with a slash in pattern and not by
;;             an asterisk (*) or a question mark (?) metacharacter, nor by a
;;             bracket expression ([]) containing a slash
;; - period:  a leading period in string has to be matched exactly by a period
;;            in pattern. A period is considered to be leading if it is the
;;            first character in string, or if both 'pathname' is set to #t
;;            and the period immediately follows a slash

(define (fnmatch pattern path #!key (escape #t) (pathname #t) (period #f))
  (let ([result (c-fnmatch pattern path (flags escape pathname period))])
    (cond
      ((= 0 result) #t)
      ((= NOMATCH result) #f)
      (else (abort "fnmatch(3) returned an error"))))))
