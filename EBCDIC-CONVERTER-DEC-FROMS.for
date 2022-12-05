      PROGRAM EBCDIC-CONVERTER
         IMPLICIT NONE
         INCLUDE 'FORMS'
         CHARACTER(LEN=100) :: EBCDIC-DATA
         CHARACTER(LEN=1) :: FIRST-CHAR
         CHARACTER(LEN=99) :: REST-OF-LINE
         INTEGER :: EBCDIC-FILE
         INTEGER :: IOS
         INTEGER :: FORM
         INTEGER :: FIELD
         INTEGER :: KEY
         OPEN(UNIT=EBCDIC-FILE, FILE='DATA.DAT', STATUS='OLD',
              ACCESS='SEQUENTIAL', FORM='FORMATTED', ACTION='READ')
         DEC$FORM_CREATE(FORM, 'EBCDIC-CONVERTER', 25, 80, 0, 0)
         DEC$FIELD_CREATE(FORM, FIELD, 1, 1, 24, 79, 'EBCDIC:',
              DEC$K_BLACK, DEC$K_REVERSE, DEC$K_NO_ATTRIBUTES)
         DEC$FORM_DISPLAY(FORM)
         DO WHILE (IOS .EQ. 0)
            READ(EBCDIC-FILE, '(A)', IOSTAT=IOS) EBCDIC-DATA
            IF (IOS .EQ. 0) THEN
               FIRST-CHAR = EBCDIC-DATA(1:1)
               REST-OF-LINE = EBCDIC-DATA(2:)
               IF (FIRST-CHAR .EQ. '0' .OR. FIRST-CHAR .EQ. '1' .OR. &
                   FIRST-CHAR .EQ. '2' .OR. FIRST-CHAR .EQ. '3' .OR. &
                   FIRST-CHAR .EQ. '4' .OR. FIRST-CHAR .EQ. '5' .OR. &
                   FIRST-CHAR .EQ. '6' .OR. FIRST-CHAR .EQ. '7' .OR. &
                   FIRST-CHAR .EQ. '8' .OR. FIRST-CHAR .EQ. '9') THEN
                  IF (REST-OF-LINE(1:1) .GE. 'A' .AND. REST-OF-LINE(1:1) .LE. 'Z') THEN
                     DEC$FIELD_PUT(FIELD, 'EBCDIC: ', EBCDIC-DATA)
                     DEC$FIELD_PUT(FIELD, 'ASCII: ', REST-OF-LINE)
                     DEC$FIELD_UPDATE(FIELD)
                     DEC$FORM_INQUIRE(FORM, KEY)
                     IF (KEY .EQ. DEC$K_TRM_F3) THEN
                        EXIT
                     END IF
                  END IF
               END IF
            END IF
         END DO
         DEC$FORM_DELETE(FORM)
