&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          ics              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.

DEFINE VARIABLE calendr AS COM-HANDLE   NO-UNDO.

DEFINE VARIABLE tempCalendr AS DATE        NO-UNDO.

DEFINE VARIABLE addModify AS CHARACTER   NO-UNDO.
DEFINE VARIABLE tempBsID AS INT   NO-UNDO INIT 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brw

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES lorryStock

/* Definitions for BROWSE brw                                           */
&Scoped-define FIELDS-IN-QUERY-brw lorryStock.ID lorryStock.itmID ~
lorryStock.VehID lorryStock.itmName lorryStock.weight lorryStock.BSP ~
lorryStock.BSC lorryStock.LDP lorryStock.LDC lorryStock.StockP ~
lorryStock.StockC lorryStock.crDate 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw 
&Scoped-define QUERY-STRING-brw FOR EACH lorryStock NO-LOCK ~
    BY lorryStock.itmName INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brw OPEN QUERY brw FOR EACH lorryStock NO-LOCK ~
    BY lorryStock.itmName INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brw lorryStock
&Scoped-define FIRST-TABLE-IN-QUERY-brw lorryStock


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brw}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS cmbVeh btnPrev btnNext btnSelect brw 
&Scoped-Define DISPLAYED-OBJECTS cmbVeh cmbName filRecipt# filUnitPrice ~
filPerCase filStockP filKg filCasePrice filBSP filLDP filBalanceP filBSC ~
filLDC filBalanceC 

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
DEFINE BUTTON btnAddItem 
     LABEL "Add Item" 
     SIZE 14 BY 1.

DEFINE BUTTON btnCancel 
     LABEL "cancel" 
     SIZE 14 BY 1.

DEFINE BUTTON btnModify 
     LABEL "Modify" 
     SIZE 14 BY 1.

DEFINE BUTTON btnNext 
     LABEL "Next >>" 
     SIZE 12 BY 1.

DEFINE BUTTON btnPrev 
     LABEL "<< Previous" 
     SIZE 12 BY 1.

DEFINE BUTTON btnSave 
     LABEL "Save" 
     SIZE 14 BY 1.

DEFINE BUTTON btnSelect 
     LABEL "Edit" 
     SIZE 14 BY 1.

DEFINE BUTTON btnView 
     LABEL "View" 
     SIZE 14 BY 1.

