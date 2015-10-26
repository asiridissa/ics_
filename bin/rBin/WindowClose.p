
/* definition */
DEFINE SHARED VARIABLE session_Window AS INT.
/* main block */
session_Window = session_Window + 1.
/* CLOSE */
MESSAGE "Confrm to close the window?" VIEW-AS ALERT-BOX INFO BUTTONS YES-NO UPDATE yn AS LOGICAL.
  IF yn = YES THEN
    DO:
      session_Window = session_Window - 1.
      APPLY "CLOSE":U TO THIS-PROCEDURE.
      RETURN NO-APPLY.
    END.
  ELSE
    RETURN NO-APPLY.
