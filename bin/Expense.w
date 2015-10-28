&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          ics              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

DEFINE SHARED VARIABLE session_Window AS INT.
/* Local Variable Definitions ---                                       */

DEFINE VARIABLE calendr AS COM-HANDLE   NO-UNDO.

DEFINE VARIABLE addModify AS CHARACTER   NO-UNDO.
DEFINE VARIABLE ModifyVal AS CHARACTER   NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME arbrw

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Expense ExpenseType emp

/* Definitions for BROWSE arbrw                                         */
&Scoped-define FIELDS-IN-QUERY-arbrw Expense.Id ExpenseType.Code ~
Expense.Date Expense.Amount Expense.Note 
&Scoped-define ENABLED-FIELDS-IN-QUERY-arbrw 
&Scoped-define QUERY-STRING-arbrw FOR EACH Expense NO-LOCK, ~
      EACH ExpenseType WHERE Expense.ExpenseTypeId = ExpenseType.Id NO-LOCK, ~
      EACH emp WHERE Expense.Employee# = emp.emp# NO-LOCK ~
    BY Expense.Id DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-arbrw OPEN QUERY arbrw FOR EACH Expense NO-LOCK, ~
      EACH ExpenseType WHERE Expense.ExpenseTypeId = ExpenseType.Id NO-LOCK, ~
      EACH emp WHERE Expense.Employee# = emp.emp# NO-LOCK ~
    BY Expense.Id DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-arbrw Expense ExpenseType emp
&Scoped-define FIRST-TABLE-IN-QUERY-arbrw Expense
&Scoped-define SECOND-TABLE-IN-QUERY-arbrw ExpenseType
&Scoped-define THIRD-TABLE-IN-QUERY-arbrw emp


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-arbrw}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS arbrw btnAdd btnModify btnDelete 
&Scoped-Define DISPLAYED-OBJECTS filID fillAmount cmbUserCat fillNote ~
cmbExpenseType 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnAdd 
     LABEL "Add" 
     SIZE 14 BY 1.

DEFINE BUTTON btnCancel 
     LABEL "Cancel" 
     SIZE 14 BY 1.

DEFINE BUTTON btnDelete 
     LABEL "Delete" 
     SIZE 14 BY 1.

DEFINE BUTTON btnModify 
     LABEL "Modify" 
     SIZE 14 BY 1.

DEFINE BUTTON btnSave 
     LABEL "Save" 
     SIZE 14 BY 1.

DEFINE VARIABLE cmbExpenseType AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Expense Type" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "--Select Here--",         0
     DROP-DOWN-LIST
     SIZE 35 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE cmbUserCat AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "User" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "--Select Here--",         0
     DROP-DOWN-LIST
     SIZE 35 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filID AS INTEGER FORMAT ">>>>>9":U INITIAL 0 
     LABEL "ID" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE fillAmount AS DECIMAL FORMAT ">>>,>>9.99":U INITIAL 0 
     LABEL "Amount" 
     VIEW-AS FILL-IN 
     SIZE 24 BY .88
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fillNote AS CHARACTER FORMAT "X(200)":U 
     LABEL "Note" 
     VIEW-AS FILL-IN 
     SIZE 38 BY 2.15
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY arbrw FOR 
      Expense, 
      ExpenseType, 
      emp SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE arbrw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS arbrw C-Win _STRUCTURED
  QUERY arbrw NO-LOCK DISPLAY
      Expense.Id FORMAT ">>>>9":U
      ExpenseType.Code FORMAT "x(8)":U WIDTH 12
      Expense.Date FORMAT "99/99/9999":U WIDTH 12
      Expense.Amount FORMAT ">>>,>>>9.99":U WIDTH 20
      Expense.Note FORMAT "x(200)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 101.57 BY 16.96
         BGCOLOR 15 FGCOLOR 4 FONT 10 ROW-HEIGHT-CHARS .65 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     arbrw AT ROW 1.08 COL 1.29 WIDGET-ID 200
     filID AT ROW 18.5 COL 12.72 COLON-ALIGNED WIDGET-ID 16
     fillAmount AT ROW 18.5 COL 58 COLON-ALIGNED WIDGET-ID 236
     cmbUserCat AT ROW 19.69 COL 12.57 COLON-ALIGNED WIDGET-ID 44
     fillNote AT ROW 19.85 COL 58 COLON-ALIGNED WIDGET-ID 240
     cmbExpenseType AT ROW 20.88 COL 12.43 COLON-ALIGNED WIDGET-ID 238
     btnAdd AT ROW 22.54 COL 2.86 WIDGET-ID 6
     btnModify AT ROW 22.54 COL 17.14 WIDGET-ID 8
     btnDelete AT ROW 22.54 COL 31.57 WIDGET-ID 10
     btnSave AT ROW 22.54 COL 71.29 WIDGET-ID 12
     btnCancel AT ROW 22.54 COL 85.57 WIDGET-ID 14
     "Date" VIEW-AS TEXT
          SIZE 4 BY .58 AT ROW 18.62 COL 21.86 WIDGET-ID 242
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 102.14 BY 23.15
         FONT 10 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "ICS - Users"
         COLUMN             = 39.43
         ROW                = 2.65
         HEIGHT             = 23.15
         WIDTH              = 102.14
         MAX-HEIGHT         = 27.15
         MAX-WIDTH          = 195.14
         VIRTUAL-HEIGHT     = 27.15
         VIRTUAL-WIDTH      = 195.14
         MAX-BUTTON         = no
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* BROWSE-TAB arbrw TEXT-6 DEFAULT-FRAME */
ASSIGN 
       arbrw:ALLOW-COLUMN-SEARCHING IN FRAME DEFAULT-FRAME = TRUE.

