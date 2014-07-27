(use fnmatch test)

(test-group "basic use"
  (test "defaults - pass" #t
        (fnmatch "?/some/pattern/*.scm" "./some/pattern/test.scm"))
  (test "defaults - fail1" #f
        (fnmatch "/some/pattern/*.scm" "/some/test.scm"))
  (test "defaults - fail2" #f
        (fnmatch "/some/pattern/*.scm" "/some/pattern/asdf")))

(test-group "flags"
  (test "no escape - pass" #t
        (fnmatch "/foo\\bar/\\*.txt" "/foo\\bar/\\123.txt" escape: #f))
  (test "no escape - fail" #f
        (fnmatch "/foo/\\*.txt" "/foo/*.txt" escape: #f))
  (test "no pathname - pass" #t
        (fnmatch "/foo/*.bar" "/foo/asdf/baz.bar" pathname: #f))
  (test "no pathname - fail" #f
        (fnmatch "/foo/*.bar" "/foo.bar" pathname: #f))
  (test "period, no pathname - pass" #t
        (fnmatch "./foo/?bar/baz.qux" "./foo/.bar/baz.qux"
                 period: #t pathname: #f))
  (test "period, no pathname - fail" #f
        (fnmatch "?/foo.bar" "./foo.bar" period: #t pathname: #f))
  (test "period and pathname - pass" #t
        (fnmatch "./foo/.bar/baz.qux" "./foo/.bar/baz.qux"
                 period: #t pathname: #t))
  (test "period and pathname - fail " #f
        (fnmatch "./foo/?bar/baz.qux" "./foo/.bar/baz.qux"
                 period: #t pathname: #t))
  )

(test-exit)
