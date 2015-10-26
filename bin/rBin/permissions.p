DEFINE SHARED VARIABLE session_UserType AS CHARACTER.

IF session_UserType <> "Administrator" OR session_UserType <> "Super Admin" THEN
DO:    
	DISABLE btnModify btnDelete WITH FRAME {&FRAME-NAME}.
    DISPLAY btnModify btnDelete WITH FRAME {&FRAME-NAME}.
END.
