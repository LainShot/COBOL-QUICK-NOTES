PROGRAM LOGIN_FORM

IMPLICIT NONE

! Define variables for the username and password.
CHARACTER(LEN=32) :: USERNAME, PASSWORD

! Create a DECform with a canvas widget, two text input fields, and two labels.
VMS DECFORM-CALL "Login"

BEGIN FORMS
  LAYOUT GRID
    ROWS 3
    COLS 2

    CANVAS
    TEXT-INPUT USERNAME
    TEXT-INPUT PASSWORD
    LABEL "Username:"
    LABEL "Password:"
END

! Draw a box around the text input fields and labels.
CALL DRAW_BOX(15, 15, 185, 85)

! Set the text of the labels and the initial values of the text input fields.
VMS DECFORM-CALL "Username:", USERNAME="John"
VMS DECFORM-CALL "Password:", PASSWORD="********"

! Read the values entered by the user in the text input fields.
VMS DECFORM-READ USERNAME
VMS DECFORM-READ PASSWORD

END PROGRAM LOGIN_FORM

SUBROUTINE DRAW_BOX(X1, Y1, X2, Y2)

  ! Draw the lines that make up the box.
  VMS DECFORM-DRAW-LINE X1, Y1, X2, Y1
  VMS DECFORM-DRAW-LINE X2, Y1, X2, Y2
  VMS DECFORM-DRAW-LINE X2, Y2, X1, Y2
  VMS DECFORM-DRAW-LINE X1, Y2, X1, Y1

END SUBROUTINE DRAW_BOX
