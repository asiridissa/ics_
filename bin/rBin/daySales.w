&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          ics              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.

DEFINE SHARED VARIABLE session_Window AS INT.
DEFINE VARIABLE calendr AS COM-HANDLE   NO-UNDO.

/* DEFINE TEMP-TABLE tt-DaySale */
/*     FIELDS ID       AS INT   */
/*     FIELDS Itmid    AS INT   */
/*     FIELDS ItmName  AS CHAR  */
/*     FIELDS Weight   AS DEC   */
/*     FIELDS UPrice   AS DEC   */
/*     FIELDS BSP      AS INT   */
/*     FIELDS BSC      AS INT   */
/*     FIELDS Pcs      AS INT   */
/*     FIELDS Cas      AS INT   */
/*     FIELDS GdP      AS INT   */
/*     FIELDS GdC      AS INT   */
/*     FIELDS DmP      AS INT   */
/*     FIELDS DmC      AS INT   */
/*     FIELDS ExP      AS INT   */
/*     FIELDS ExC      AS INT   */
/*     FIELDS ULP      AS INT   */
/*     FIELDS ULC      AS INT   */
/*     FIELDS RDP      AS INT   */
/*     FIELDS RDC      AS INT   */
/*     FIELDS Amount   AS DEC   */
/*     .                        */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brwDaysSale

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES BalanceStock