/* SETTINGS FOR BUTTON btnCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnSave IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbExpenseType IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       cmbExpenseType:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

/* SETTINGS FOR COMBO-BOX cmbUserCat IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       cmbUserCat:HIDDEN IN FRAME DEFAULT-FRAME           = TRUE.

/* SETTINGS FOR FILL-IN filID IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fillAmount IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fillNote IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE arbrw
/* Query rebuild information for BROWSE arbrw
     _TblList          = "ics.Expense,ics.ExpenseType WHERE ics.Expense ...,ics.emp WHERE ics.Expense ..."
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _TblOptList       = ",,"
     _OrdList          = "ics.Expense.Id|no"
     _JoinCode[2]      = "Expense.ExpenseTypeId = ExpenseType.Id"
     _JoinCode[3]      = "Expense.Employee# = emp.emp#"
     _FldNameList[1]   > ics.Expense.Id
"Expense.Id" ? ">>>>9" "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > ics.ExpenseType.Code
"ExpenseType.Code" ? ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > ics.Expense.Date
"Expense.Date" ? "99/99/9999" "datetime" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > ics.Expense.Amount
"Expense.Amount" ? ? "decimal" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = ics.Expense.Note
     _Query            is OPENED
*/  /* BROWSE arbrw */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 18.5
       COLUMN          = 26
       HEIGHT          = .81
       WIDTH           = 23.72
       WIDGET-ID       = 232
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {20DD1B9E-87C4-11D1-8BE3-0000F8754DA1} type: DTPicker */
      CtrlFrame:MOVE-AFTER(filID:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* ICS - Users */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. 
  IF THIS-PROCEDURE:PERSISTENT THEN  */ RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* ICS - Users */
DO:
  /* This event will close the window and terminate the procedure.  */
  MESSAGE "Confrm to close the window?" VIEW-AS ALERT-BOX INFO BUTTONS YES-NO UPDATE yn AS LOGICAL.
  IF yn = YES THEN
    DO:
      session_Window = session_Window - 1.
      APPLY "CLOSE":U TO THIS-PROCEDURE.
      RETURN NO-APPLY.
    END.
  ELSE
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME arbrw
&Scoped-define SELF-NAME arbrw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL arbrw C-Win
ON VALUE-CHANGED OF arbrw IN FRAME DEFAULT-FRAME
DO:
    IF AVAILABLE Expense THEN
        ASSIGN
        filID       = id
        cmbUserCat  = Expense.Employee#
        cmbExpenseType = Expense.ExpenseTypeId
        fillAmount = Expense.Amount
        calendr:VALUE = Expense.Date
        fillNote = Expense.Note
        .
    DISPLAY filID cmbUserCat cmbExpenseType fillAmount fillNote WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAdd C-Win
ON CHOOSE OF btnAdd IN FRAME DEFAULT-FRAME /* Add */
DO:
  ENABLE fillNote cmbUserCat cmbExpenseType fillAmount btnSave btnCancel WITH FRAME {&FRAME-NAME}.
  calendr:ENABLED = TRUE.
  DISABLE btnAdd btnDelete btnModify arbrw WITH FRAME {&FRAME-NAME}.
  
  FIND FIRST paramtrs WHERE NAME = "lastExpenseId".
  IF AVAILABLE paramtrs THEN
      filID    = INT(val) + 1.

  cmbUserCat = 0.
  cmbExpenseType = 0.
  fillAmount = 0.
  fillNote = "".
calendr:VALUE = TODAY - 1.

  addModify = "add".


  DISPLAY fillNote filID cmbUserCat cmbExpenseType fillAmount WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancel C-Win
ON CHOOSE OF btnCancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:

  DISABLE fillNote cmbUserCat cmbExpenseType fillAmount btnSave btnCancel WITH FRAME {&FRAME-NAME}.
  ENABLE btnAdd btnDelete btnModify arbrw WITH FRAME {&FRAME-NAME}.
  calendr:ENABLED = FALSE.

  OPEN QUERY arbrw FOR
      EACH ics.Expense NO-LOCK,
      EACH ics.ExpenseType WHERE Expense.ExpenseTypeID = ExpenseType.id NO-LOCK,
      EACH ics.emp WHERE Expense.Employee# = emp.emp# NO-LOCK
    BY Expense.Id DESCENDING INDEXED-REPOSITION
      .
  APPLY "VALUE-CHANGED":U TO arbrw.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDelete C-Win
ON CHOOSE OF btnDelete IN FRAME DEFAULT-FRAME /* Delete */
DO:
    IF filID = 1 THEN
    DO:
      MESSAGE "You cannot Delete this user." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
      RETURN.
    END.
    MESSAGE "Conferm to Delete the record?" VIEW-AS ALERT-BOX INFO BUTTONS YES-NO UPDATE yn AS LOGICAL.
    IF yn THEN
    DO:
        FIND FIRST Expense WHERE id = filID.
        IF AVAILABLE Expense THEN
            DELETE Expense.
        RELEASE Expense.

        OPEN QUERY arbrw FOR
            EACH ics.Expense NO-LOCK,
              EACH ics.ExpenseType WHERE Expense.ExpenseTypeid = ExpenseType.id NO-LOCK,
              EACH ics.emp WHERE Expense.Employee# = emp.emp# NO-LOCK
            BY Expense.Id DESCENDING INDEXED-REPOSITION
            .
        APPLY "VALUE-CHANGED":U TO arbrw.
    END.
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnModify
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnModify C-Win
ON CHOOSE OF btnModify IN FRAME DEFAULT-FRAME /* Modify */
DO:
  
  ENABLE fillNote cmbUserCat cmbExpenseType fillAmount btnSave btnCancel WITH FRAME {&FRAME-NAME}.
  calendr:ENABLED = TRUE.
  DISABLE btnAdd btnDelete btnModify arbrw WITH FRAME {&FRAME-NAME}.
  addModify = "modify".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSave C-Win
ON CHOOSE OF btnSave IN FRAME DEFAULT-FRAME /* Save */
DO:
    IF cmbUserCat = 0 THEN
    DO:
        MESSAGE "Employee cannot be a blank." VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN .
    END.
    IF cmbExpenseType = 0 THEN
    DO:
        MESSAGE "Expense Type cannot be a blank." VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN .
    END.
    IF fillAmount = 0 THEN
    DO:
        MESSAGE "Amount cannot be 0." VIEW-AS ALERT-BOX INFO BUTTONS OK.
        RETURN .
    END.

/*add*******************************************************************************************/

    IF addModify = "add" THEN
    DO:
        FIND FIRST Expense WHERE id = filID EXCLUSIVE-LOCK NO-ERROR.
            IF AVAILABLE Expense THEN
            DO:
                MESSAGE "Expense already exists." VIEW-AS ALERT-BOX ERROR BUTTONS OK.
                RETURN.
            END.
            ELSE IF NOT AVAILABLE Expense THEN
            DO:
                MESSAGE "Conferm to save record?" VIEW-AS ALERT-BOX INFO BUTTONS YES-NO UPDATE yn AS LOGICAL.
                IF yn = TRUE THEN
                DO:
                    CREATE Expense.
                        ASSIGN
                            id     = filID
                            Expense.Employee# = cmbUserCat
                            ics.Expense.ExpenseTypeid = cmbExpenseType
                            Expense.Amount = fillAmount
                            Expense.DATE = DATE(calendr:VALUE)
                            Expense.Note = fillNote
                            .
                    FIND FIRST paramtrs WHERE paramtrs.NAME = "lastExpenseId".
                    IF AVAILABLE paramtrs THEN
                        val    = STRING(INT(val) + 1).
                    RELEASE paramtrs. 
                END.
            END.
    END.
/*modify*****************************************************************************************************/
    ELSE IF addModify = "modify" THEN
    DO:
/*modify******************************************************validation Begins*******************************************************/
        


/*modify******************************************************validation Ends*******************************************************/
        FIND FIRST Expense WHERE Id = filID EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Expense THEN
        DO:
            MESSAGE "Conferm to save record?" VIEW-AS ALERT-BOX INFO BUTTONS YES-NO UPDATE yn1 AS LOGICAL.
                IF yn1 = TRUE THEN
                DO:
                    ASSIGN
                        id     = filID
                        Expense.Employee# = cmbUserCat
                        ics.Expense.ExpenseTypeid = cmbExpenseType
                        Expense.Amount = fillAmount
                        Expense.DATE = DATE(calendr:VALUE)
                        Expense.Note = fillNote
                        .
                END.
        END.
    END.


    DISABLE fillNote cmbUserCat cmbExpenseType fillAmount btnSave btnCancel WITH FRAME {&FRAME-NAME}.
    ENABLE btnAdd btnDelete btnModify arbrw WITH FRAME {&FRAME-NAME}.

    calendr:ENABLED = TRUE.
    DISPLAY fillNote cmbUserCat cmbExpenseType fillAmount WITH FRAME {&FRAME-NAME}.

    OPEN QUERY arbrw FOR EACH ics.Expense NO-LOCK,
      EACH ics.ExpenseType WHERE Expense.ExpenseTypeId = ExpenseType.Id NO-LOCK,
      EACH ics.emp WHERE Expense.Employee# = emp.emp# NO-LOCK
    BY Expense.Id DESCENDING INDEXED-REPOSITION.
    APPLY "VALUE-CHANGED":U TO arbrw.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbExpenseType
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbExpenseType C-Win
ON VALUE-CHANGED OF cmbExpenseType IN FRAME DEFAULT-FRAME /* Expense Type */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbUserCat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbUserCat C-Win
ON VALUE-CHANGED OF cmbUserCat IN FRAME DEFAULT-FRAME /* User */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame C-Win OCX.Change
PROCEDURE CtrlFrame.DTPicker.Change .
/*   RUN QueryLDUNLD. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filID
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filID C-Win
ON LEAVE OF filID IN FRAME DEFAULT-FRAME /* ID */
DO:
  ASSIGN filID.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filID C-Win
ON RETURN OF filID IN FRAME DEFAULT-FRAME /* ID */
DO:
  
    APPLY "CHOOSE":U TO btnSave.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fillAmount
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fillAmount C-Win
ON LEAVE OF fillAmount IN FRAME DEFAULT-FRAME /* Amount */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fillAmount C-Win
ON RETURN OF fillAmount IN FRAME DEFAULT-FRAME /* Amount */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fillAmount C-Win
ON VALUE-CHANGED OF fillAmount IN FRAME DEFAULT-FRAME /* Amount */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fillNote
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fillNote C-Win
ON LEAVE OF fillNote IN FRAME DEFAULT-FRAME /* Note */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fillNote C-Win
ON RETURN OF fillNote IN FRAME DEFAULT-FRAME /* Note */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fillNote C-Win
ON VALUE-CHANGED OF fillNote IN FRAME DEFAULT-FRAME /* Note */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
    
    
  DEFINE SHARED VARIABLE session_Path AS CHAR.
  DEFINE SHARED VARIABLE session_icon AS CHAR.
  {&WINDOW-NAME}:TITLE = session_Path.
  {&WINDOW-NAME}:LOAD-ICON(session_icon).

  session_Window = session_Window + 1.

  FOR EACH emp  NO-LOCK .
      cmbUserCat:ADD-LAST(emp.NAME,ics.emp.emp#).
  END.

  FOR EACH ics.ExpenseType  NO-LOCK .
      cmbExpenseType:ADD-LAST(ics.ExpenseType.Code,ics.ExpenseType.Id).
  END.

  calendr = chCtrlFrame:DTPicker.
  calendr:ENABLED = FALSE.
  calendr:VALUE = TODAY - 1.

  APPLY "VALUE-CHANGED":U TO arbrw.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load C-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "Expense.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
    CtrlFrame:NAME = "CtrlFrame":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "Expense.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  RUN control_load.
  DISPLAY filID fillAmount cmbUserCat fillNote cmbExpenseType 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE arbrw btnAdd btnModify btnDelete 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

