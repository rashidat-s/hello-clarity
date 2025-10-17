;; --------------------------------------------------
;; HELLO-CLARITY (Full Version)
;; Author: Your Name
;; Network: Stacks
;; Tool: Clarinet + Clarity
;;
;; Description:
;; A simple and complete example contract demonstrating:
;;  - Writing and reading greetings
;;  - Tracking total number of greetings
;;  - Letting users send custom greetings
;;  - Admin-only reset functionality
;;  - Event logging with print
;; --------------------------------------------------

;; -------------------------------
;; Data storage
;; -------------------------------

;; Store total number of greetings
(define-data-var total-greetings uint u0)

;; Store a map of users to their last greeting message
(define-map greetings
  { user: principal }
  { message: (string-ascii 100) })

;; Store the contract admin (the deployer)
(define-data-var admin principal tx-sender)


;; -------------------------------
;; Error Codes
;; -------------------------------
(define-constant ERR-NOT-ADMIN (err u100))
(define-constant ERR-EMPTY-MESSAGE (err u101))


;; -------------------------------
;; Private Helper Functions
;; -------------------------------

;; Require the caller to be the admin
(define-private (require-admin (caller principal))
  (if (is-eq caller (var-get admin))
      (ok true)
      ERR-NOT-ADMIN))

;; -------------------------------
;; Public Functions
;; -------------------------------

;; Say Hello (generic)
(define-public (say-hello)
  (begin
    (var-set total-greetings (+ (var-get total-greetings) u1))
    (print { event: "say-hello", sender: tx-sender })
    ;; Removed invalid to-utf8 function and simplified return
    (ok "Hello!")
  )
)

;; Send a custom message
(define-public (send-greeting (message (string-ascii 100)))
  (begin
    (asserts! (> (len message) u0) ERR-EMPTY-MESSAGE)
    (map-set greetings { user: tx-sender } { message: message })
    (var-set total-greetings (+ (var-get total-greetings) u1))
    (print { event: "custom-greeting", sender: tx-sender, msg: message })
    (ok { from: tx-sender, message: message })
  )
)

;; Admin-only: reset all stats
(define-public (reset-greetings)
  (begin
    (try! (require-admin tx-sender))
    (var-set total-greetings u0)
    (print { event: "reset", by: tx-sender })
    (ok true)
  )
)

;; Admin-only: transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (try! (require-admin tx-sender))
    (var-set admin new-admin)
    (print { event: "admin-transferred", from: tx-sender, to: new-admin })
    (ok { old: tx-sender, new: new-admin })
  )
)


;; -------------------------------
;; Read-Only Functions
;; -------------------------------

;; Get total number of greetings sent
(define-read-only (get-total-greetings)
  (ok (var-get total-greetings)))

;; Get the message of a user
(define-read-only (get-greeting (user principal))
  (match (map-get? greetings { user: user })
    entry (ok (get message entry))
    (ok "No greeting found")))

;; Get the contract admin
(define-read-only (get-admin)
  (ok (var-get admin)))
