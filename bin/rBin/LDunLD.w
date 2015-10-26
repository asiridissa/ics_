&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.

DEFINE VARIABLE calendr AS COM-HANDLE   NO-UNDO.

DEFINE TEMP-TABLE tt-ldunld
 FIELDS ID       AS INT
 FIELDS vehNo    AS INT
 FIELDS itmID    AS INT
 FIELDS itmName  AS CHAR
 FIELDS Weight   AS DEC
 FIELDS PriceP   AS DEC
 FIELDS BSC      AS INT
 FIELDS BSP      AS INT
 FIELDS LDC      AS INT
 FIELDS LDP      AS INT
 FIELDS ULC      AS INT
 FIELDS ULP      AS INT
 FIELDS RDC      AS INT
 FIELDS RDP      AS INT
 FIELDS TolP      AS INT
 FIELDS TOlC      AS INT
 FIELDS Excess      AS INT
 FIELDS Short      AS INT
 FIELDS Amount   AS DEC
 .

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
&Scoped-define INTERNAL-TABLES tt-ldunld

/* Definitions for BROWSE brw                                           */
&Scoped-define FIELDS-IN-QUERY-brw /* ID */ /* vehNo */ /* itmID */ itmName Weight /* PriceP */ BSP BSC LDP LDC ULP ULC RDP RDC Excess Short /* Amount */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw   
&Scoped-define SELF-NAME brw
&Scoped-define QUERY-STRING-brw FOR EACH tt-ldunld
&Scoped-define OPEN-QUERY-brw OPEN QUERY brw FOR EACH tt-ldunld.
&Scoped-define TABLES-IN-QUERY-brw tt-ldunld
&Scoped-define FIRST-TABLE-IN-QUERY-brw tt-ldunld


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brw}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brw btnAddTable btnModifyTable ~
btnDeleteTable btnViewOld 
&Scoped-Define DISPLAYED-OBJECTS cmbVeh filLastWorkingDay filRecipt# ~
cmbName filKg filPerCase filUnitPrice filCasePrice filStockP filBSP filBSC ~
filLDP filLDC filTolLDP filTolLDC filULP filULC filRDP filRDC filTolRDP ~
filBillP filExcessShortP 

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
DEFINE BUTTON btnAddItem 
     LABEL "Add Item" 
     SIZE 14 BY 1.

DEFINE BUTTON btnAddTable 
     LABEL "Add Table" 
     SIZE 14 BY 1.

DEFINE BUTTON btnBegin 
     LABEL "Begin" 
     SIZE 11 BY 1.

DEFINE BUTTON btnCancel 
     LABEL "Cancel" 
     SIZE 14 BY 1.

DEFINE BUTTON btnCancelTable 
     LABEL "Cancel Table" 
     SIZE 14 BY 1.

DEFINE BUTTON btnDeleteItem 
     LABEL "Delete Item" 
     SIZE 14 BY 1.

DEFINE BUTTON btnDeleteTable 
     LABEL "Delete Table" 
     SIZE 14 BY 1.

DEFINE BUTTON btnModifyItem 
     LABEL "Modify Item" 
     SIZE 14 BY 1.

DEFINE BUTTON btnModifyTable 
     LABEL "Modify Table" 
     SIZE 14 BY 1.

DEFINE BUTTON btnSave 
     LABEL "Save" 
     SIZE 14 BY 1.

DEFINE BUTTON btnSaveTable 
     LABEL "Save Table" 
     SIZE 14 BY 1.

DEFINE BUTTON btnViewOld 
     LABEL "View Old" 
     SIZE 14 BY 1.