DEFINE VARIABLE cmbName AS CHARACTER FORMAT "X(32)":U INITIAL "0" 
     LABEL "Name" 
     VIEW-AS COMBO-BOX SORT INNER-LINES 30
     LIST-ITEM-PAIRS "--Select Here--","0"
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE cmbVeh AS INTEGER FORMAT ">>>>9":U INITIAL 0 
     LABEL "Vehicle" 
     VIEW-AS COMBO-BOX SORT INNER-LINES 10
     LIST-ITEM-PAIRS "--Select Here--",0
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE filBalanceC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "BalanceC" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filBalanceP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "BalanceP" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filBSC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "BSC" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filBSP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "BSP" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filCasePrice AS DECIMAL FORMAT ">,>>>,>>9.99":U INITIAL 0 
     LABEL "C Price" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filKg AS DECIMAL FORMAT ">>9.999":U INITIAL 0 
     LABEL "Weight" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filLDC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "LDC" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filLDP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "LDP" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filPerCase AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "PerCase" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filRecipt# AS INTEGER FORMAT ">,>>>,>>>,>>>9":U INITIAL 0 
     LABEL "ID" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filStockP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Stock P" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filUnitPrice AS DECIMAL FORMAT ">,>>>,>>9.99":U INITIAL 0 
     LABEL "P Price" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw FOR 
      lorryStock SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw C-Win _STRUCTURED
  QUERY brw NO-LOCK DISPLAY
      lorryStock.ID FORMAT ">>>>>>>9":U
      lorryStock.itmID FORMAT ">>>>>>9":U
      lorryStock.VehID FORMAT ">>>9":U
      lorryStock.itmName FORMAT "x(50)":U WIDTH 35
      lorryStock.weight FORMAT ">>9.999":U
      lorryStock.BSP FORMAT ">>>9":U
      lorryStock.BSC FORMAT ">>>9":U
      lorryStock.LDP FORMAT ">>>9":U
      lorryStock.LDC FORMAT ">>>9":U
      lorryStock.StockP FORMAT ">>>9":U
      lorryStock.StockC FORMAT ">>>9":U
      lorryStock.crDate FORMAT "99/99/9999":U WIDTH 20
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 118.14 BY 17.77
         FONT 10
         TITLE "Lorry Stock" ROW-HEIGHT-CHARS .66 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     cmbVeh AT ROW 1.23 COL 37.86 COLON-ALIGNED WIDGET-ID 84
     btnPrev AT ROW 2.35 COL 8.29 WIDGET-ID 216
     btnNext AT ROW 2.35 COL 20.43 WIDGET-ID 218
     btnSelect AT ROW 2.35 COL 42 WIDGET-ID 190
     btnView AT ROW 2.35 COL 58 WIDGET-ID 224
     cmbName AT ROW 3.62 COL 34 COLON-ALIGNED WIDGET-ID 54
     filRecipt# AT ROW 3.65 COL 9.86 COLON-ALIGNED WIDGET-ID 4 NO-TAB-STOP 
     filUnitPrice AT ROW 4.62 COL 9.86 COLON-ALIGNED WIDGET-ID 58 NO-TAB-STOP 
     filPerCase AT ROW 4.62 COL 33.86 COLON-ALIGNED WIDGET-ID 162 NO-TAB-STOP 
     filStockP AT ROW 4.62 COL 45.72 COLON-ALIGNED WIDGET-ID 158
     filKg AT ROW 4.62 COL 57.14 COLON-ALIGNED WIDGET-ID 8 NO-TAB-STOP 
     filCasePrice AT ROW 5.58 COL 9.86 COLON-ALIGNED WIDGET-ID 64 NO-TAB-STOP 
     filBSP AT ROW 5.58 COL 45.72 COLON-ALIGNED WIDGET-ID 164
     filLDP AT ROW 5.58 COL 59 COLON-ALIGNED WIDGET-ID 226
     filBalanceP AT ROW 5.58 COL 77 COLON-ALIGNED WIDGET-ID 230
     btnAddItem AT ROW 6.65 COL 6 WIDGET-ID 192
     btnModify AT ROW 6.65 COL 20.14 WIDGET-ID 208
     filBSC AT ROW 6.65 COL 45.72 COLON-ALIGNED WIDGET-ID 166
     filLDC AT ROW 6.65 COL 59 COLON-ALIGNED WIDGET-ID 228
     filBalanceC AT ROW 6.65 COL 77 COLON-ALIGNED WIDGET-ID 232
     btnSave AT ROW 7.73 COL 48 WIDGET-ID 210
     btnCancel AT ROW 7.73 COL 62.14 WIDGET-ID 214
     brw AT ROW 8.92 COL 1 WIDGET-ID 200
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 118.14 BY 25.73
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
         TITLE              = "<insert window title>"
         COLUMN             = 55
         ROW                = 4.19
         HEIGHT             = 25.73
         WIDTH              = 118.14
         MAX-HEIGHT         = 27.15
         MAX-WIDTH          = 195.14
         VIRTUAL-HEIGHT     = 27.15
         VIRTUAL-WIDTH      = 195.14
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
/* BROWSE-TAB brw btnCancel DEFAULT-FRAME */
/* SETTINGS FOR BUTTON btnAddItem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnModify IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnSave IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnView IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbName IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBalanceC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBalanceP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBSC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBSP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filCasePrice IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filKg IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filLDC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filLDP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filPerCase IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filRecipt# IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filStockP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filUnitPrice IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brw
/* Query rebuild information for BROWSE brw
     _TblList          = "ics.lorryStock"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "ics.lorryStock.itmName|yes"
     _FldNameList[1]   = ics.lorryStock.ID
     _FldNameList[2]   = ics.lorryStock.itmID
     _FldNameList[3]   = ics.lorryStock.VehID
     _FldNameList[4]   > ics.lorryStock.itmName
"lorryStock.itmName" ? ? "character" ? ? ? ? ? ? no ? no no "35" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = ics.lorryStock.weight
     _FldNameList[6]   = ics.lorryStock.BSP
     _FldNameList[7]   = ics.lorryStock.BSC
     _FldNameList[8]   = ics.lorryStock.LDP
     _FldNameList[9]   = ics.lorryStock.LDC
     _FldNameList[10]   = ics.lorryStock.StockP
     _FldNameList[11]   = ics.lorryStock.StockC
     _FldNameList[12]   > ics.lorryStock.crDate
"lorryStock.crDate" ? ? "date" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brw */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 1.27
       COLUMN          = 9
       HEIGHT          = .81
       WIDTH           = 23.14
       WIDGET-ID       = 72
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {20DD1B9E-87C4-11D1-8BE3-0000F8754DA1} type: DTPicker */
      CtrlFrame-2:MOVE-AFTER(cmbVeh:HANDLE IN FRAME DEFAULT-FRAME).

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
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAddItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAddItem C-Win
ON CHOOSE OF btnAddItem IN FRAME DEFAULT-FRAME /* Add Item */
DO:
    cmbName = string(0).
    addModify = "add".
    ENABLE cmbName filLDP filLDC WITH FRAME {&FRAME-NAME}.
    DISABLE brw btnAddItem btnModify WITH FRAME {&FRAME-NAME}.
    RUN itemLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancel C-Win
