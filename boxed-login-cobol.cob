IDENTIFICATION DIVISION.
PROGRAM-ID. LOGIN_FORM.

ENVIRONMENT DIVISION.

DATA DIVISION.

WORKING-STORAGE SECTION.

*Define variables for the username and password.
01 USERNAME PIC X(32).
01 PASSWORD PIC X(32).

*Define a temporary variable for the DECform input values.
01 INPUT-VALUE PIC X(32).

PROCEDURE DIVISION.

MAIN-PROCEDURE.

*Create a DECform with a layout that contains a canvas widget, two text input fields, and two labels.
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

*Draw a box around the text input fields and labels.
  VMS DECFORM-DRAW-LINE 15, 15, 185, 15
  VMS DECFORM-DRAW-LINE 185, 15, 185, 85
  VMS DECFORM-DRAW-LINE 185, 85, 15, 85
  VMS DECFORM-DRAW-LINE 15, 85, 15, 15

*Set the text of the labels and the initial values of the text input fields.
  VMS DECFORM-CALL "Username:", INPUT-VALUE=USERNAME
  VMS DECFORM-CALL "Password:", INPUT-VALUE=PASSWORD

*Read the values entered by the user in the text input fields.
  VMS DECFORM-READ USERNAME
  VMS DECFORM-READ PASSWORD

  GOBACK.

END PROGRAM LOGIN_FORM.