DEFINE VARIABLE cmbName AS CHARACTER FORMAT "X(32)":U INITIAL "0" 
     LABEL "Name" 
     VIEW-AS COMBO-BOX INNER-LINES 30
     LIST-ITEM-PAIRS "--Select Here--","0"
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE cmbVeh AS INTEGER FORMAT ">>>>9":U INITIAL 0 
     LABEL "Vehical" 
     VIEW-AS COMBO-BOX SORT INNER-LINES 10
     LIST-ITEM-PAIRS "--Select Here--",0
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE filBillP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Billed P" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filBSC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "BSC" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filBSP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "BSP" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filCasePrice AS DECIMAL FORMAT ">,>>>,>>9.99":U INITIAL 0 
     LABEL "C Price" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .85
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filExcessShortP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Variance" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE filKg AS DECIMAL FORMAT ">>9.999":U INITIAL 0 
     LABEL "Weight" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .85
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filLastWorkingDay AS DATE FORMAT "99/99/9999":U 
     LABEL "Last Working Day" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .85
     BGCOLOR 4 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE filLDC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "LDC" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filLDP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "LDP" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filPerCase AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "PerCase" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filRDC AS INTEGER FORMAT "->>>9":U INITIAL 0 
     LABEL "RDC" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filRDP AS INTEGER FORMAT "->>>9":U INITIAL 0 
     LABEL "RDP" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filRecipt# AS INTEGER FORMAT ">,>>>,>>>,>>>9":U INITIAL 0 
     LABEL "ID" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .85
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filStockP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Stock P" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filTolLDC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Tol LDC" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filTolLDP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Tol LDP" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filTolRDP AS INTEGER FORMAT "->>>9":U INITIAL 0 
     LABEL "Tol RDP" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 0 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filULC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "ULC" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filULP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "ULP" 
     VIEW-AS FILL-IN 
     SIZE 5 BY .85
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filUnitPrice AS DECIMAL FORMAT ">,>>>,>>9.99":U INITIAL 0 
     LABEL "P Price" 
     VIEW-AS FILL-IN 
     SIZE 15 BY .85
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw FOR 
      tt-ldunld SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw C-Win _FREEFORM
  QUERY brw DISPLAY
      /*       ID */
/* vehNo */
/* itmID */
itmName FORMAT "X(52)":U LABEL "Item Name"
Weight  FORMAT ">>>9.999"
/* PriceP */
BSP    FORMAT ">>>9" COLUMN-FGCOLOR 1
BSC    FORMAT ">>>9" COLUMN-FGCOLOR 9 COLUMN-BGCOLOR 16
LDP    FORMAT ">>>9" COLUMN-FGCOLOR 1
LDC    FORMAT ">>>9" COLUMN-FGCOLOR 9 COLUMN-BGCOLOR 16
ULP    FORMAT ">>>9" COLUMN-FGCOLOR 1
ULC    FORMAT ">>>9" COLUMN-FGCOLOR 9 COLUMN-BGCOLOR 16
RDP    FORMAT "->>>9" COLUMN-FGCOLOR 1
RDC    FORMAT "->>>9" COLUMN-FGCOLOR 9 COLUMN-BGCOLOR 16
Excess FORMAT ">>>9" COLUMN-FGCOLOR 2
Short  FORMAT ">>>9" COLUMN-FGCOLOR 12
/* Amount FORMAT ">,>>>,>>9.99" */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 99 BY 26.5
         FONT 10
         TITLE "Loading Unloading" ROW-HEIGHT-CHARS .66 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     brw AT ROW 1 COL 46 WIDGET-ID 200
     btnAddTable AT ROW 1.27 COL 1.57 WIDGET-ID 190
     btnModifyTable AT ROW 1.27 COL 15.86 WIDGET-ID 218
     btnDeleteTable AT ROW 1.27 COL 30.86 WIDGET-ID 220
     btnViewOld AT ROW 2.35 COL 1.57 WIDGET-ID 230
     btnSaveTable AT ROW 2.35 COL 15.86 WIDGET-ID 224
     btnCancelTable AT ROW 2.35 COL 30.86 WIDGET-ID 222
     cmbVeh AT ROW 3.69 COL 7 COLON-ALIGNED WIDGET-ID 84
     filLastWorkingDay AT ROW 5.69 COL 22 COLON-ALIGNED WIDGET-ID 206
     btnBegin AT ROW 6.65 COL 9 WIDGET-ID 226
     filRecipt# AT ROW 8.04 COL 8 COLON-ALIGNED WIDGET-ID 4 NO-TAB-STOP 
     cmbName AT ROW 9.08 COL 8 COLON-ALIGNED WIDGET-ID 54
     filKg AT ROW 10.15 COL 8 COLON-ALIGNED WIDGET-ID 8 NO-TAB-STOP 
     filPerCase AT ROW 10.15 COL 28 COLON-ALIGNED WIDGET-ID 162 NO-TAB-STOP 
     filUnitPrice AT ROW 11.23 COL 8 COLON-ALIGNED WIDGET-ID 58 NO-TAB-STOP 
     filCasePrice AT ROW 12.04 COL 8 COLON-ALIGNED WIDGET-ID 64 NO-TAB-STOP 
     filStockP AT ROW 13.12 COL 8 COLON-ALIGNED WIDGET-ID 158
     btnAddItem AT ROW 13.12 COL 18 WIDGET-ID 192
     filBSP AT ROW 14.19 COL 8 COLON-ALIGNED WIDGET-ID 164
     btnModifyItem AT ROW 14.46 COL 18 WIDGET-ID 208
     filBSC AT ROW 15 COL 8 COLON-ALIGNED WIDGET-ID 166
     btnDeleteItem AT ROW 15.54 COL 18 WIDGET-ID 210
     filLDP AT ROW 16.08 COL 8 COLON-ALIGNED WIDGET-ID 168
     filLDC AT ROW 16.88 COL 8 COLON-ALIGNED WIDGET-ID 180
     btnSave AT ROW 17.42 COL 18 WIDGET-ID 212
     filTolLDP AT ROW 17.96 COL 8 COLON-ALIGNED WIDGET-ID 196
     filTolLDC AT ROW 18.77 COL 8 COLON-ALIGNED WIDGET-ID 194
     btnCancel AT ROW 18.77 COL 18 WIDGET-ID 214
     filULP AT ROW 19.85 COL 8 COLON-ALIGNED WIDGET-ID 182
     filULC AT ROW 20.65 COL 8 COLON-ALIGNED WIDGET-ID 184
     filRDP AT ROW 21.73 COL 8 COLON-ALIGNED WIDGET-ID 186
     filRDC AT ROW 22.54 COL 8 COLON-ALIGNED WIDGET-ID 188
     filTolRDP AT ROW 23.62 COL 8 COLON-ALIGNED WIDGET-ID 228
     filBillP AT ROW 24.42 COL 8 COLON-ALIGNED WIDGET-ID 200
     filExcessShortP AT ROW 25.5 COL 8 COLON-ALIGNED WIDGET-ID 204
     SPACE(21.00) SKIP(0.00)
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.04 SCROLLABLE 
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
         TITLE              = "Loading Unloading"
         HEIGHT             = 26.54
         WIDTH              = 144.14
         MAX-HEIGHT         = 26.54
         MAX-WIDTH          = 144.14
         VIRTUAL-HEIGHT     = 26.54
         VIRTUAL-WIDTH      = 144.14
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
   FRAME-NAME Size-to-Fit                                               */
