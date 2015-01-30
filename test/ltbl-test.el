(ert-deftest tests-working ()

    (should (equal 1 1))
    )

(ert-deftest test-ltblp ()
  (let ((l (ltbl-new)))
    (should (equal t (ltblp l)))))

(ert-deftest setget ()
  (let ((l (ltbl-new)))
    (ltbl-set 'key "mykey" l)
    (should (equal "mykey" (ltbl-get 'key l)))))
