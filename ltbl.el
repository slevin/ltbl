;;; ltbl.el --- Emacs implementation of Lua tables

;; Copyright (C) 2015 Sean Levin

;; Author: Sean Levin
;; Created: 21 Jan 2015
;; Version: 20150121
;; URL: https://github.com/slevin/ltbl

;;; Code:


;; I could make it arraylike also by having a list pointer if the items are numeric?

;; there is the weak tables as well

;;  __add and __mul, there are __sub (for subtraction), __div (for division), __unm (for negation), and __pow (for exponentiation). We may define also the field __concat, to define a behavior for the concatenation operator.

;; , through the metamethods __eq (equality), __lt (less than), and __le (less or equal). There are no separate metamethods for the other three relational operators, as Lua translates a ~= b to not (a == b), a > b to b < a, and a >= b to b <= a.

;;  __tostring field in the set metatable:
;; __metatable field in the metatable, getmetatable will return the value of this field, whereas setmetatable will raise an error:


;; is it possible to make ltbl-set/get be defined as
;; the function version of the object so I could do quick
;; read/write stuff with less syntax with them?
;; or maybe even an oo method call thing
;; that does (obj: fun param1 param2) pretty sweet
;; maybe also define an iterable version as well?
;; that would do pairs, keys, or values easy to use in dash
;; migrate from alist to hashtable version if it gets too large
;;

(defun ltblp (tbl)
  (equal (car tbl) 'ltbl))

(defun ltbl-new (&rest items)
  (list 'ltbl #s(hash-table data items) nil))

(defun ltbl-set (key value tbl)
  (if value
      (puthash key value (nth 1 tbl))
    (remhash key (nth 1 tbl))))


;; (defun ltbl-set (key value tbl)
;;   ;; if key doesn't exist, check for and call'__newindex function
;;   ;; otherwise if value put it otherwise delete it
;;   (let ((existing (gethash key (nth 1 tbl))))
;;     (if existing
;;         (if value
;;             (puthash key value (nth 1 tbl))
;;           (remhash key (nth 1 tbl)))
;;       (let ((meta (nth 2 tbl)))
;;         (if meta (let ((nidx (ltbl-get '__newindex meta)))
;;                    (funcall nidx tbl key value)))))))

(defun ltbl-rawset (key value tbl)
  (if value
      (puthash key value (nth 1 tbl))
    (remhash key (nth 1 tbl))))

(defun ltbl-get (key tbl)
  (gethash key (nth 1 tbl)))

;; (defun ltbl-get (key tbl)
;;   ;; if something return that
;;   ;; if nil check if __index is a latbl
;;   ;; if so get from that and return
;;   ;; if its a function then call it with table and key as params
;;   (let ((val (gethash key (nth 1 tbl))))
;;     (if val val
;;       (let ((meta (nth 2 tbl)))
;;         (if meta (let ((idx (ltbl-get '__index meta)))
;;                    (if idx
;;                        (if (ltblp idx)
;;                            (ltbl-get key idx)
;;                          (funcall idx tbl key))
;;                      nil))
;;           nil)))))

(defun ltbl-rawget (key tbl)
  (gethash key (nth 1 tbl)))

(defun ltbl-call (key tbl &rest args)
  ;; call a function stored in key in tbl with tbl and args
  (apply (gethash key (nth 1 tbl)) tbl args))


(defun ltbl-setmeta (tbl meta)
  (setcdr tbl (list (cadr tbl) meta)))

(defun ltbl-getmeta (tbl)
  (nth 2 tbl))


;;; ltbl.el ends here
