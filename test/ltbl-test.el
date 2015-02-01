(ert-deftest tests-working ()
  (should (equal 1 1)))

(ert-deftest test-ltblp ()
  (let ((l (ltbl-new)))
    (should (equal t (ltblp l)))))

(ert-deftest test-setget ()
  (let ((l (ltbl-new)))
    (ltbl-set 'key "mykey" l)
    (should (equal "mykey" (ltbl-get 'key l)))))

;; test with constructor args


;; hash constructor takes unquoted symbols
;; think about a solution
;; maybe should match or maybe not
;; so I could take that rest and iterate over pairs
;; and run set hash on each
(ert-deftest test-constructor ()
  (let ((l (ltbl-new 'key1 "k1" 'key2 "k2")))
    (should (equal "k1" (ltbl-get 'key1 l)))
    (should (equal "k2" (ltbl-get 'key2 l)))))

(ert-deftest test-remove ()
  "set with nil removes"
  (let ((l (ltbl-new)))
    (ltbl-set 'key "mykey" l)
    (ltbl-set 'key nil l)
    (should (null (ltbl-get 'key l)))))



;; test raws -- even with metatables
;; meta must be an ltbl
