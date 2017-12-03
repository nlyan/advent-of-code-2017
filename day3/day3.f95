! 37 36 35 34 33 32 31
! 38 17 16 15 14 13 30
! 39 18  5  4  3 12 29
! 40 19  6  1  2 11 28
! 41 20  7  8  9 10 27
! 42 21 22 23 24 25 26
! 43 44 45 46 47 48 49
!          ^ min    ^ max

! Observation 1:  The numbers spiral anti-clockwise, meaning the largest value in
!                 a spiral arm is always the bottom-right value in that arm.

! Observation 2:  The length of the side of each spiral arm with 0-index n is l = 2n+1

! Observation 2b: The number of numbers in a spiral arm is 4*l - 4 (because there
!                 are 4 sides and each corner is counted twice, i.e. is shared between 
!                 2 sides)

! Observation 2c: The number of numbers in a spiral arm is therefore 
!                      4*(2n+1) - 4 = 8n+4 - 4 = 8n

! Observation 2d: The total number of numbers *within* a spiral arm n is
!                 therefore the sum of 8x for x = 0 through n
!                      = 4*n*(n+1)

! Observation 2e: ...and +1 for the center value '1'
!                      = 4*n*(n+1) + 1

! Observation  3: This value grows quadratically with the size of the grid, meaning 
!                 e.g. for a value of 1 billion, n is only ~15,812

! Observation  4: The minimum Manhattan Distance for all numbers in spiral n, is n...

! Observation  4a: The minimum Manhattan distance occurs at
!                      = 4*n*(n+1) + 1 - n

! Observation  5: The maximum Manhattan Distance for all numbers in spiral n, is 2n

PROGRAM Spiral
  INTEGER n
  WRITE (*,"(A)",advance="no") "Enter a positive integer: "
  READ *, n
  PRINT *,mandist (n)
END PROGRAM Spiral

INTEGER FUNCTION mandist (x)
  INTEGER x, y
  n = 0
  y = 1
  DO WHILE (y < x)
    n = n + 1
    y = (4 * n * n) + 3*n + 1
  ENDDO
  n2 = y - x
  DO WHILE (n2 >= 2*n)
    n2 = n2 - 2*n
  ENDDO
  n2 = MIN (n2,2*n - n2)
  mandist = n + n2
  RETURN
END