ON CHOOSE OF btnCancel IN FRAME DEFAULT-FRAME /* cancel */
DO:
  ENABLE btnAddItem btnCancel btnModify btnSave cmbName filBSC filBSP WITH FRAME {&FRAME-NAME}.
  DISABLE brw btnNext btnPrev btnSelect cmbVeh WITH FRAME {&FRAME-NAME}.
  RUN queryLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnModify
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnModify C-Win
ON CHOOSE OF btnModify IN FRAME DEFAULT-FRAME /* Modify */
DO:

  addModify = "modify".
  ENABLE filBSP filBSC WITH FRAME {&FRAME-NAME}.
  DISABLE brw btnAddItem btnModify WITH FRAME {&FRAME-NAME}.
  RUN queryLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext C-Win
ON CHOOSE OF btnNext IN FRAME DEFAULT-FRAME /* Next >> */
DO:
  calendr:VALUE = date(calendr:VALUE) + 1.
  RUN queryLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev C-Win
ON CHOOSE OF btnPrev IN FRAME DEFAULT-FRAME /* << Previous */
DO:
  calendr:VALUE = date(calendr:VALUE) - 1.
  RUN queryLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSave C-Win
ON CHOOSE OF btnSave IN FRAME DEFAULT-FRAME /* Save */
DO:
  DEFINE VARIABLE tempBsID AS INTEGER     NO-UNDO.

  IF  filLDP  = 0 AND filLDC = 0 THEN
  DO:
      MESSAGE "Entetr some values first." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
      RETURN.
  END.
  MESSAGE "Conferm to save the record?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE yn AS LOGICAL.
  IF yn = TRUE THEN
  DO:
      IF addModify = "add" THEN
      DO:
          FIND FIRST paramtrs WHERE paramtrs.name = "lastBsID".
            tempBsID = INT(paramtrs.val).

          CREATE Bs.
              Bs.ID       = tempBsID + 1.
              Bs.BsC      = filBSC.
              Bs.Bsp      = filBSP.
              Bs.crDate   = calendr:VALUE.
              Bs.itmID    = filRecipt#.
              FIND FIRST itms WHERE itms.itmID = filRecipt#.
              Bs.itmName  = itms.itmName.
              Bs.vehID    = cmbVeh.
            
          paramtrs.val = STRING(tempBsID + 1).
          RELEASE paramtrs.
      END.
      IF addModify = "modify" THEN
      DO:
          tempCalendr = calendr:VALUE.
          FIND FIRST ics.Bs WHERE Bs.itmID = filRecipt# AND Bs.vehID = cmbVeh AND Bs.crDate = tempCalendr.
          Bs.BsC      = filBSC.
          Bs.Bsp      = filBSP.
          RELEASE Bs.
      END.
  END.

  IF ERROR-STATUS:ERROR = FALSE THEN
      MESSAGE "Record saved successfully." VIEW-AS ALERT-BOX INFO BUTTONS OK.

  DISABLE btnAddItem btnCancel btnModify btnSave cmbName filBSC filBSP WITH FRAME {&FRAME-NAME}.
  ENABLE btnAddItem btnModify WITH FRAME {&FRAME-NAME}.
  RUN queryLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSelect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSelect C-Win
ON CHOOSE OF btnSelect IN FRAME DEFAULT-FRAME /* Edit */
DO:
    IF cmbVeh = 0 THEN
    DO:
        MESSAGE "Select Vehicle first." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
        RETURN.
    END.
    IF calendr:VALUE > TODAY  THEN
    DO:
        MESSAGE "Select a valid Date." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
        RETURN.
    END.
  ENABLE btnView btnAddItem btnCancel btnModify btnSave WITH FRAME {&FRAME-NAME}.
  DISABLE btnNext btnPrev btnSelect cmbVeh WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnView
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnView C-Win
ON CHOOSE OF btnView IN FRAME DEFAULT-FRAME /* View */
DO:
  DISABLE btnView btnAddItem btnCancel btnModify btnSave WITH FRAME {&FRAME-NAME}.
  ENABLE btnNext btnPrev btnSelect cmbVeh WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbName C-Win