/* BROWSE-TAB brw 1 DEFAULT-FRAME */
ASSIGN 
       FRAME DEFAULT-FRAME:SCROLLABLE       = FALSE.

/* SETTINGS FOR BUTTON btnAddItem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnBegin IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnCancelTable IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnDeleteItem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnModifyItem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnSave IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnSaveTable IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbName IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbVeh IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBillP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBSC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBSP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filCasePrice IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filExcessShortP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filKg IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filLastWorkingDay IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filLDC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filLDP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filPerCase IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filRDC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filRDP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filRecipt# IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filStockP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filTolLDC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filTolLDP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filTolRDP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filULC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filULP IN FRAME DEFAULT-FRAME
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
     _START_FREEFORM
OPEN QUERY brw FOR EACH tt-ldunld.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brw */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 4.77
       COLUMN          = 9
       HEIGHT          = .81
       WIDTH           = 27
       WIDGET-ID       = 232
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {20DD1B9E-87C4-11D1-8BE3-0000F8754DA1} type: DTPicker */
      CtrlFrame:MOVE-AFTER(cmbVeh:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Loading Unloading */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Loading Unloading */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brw
&Scoped-define SELF-NAME brw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brw C-Win
ON VALUE-CHANGED OF brw IN FRAME DEFAULT-FRAME /* Loading Unloading */
DO: 
  IF AVAILABLE tt-ldunld THEN


  filRecipt#   = ID.
  cmbVeh       = vehNo. 
  cmbName      = STRING(itmID). 
  itms.itmName = tt-ldunld.itmName. 
  filKg        = Weight. 
  filUnitPrice = PriceP. 
  filLDC       = LDC. 
  filLDP       = LDP. 
  filULP       = ULP. 
  filULC       = ULC. 
  IF filTolRDP < filBillP THEN
            filExcessShortP = Excess .
  ELSE
            filExcessShortP = Short .
DISPLAY filRecipt#  
        cmbVeh      
        cmbName     
        itms.itmName
        filKg       
        filUnitPrice
        filLDC      
    filLDP     
        filULC   
    filULP   
    filExcessShortP WITH FRAME {&FRAME-NAME}.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAddItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAddItem C-Win
ON CHOOSE OF btnAddItem IN FRAME DEFAULT-FRAME /* Add Item */
DO:
  ENABLE cmbName btnCancel btnSave cmbName filLDC filLDP filULC filULP WITH FRAME {&FRAME-NAME}.
  DISABLE btnAddItem btnDeleteItem btnModifyItem WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAddTable
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAddTable C-Win
ON CHOOSE OF btnAddTable IN FRAME DEFAULT-FRAME /* Add Table */
DO:
  calendr:ENABLED = TRUE.
  ENABLE btnBegin cmbVeh WITH FRAME {&FRAME-NAME}.
  DISABLE btnAddTable btnDeleteTable btnModifyTable WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnBegin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnBegin C-Win
ON CHOOSE OF btnBegin IN FRAME DEFAULT-FRAME /* Begin */
DO:
    IF cmbVeh = 0 THEN
    DO:
        MESSAGE "Select Vehical first." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
        RETURN.
    END.
    IF calendr:VALUE > TODAY THEN
    DO:
        MESSAGE "Date cannot be a future date." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
        RETURN.
    END.
        

    ENABLE btnBegin btnAddItem btnDeleteItem btnModifyItem btnCancelTable btnSaveTable WITH FRAME {&FRAME-NAME}.
    DISABLE btnAddTable btnDeleteTable btnModifyTable WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancel C-Win
ON CHOOSE OF btnCancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
  DISABLE cmbName btnCancel btnSave cmbName filLDC filLDP filULC filULP WITH FRAME {&FRAME-NAME}.
  ENABLE btnAddItem btnDeleteItem btnModifyItem WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancelTable
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancelTable C-Win
ON CHOOSE OF btnCancelTable IN FRAME DEFAULT-FRAME /* Cancel Table */
DO:
  DISABLE btnAddItem btnDeleteItem btnModifyItem btnCancelTable btnSaveTable WITH FRAME {&FRAME-NAME}.
  ENABLE btnAddTable btnDeleteTable btnModifyTable WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDeleteItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDeleteItem C-Win
ON CHOOSE OF btnDeleteItem IN FRAME DEFAULT-FRAME /* Delete Item */
DO:
  ENABLE cmbName btnCancel btnSave cmbName filLDC filLDP filULC filULP WITH FRAME {&FRAME-NAME}.
  DISABLE btnAddItem btnDeleteItem btnModifyItem WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnModifyItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnModifyItem C-Win
ON CHOOSE OF btnModifyItem IN FRAME DEFAULT-FRAME /* Modify Item */
DO:
  ENABLE cmbName btnCancel btnSave cmbName filLDC filLDP filULC filULP WITH FRAME {&FRAME-NAME}.
  DISABLE btnAddItem btnDeleteItem btnModifyItem WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnModifyTable
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnModifyTable C-Win
ON CHOOSE OF btnModifyTable IN FRAME DEFAULT-FRAME /* Modify Table */
DO:
  ENABLE btnAddItem btnDeleteItem btnModifyItem btnCancelTable btnSaveTable WITH FRAME {&FRAME-NAME}.
  DISABLE btnAddTable btnDeleteTable btnModifyTable WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSave C-Win
ON CHOOSE OF btnSave IN FRAME DEFAULT-FRAME /* Save */
DO:

  FIND FIRST paramtrs WHERE NAME = "lastLDunLDID".
    IF AVAILABLE paramtrs THEN
      FIND FIRST itms WHERE itms.itmID = int(cmbName).
        IF AVAILABLE itms THEN

          CREATE tt-ldunld.
                    ID      = INT(paramtrs.val) + 1.
                    vehNo   = cmbVeh.
          tt-ldunld.itmID   = int(cmbName).
          tt-ldunld.itmName = itms.itmName.
                    Weight  = filKg.
                    PriceP  = filUnitPrice.
          tt-ldunld.BSC     = filBSP.
          tt-ldunld.BSP     = filBSC.
                    LDC     = filLDC.
                    LDP     = filLDP.
                    ULC     = filULC.
                    ULP     = filULP.
                    RDC     = filRDC.
                    RDP     = filRDP.
         IF filTolRDP < filBillP THEN
                    Excess  = filExcessShortP.
         ELSE
                    Short   = filExcessShortP.
                    Amount  = filUnitPrice * filBillP.


  OPEN QUERY brw FOR EACH tt-ldunld.

  DISABLE cmbName btnCancel btnSave cmbName filLDC filLDP filULC filULP WITH FRAME {&FRAME-NAME}.
  ENABLE btnAddItem btnDeleteItem btnModifyItem WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSaveTable
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSaveTable C-Win
ON CHOOSE OF btnSaveTable IN FRAME DEFAULT-FRAME /* Save Table */
DO:
  DISABLE btnAddItem btnDeleteItem btnModifyItem btnCancelTable btnSaveTable WITH FRAME {&FRAME-NAME}.
  ENABLE btnAddTable btnDeleteTable btnModifyTable WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnViewOld
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnViewOld C-Win
ON CHOOSE OF btnViewOld IN FRAME DEFAULT-FRAME /* View Old */
DO:
  calendr:ENABLED = TRUE.
  ENABLE cmbVeh WITH FRAME {&FRAME-NAME}.
/*   DISABLE btnAddTable btnDeleteTable btnModifyTable WITH FRAME {&FRAME-NAME}. */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbName C-Win
ON VALUE-CHANGED OF cmbName IN FRAME DEFAULT-FRAME /* Name */
DO:
  DEFINE VARIABLE BilP AS INTEGER     NO-UNDO.
  DEFINE VARIABLE Bil_Date AS DATE     NO-UNDO.
  Bil_Date = calendr:VALUE.

  ASSIGN {&SELF-NAME}.

  FIND FIRST itms WHERE itmID = INT(cmbName) NO-ERROR.
  IF AVAILABLE itms THEN
  DO:
    filKg        = unitWeightKG.
    filUnitPrice = unitPriceS.
    filCasePrice = casePriceS.
    filPerCase   = unitsPerCase.
    filStockP    = stockP + (stockC * filPerCase).
    filBSP       = BSP.
    filBSC       = BSC.
  END.
  ELSE IF NOT AVAILABLE itms THEN 
  DO:
    filKg = 0.
    filUnitPrice = 0.
  END.
  RELEASE itms.

  FOR EACH bills WHERE bilDate = Bil_Date .
    FOR EACH recipts WHERE item# = INT({&SELF-NAME}) AND recipts.bill# = bills.bill# .
        BilP = BilP + (pieses + (cases * filPerCase)).
    END.
  END.

  filBillP     = BilP.
  RUN autoCal.

  DISPLAY filPerCase filStockP filKg filUnitPrice filCasePrice filBSP filBSC filBillP WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbVeh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbVeh C-Win
ON VALUE-CHANGED OF cmbVeh IN FRAME DEFAULT-FRAME /* Vehical */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBillP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBillP C-Win
ON LEAVE OF filBillP IN FRAME DEFAULT-FRAME /* Billed P */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBSC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBSC C-Win
ON LEAVE OF filBSC IN FRAME DEFAULT-FRAME /* BSC */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBSP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBSP C-Win
ON LEAVE OF filBSP IN FRAME DEFAULT-FRAME /* BSP */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
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


&Scoped-define SELF-NAME filExcessShortP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filExcessShortP C-Win
ON LEAVE OF filExcessShortP IN FRAME DEFAULT-FRAME /* Variance */
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
  RUN autoCal.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filLDC C-Win
ON VALUE-CHANGED OF filLDC IN FRAME DEFAULT-FRAME /* LDC */
DO:
  ASSIGN {&SELF-NAME}.
  RUN autoCal.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filLDP C-Win
ON VALUE-CHANGED OF filLDP IN FRAME DEFAULT-FRAME /* LDP */
DO:
  ASSIGN {&SELF-NAME}.
  RUN autoCal.
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


&Scoped-define SELF-NAME filRDC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filRDC C-Win
ON LEAVE OF filRDC IN FRAME DEFAULT-FRAME /* RDC */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filRDP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filRDP C-Win
ON LEAVE OF filRDP IN FRAME DEFAULT-FRAME /* RDP */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
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


&Scoped-define SELF-NAME filTolLDC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filTolLDC C-Win
ON LEAVE OF filTolLDC IN FRAME DEFAULT-FRAME /* Tol LDC */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filTolLDP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filTolLDP C-Win
ON LEAVE OF filTolLDP IN FRAME DEFAULT-FRAME /* Tol LDP */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filTolRDP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filTolRDP C-Win
ON LEAVE OF filTolRDP IN FRAME DEFAULT-FRAME /* Tol RDP */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filULC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filULC C-Win
ON LEAVE OF filULC IN FRAME DEFAULT-FRAME /* ULC */
DO:
    ASSIGN {&SELF-NAME}.
  RUN autoCal.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filULC C-Win
ON VALUE-CHANGED OF filULC IN FRAME DEFAULT-FRAME /* ULC */
DO:
  ASSIGN {&SELF-NAME}.
  RUN autoCal.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filULP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filULP C-Win
ON LEAVE OF filULP IN FRAME DEFAULT-FRAME /* ULP */
DO:
    ASSIGN {&SELF-NAME}.
  RUN autoCal.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filULP C-Win
ON VALUE-CHANGED OF filULP IN FRAME DEFAULT-FRAME /* ULP */
DO:
  ASSIGN {&SELF-NAME}.
  RUN autoCal.
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

  calendr = chCtrlFrame:DTPicker.
  calendr:ENABLED = FALSE.
  calendr:VALUE = TODAY - 1.

  RUN vehLoader.
  RUN itemLoader.
  RUN LastWrkDate.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE autoCal C-Win 
PROCEDURE autoCal :
filTolLDP = filBSP + filLDP.
filTolLDC = filBSC + filLDC.

filRDP = filTolLDP - filULP.
filRDC = filTolLDC - filULC.

filTolRDP = filRDP + (filRDC * filPerCase).

RUN ExcessShort.

DISPLAY filTolLDP filTolLDC filRDP filRDC filTolRDP WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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

OCXFile = SEARCH( "LDunLD.wrx":U ).
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
ELSE MESSAGE "LDunLD.wrx":U SKIP(1)
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
  DISPLAY cmbVeh filLastWorkingDay filRecipt# cmbName filKg filPerCase 
          filUnitPrice filCasePrice filStockP filBSP filBSC filLDP filLDC 
          filTolLDP filTolLDC filULP filULC filRDP filRDC filTolRDP filBillP 
          filExcessShortP 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE brw btnAddTable btnModifyTable btnDeleteTable btnViewOld 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ExcessShort C-Win 
PROCEDURE ExcessShort :
filExcessShortP:LABEL IN FRAME {&FRAME-NAME} = "Varience".
filExcessShortP = 0.
filExcessShortP :BGCOLOR IN FRAME {&FRAME-NAME}= 15 .

IF filTolRDP < filBillP THEN
DO:
    filExcessShortP:LABEL = "Excess P".
    filExcessShortP:BGCOLOR IN FRAME {&FRAME-NAME} = 2 .
    filExcessShortP = filBillP - filTolRDP.
END.
IF filTolRDP > filBillP THEN
DO:
    filExcessShortP:LABEL = "Short P".
    filExcessShortP:BGCOLOR IN FRAME {&FRAME-NAME} = 12 .
    filExcessShortP = filTolRDP - filBillP.
END.

DISPLAY filExcessShortP WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE itemLoader C-Win 
PROCEDURE itemLoader :
FOR EACH itms BY itms.itmName.
    cmbName:ADD-LAST(itms.itmName + " - " + STRING(unitWeightKG,">>9.999") + " kg",STRING(itmID)) IN FRAME DEFAULT-FRAME.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE LastWrkDate C-Win 
PROCEDURE LastWrkDate :
FIND FIRST paramtrs WHERE paramtrs.NAME = "lastWorkingDay".
    filLastWorkingDay = DATE(paramtrs.val).
RELEASE paramtrs.

DISPLAY filLastWorkingDay WITH FRAME {&FRAME-NAME}.

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

