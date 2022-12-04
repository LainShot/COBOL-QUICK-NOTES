      PROGRAM EBCDIC-CONVERTER
         IMPLICIT NONE
         CHARACTER(LEN=100) :: EBCDIC-DATA
         CHARACTER(LEN=1) :: FIRST-CHAR
         CHARACTER(LEN=99) :: REST-OF-LINE
         INTEGER :: EBCDIC-FILE
         INTEGER :: IOS
         OPEN(UNIT=EBCDIC-FILE, FILE='DATA.DAT', STATUS='OLD',
              ACCESS='SEQUENTIAL', FORM='FORMATTED', ACTION='READ')
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
                     PRINT *, 'EBCDIC: ', EBCDIC-DATA
                     PRINT *, 'ASCII: ', REST-OF-LINE
                  END IF
               END IF
            END IF
         END DO
         CLOSE(EBCDIC-FILE)
      END PROGRAM EBCDIC-CONVERTER