ON VALUE-CHANGED OF cmbName IN FRAME DEFAULT-FRAME /* Name */
DO:
  ASSIGN {&SELF-NAME}.

  FIND FIRST itms WHERE itmID = INT(cmbName) NO-ERROR.
  IF AVAILABLE itms THEN
  DO:
    filRecipt#   = itms.itmID.
    filKg        = unitWeightKG.
    filUnitPrice = unitPriceS.
    filCasePrice = casePriceS.
    filPerCase   = unitsPerCase.
    filStockP    = stockP + (stockC * filPerCase).
  END.
  ELSE IF NOT AVAILABLE itms THEN 
  DO:
    filKg = 0.
    filUnitPrice = 0.
  END.
  RELEASE itms.
  DISPLAY filRecipt# filPerCase filStockP filKg filUnitPrice filCasePrice WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbVeh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbVeh C-Win
ON VALUE-CHANGED OF cmbVeh IN FRAME DEFAULT-FRAME /* Vehicle */
DO:
  ASSIGN {&SELF-NAME}.
  RUN queryLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.Change
PROCEDURE CtrlFrame-2.DTPicker.Change .
RUN queryLoader.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.Click
PROCEDURE CtrlFrame-2.DTPicker.Click .
RUN queryLoader.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBalanceC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBalanceC C-Win
ON LEAVE OF filBalanceC IN FRAME DEFAULT-FRAME /* BalanceC */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBalanceP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBalanceP C-Win
ON LEAVE OF filBalanceP IN FRAME DEFAULT-FRAME /* BalanceP */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBSC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBSC C-Win
ON LEAVE OF filBSC IN FRAME DEFAULT-FRAME /* BSC */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBSP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBSP C-Win
ON LEAVE OF filBSP IN FRAME DEFAULT-FRAME /* BSP */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filCasePrice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filCasePrice C-Win
ON LEAVE OF filCasePrice IN FRAME DEFAULT-FRAME /* C Price */
DO:
  
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filKg
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filKg C-Win
ON LEAVE OF filKg IN FRAME DEFAULT-FRAME /* Weight */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filLDC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filLDC C-Win
ON LEAVE OF filLDC IN FRAME DEFAULT-FRAME /* LDC */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filLDP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filLDP C-Win
ON LEAVE OF filLDP IN FRAME DEFAULT-FRAME /* LDP */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filPerCase
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filPerCase C-Win
ON LEAVE OF filPerCase IN FRAME DEFAULT-FRAME /* PerCase */
DO:
  
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filRecipt#
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filRecipt# C-Win
ON LEAVE OF filRecipt# IN FRAME DEFAULT-FRAME /* ID */
DO:
  
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filStockP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filStockP C-Win
ON LEAVE OF filStockP IN FRAME DEFAULT-FRAME /* Stock P */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filUnitPrice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filUnitPrice C-Win
ON LEAVE OF filUnitPrice IN FRAME DEFAULT-FRAME /* P Price */
DO:
  
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brw
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

  calendr = chCtrlFrame-2:DTPicker.
  calendr:ENABLED = TRUE.
  calendr:VALUE = STRING(TODAY,"99/99/9999").

  RUN vehLoader.
  RUN itemLoader.

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

OCXFile = SEARCH( "LorryStock.wrx":U ).
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
ELSE MESSAGE "LorryStock.wrx":U SKIP(1)
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
  DISPLAY cmbVeh cmbName filRecipt# filUnitPrice filPerCase filStockP filKg 
          filCasePrice filBSP filLDP filBalanceP filBSC filLDC filBalanceC 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE cmbVeh btnPrev btnNext btnSelect brw 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE itemLoader C-Win 
PROCEDURE itemLoader :
cmbName:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = "--Select Here--,0" NO-ERROR.
tempCalendr = calendr:VALUE.
FOR EACH itms BY itms.itmName.
    FIND FIRST BS WHERE Bs.itmID = itms.itmID AND Bs.crDate = tempCalendr AND Bs.vehID = cmbVeh NO-ERROR.
    IF NOT AVAILABLE BS THEN
        cmbName:ADD-LAST(itms.itmName + " - " + STRING(unitWeightKG,">>9.999") + " kg",STRING(itms.itmID)) IN FRAME {&FRAME-NAME} NO-ERROR. 
    RELEASE BS.
END.
DISPLAY cmbName WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE queryLoader C-Win 
PROCEDURE queryLoader :
tempCalendr = calendr:VALUE.
OPEN QUERY brw
    FOR EACH ics.lorryStock WHERE lorryStock.crDate = tempCalendr AND lorryStock.VehID = cmbVeh NO-LOCK
    BY lorryStock.itmName INDEXED-REPOSITION.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE vehLoader C-Win 
PROCEDURE vehLoader :
FOR EACH vehical.
    cmbVeh:ADD-LAST(veh# + " - " + descrip,ID) IN FRAME {&FRAME-NAME}.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