/* Definitions for BROWSE brwDaysSale                                   */
&Scoped-define FIELDS-IN-QUERY-brwDaysSale BalanceStock.ID ~
BalanceStock.ItmID BalanceStock.itmName BalanceStock.itmWeight ~
BalanceStock.uPrice BalanceStock.BSP BalanceStock.BSC BalanceStock.Pcs ~
BalanceStock.Cas BalanceStock.GdP BalanceStock.GdC BalanceStock.DmP ~
BalanceStock.DmC BalanceStock.ExP BalanceStock.ExC BalanceStock.UlP ~
BalanceStock.UlC BalanceStock.RdP BalanceStock.RdC BalanceStock.Amount 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brwDaysSale 
&Scoped-define QUERY-STRING-brwDaysSale FOR EACH BalanceStock NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brwDaysSale OPEN QUERY brwDaysSale FOR EACH BalanceStock NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brwDaysSale BalanceStock
&Scoped-define FIRST-TABLE-IN-QUERY-brwDaysSale BalanceStock


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brwDaysSale}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btnGenerate brwDaysSale 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame-2 AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame-2 AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnGenerate 
     LABEL "Generate" 
     SIZE 15 BY 1.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brwDaysSale FOR 
      BalanceStock SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brwDaysSale
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brwDaysSale C-Win _STRUCTURED
  QUERY brwDaysSale NO-LOCK DISPLAY
      BalanceStock.ID FORMAT ">>>>>>>9":U
      BalanceStock.ItmID FORMAT ">>>>>>>9":U
      BalanceStock.itmName FORMAT "x(100)":U WIDTH 35
      BalanceStock.itmWeight FORMAT ">9.999":U
      BalanceStock.uPrice FORMAT ">>>,>>9.99":U WIDTH 9
      BalanceStock.BSP FORMAT ">>9":U WIDTH 3
      BalanceStock.BSC FORMAT ">>9":U WIDTH 3
      BalanceStock.Pcs FORMAT ">>9":U WIDTH 3
      BalanceStock.Cas FORMAT ">>9":U WIDTH 3
      BalanceStock.GdP FORMAT ">>9":U WIDTH 3
      BalanceStock.GdC FORMAT ">>9":U WIDTH 3
      BalanceStock.DmP FORMAT ">>9":U WIDTH 3
      BalanceStock.DmC FORMAT ">>9":U WIDTH 3
      BalanceStock.ExP FORMAT ">>9":U WIDTH 3
      BalanceStock.ExC FORMAT ">>9":U WIDTH 3
      BalanceStock.UlP FORMAT ">>9":U WIDTH 3
      BalanceStock.UlC FORMAT ">>9":U WIDTH 3
      BalanceStock.RdP FORMAT ">>9":U WIDTH 3
      BalanceStock.RdC FORMAT ">>9":U WIDTH 3
      BalanceStock.Amount FORMAT ">>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 144.86 BY 20.46 ROW-HEIGHT-CHARS .62 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btnGenerate AT ROW 1.27 COL 56 WIDGET-ID 74
     brwDaysSale AT ROW 2.62 COL 1 WIDGET-ID 300
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 144.86 BY 26.42 WIDGET-ID 100.


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
         TITLE              = "<insert window title>"
         HEIGHT             = 26.42
         WIDTH              = 144.86
         MAX-HEIGHT         = 26.42
         MAX-WIDTH          = 144.86
         VIRTUAL-HEIGHT     = 26.42
         VIRTUAL-WIDTH      = 144.86
         RESIZE             = yes
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
/* BROWSE-TAB brwDaysSale btnGenerate DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brwDaysSale
/* Query rebuild information for BROWSE brwDaysSale
     _TblList          = "ics.BalanceStock"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = ics.BalanceStock.ID
     _FldNameList[2]   = ics.BalanceStock.ItmID
     _FldNameList[3]   > ics.BalanceStock.itmName
"BalanceStock.itmName" ? ? "character" ? ? ? ? ? ? no ? no no "35" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = ics.BalanceStock.itmWeight
     _FldNameList[5]   > ics.BalanceStock.uPrice
"BalanceStock.uPrice" ? ? "decimal" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > ics.BalanceStock.BSP
"BalanceStock.BSP" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > ics.BalanceStock.BSC
"BalanceStock.BSC" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > ics.BalanceStock.Pcs
"BalanceStock.Pcs" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > ics.BalanceStock.Cas
"BalanceStock.Cas" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > ics.BalanceStock.GdP
"BalanceStock.GdP" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > ics.BalanceStock.GdC
"BalanceStock.GdC" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > ics.BalanceStock.DmP
"BalanceStock.DmP" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > ics.BalanceStock.DmC
"BalanceStock.DmC" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > ics.BalanceStock.ExP
"BalanceStock.ExP" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > ics.BalanceStock.ExC
"BalanceStock.ExC" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > ics.BalanceStock.UlP
"BalanceStock.UlP" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > ics.BalanceStock.UlC
"BalanceStock.UlC" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > ics.BalanceStock.RdP
"BalanceStock.RdP" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > ics.BalanceStock.RdC
"BalanceStock.RdC" ? ? "integer" ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   = ics.BalanceStock.Amount
     _Query            is OPENED
*/  /* BROWSE brwDaysSale */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 1.42
       COLUMN          = 10
       HEIGHT          = .81
       WIDTH           = 23.14
       WIDGET-ID       = 72
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {20DD1B9E-87C4-11D1-8BE3-0000F8754DA1} type: DTPicker */
      CtrlFrame-2:MOVE-AFTER(btnGenerate:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
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


&Scoped-define SELF-NAME CtrlFrame-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.Click
PROCEDURE CtrlFrame-2.DTPicker.Click .
calendr:VALUE = STRING(TODAY,"99/99/9999").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brwDaysSale
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

  session_Window = session_Window + 1.
  calendr = chCtrlFrame-2:DTPicker.
  calendr:ENABLED = TRUE.
  calendr:VALUE = STRING((TODAY - 1),"99/99/9999").

  RUN daySaleLoader.

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

OCXFile = SEARCH( "daySale.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame-2 = CtrlFrame-2:COM-HANDLE
    UIB_S = chCtrlFrame-2:LoadControls( OCXFile, "CtrlFrame-2":U)
    CtrlFrame-2:NAME = "CtrlFrame-2":U
  .
  RUN initialize-controls IN THIS-PROCEDURE NO-ERROR.
END.
ELSE MESSAGE "daySale.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE daySaleLoader C-Win 
PROCEDURE daySaleLoader :
DEFINE VARIABLE valID AS INTEGER     NO-UNDO.

    FIND FIRST paramtrs WHERE paramtrs.NAME = "lastBsID".
        valID = int(paramtrs.val).
    RELEASE paramtrs.

    FOR EACH itms BY itms.itmName.
        CREATE BalanceStock.
            BalanceStock.ID        = valID + 1.
            BalanceStock.ItmID     = itms.itmID.
            BalanceStock.itmName   = itms.itmName.
            BalanceStock.itmWeight = itms.unitWeightKG.
            BalanceStock.uPrice    = itms.unitPriceS.
            BalanceStock.crDate    = 10/26/2012.
            FIND FIRST Bs WHERE Bs.itmID = itms.itmID AND Bs.crDate = 10/26/2012.
                BalanceStock.BSP = Bs.Bsp.
                BalanceStock.BSC = Bs.BsC.
            RELEASE Bs.
            

/*             BalanceStock.Pcs       = */
/*             BalanceStock.Cas       = */
/*             BalanceStock.GdP       = */
/*             BalanceStock.GdC       = */
/*             BalanceStock.DmP       = */
/*             BalanceStock.DmC       = */
/*             BalanceStock.ExP       = */
/*             BalanceStock.ExC       = */
/*             BalanceStock.RdP       = */
/*             BalanceStock.RdC       = */
/*             BalanceStock.UlP       = */
/*             BalanceStock.UlC       = */
/*             BalanceStock.Amount    = */

        valID = valID + 1.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE daysSale C-Win 
PROCEDURE daysSale :
DEFINE VARIABLE tempDate AS DATE        NO-UNDO.
tempDate = calendr:VALUE.
OPEN QUERY brwDaysSale FOR EACH ics.BalanceStock WHERE BalanceStock.crDate = tempDate NO-LOCK INDEXED-REPOSITION.

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
  ENABLE btnGenerate brwDaysSale 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

