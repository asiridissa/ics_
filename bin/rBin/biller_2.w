&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          ics              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */
DEFINE SHARED VARIABLE session_Window AS INT.
/* Parameters Definitions ---                                           */
DEFINE VARIABLE calendr AS COM-HANDLE   NO-UNDO.
/* Local Variable Definitions ---                                       */
DEFINE VARIABLE addModify AS CHARACTER   NO-UNDO.
DEFINE VARIABLE addModifyBill AS CHARACTER   NO-UNDO.
DEFINE VARIABLE tempReciptID AS INTEGER     NO-UNDO.
DEFINE VARIABLE tempTotal AS DECIMAL     NO-UNDO.

DEFINE VARIABLE billsStockP     AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE billsStockC     AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE billgoodReturnC AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE billgoodreturnP AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE billdamageC     AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE billdamP        AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE billexpC        AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE billexpP        AS INTEGER NO-UNDO INIT 0.

DEFINE TEMP-TABLE tt-sale
FIELDS  reciptID        AS INT
FIELDS  bill#           AS INT
FIELDS  item#           AS INT
FIELDS  itmName         AS CHAR LABEL "Item"
FIELDS  weight          AS DEC LABEL "Weight"
FIELDS  cases           AS INT LABEL "Cas"
FIELDS  pieses          AS INT LABEL "Pcs"
FIELDS  goodReturnC     AS INT LABEL "GdC"
FIELDS  goodreturnP     AS INT LABEL "GdP"
FIELDS  damageC         AS INT LABEL "DmC"
FIELDS  damP            AS INT LABEL "DmP"
FIELDS  expC            AS INT LABEL "ExC"
FIELDS  expP            AS INT LABEL "ExP"
FIELDS  amount          AS DEC LABEL "Amount"
FIELDS  ItmDiscount     AS DEC LABEL "Disc."
FIELDS  valu            AS DEC LABEL "Value".

DEFINE TEMP-TABLE tt-store LIKE itms.

DEFINE VARIABLE excludeAmount AS DECIMAL     NO-UNDO.
DEFINE VARIABLE returnC AS DECIMAL     NO-UNDO.
DEFINE VARIABLE returnP AS DECIMAL     NO-UNDO.
DEFINE VARIABLE DiscountValue AS DECIMAL     NO-UNDO.

DEFINE VARIABLE tempCusName AS CHAR     NO-UNDO.

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
&Scoped-define INTERNAL-TABLES tt-sale bills area customer vehical

/* Definitions for BROWSE brw                                           */
&Scoped-define FIELDS-IN-QUERY-brw /* reciptID */ /* tt-sale.bill# */ /* item# */ itmName weight cases pieses goodReturnC goodreturnP damageC damP expC expP ItmDiscount amount   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brw   
&Scoped-define SELF-NAME brw
&Scoped-define QUERY-STRING-brw FOR EACH tt-sale
&Scoped-define OPEN-QUERY-brw OPEN QUERY brw FOR EACH tt-sale.
&Scoped-define TABLES-IN-QUERY-brw tt-sale
&Scoped-define FIRST-TABLE-IN-QUERY-brw tt-sale


/* Definitions for BROWSE brwBill                                       */
&Scoped-define FIELDS-IN-QUERY-brwBill bills.bill# bills.bilDate ~
area.areaCode customer.cusName bills.discountRate bills.tol ~
bills.tol - bills.paidAmount bills.paidAmount 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brwBill 
&Scoped-define QUERY-STRING-brwBill FOR EACH bills NO-LOCK, ~
      EACH area WHERE area.ID = bills.areaCode NO-LOCK, ~
      EACH customer WHERE customer.cusID = bills.cusID NO-LOCK, ~
      EACH vehical WHERE vehical.ID = bills.vehNo NO-LOCK
&Scoped-define OPEN-QUERY-brwBill OPEN QUERY brwBill FOR EACH bills NO-LOCK, ~
      EACH area WHERE area.ID = bills.areaCode NO-LOCK, ~
      EACH customer WHERE customer.cusID = bills.cusID NO-LOCK, ~
      EACH vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brwBill bills area customer vehical
&Scoped-define FIRST-TABLE-IN-QUERY-brwBill bills
&Scoped-define SECOND-TABLE-IN-QUERY-brwBill area
&Scoped-define THIRD-TABLE-IN-QUERY-brwBill customer
&Scoped-define FOURTH-TABLE-IN-QUERY-brwBill vehical


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brw}~
    ~{&OPEN-QUERY-brwBill}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btnNewBill cmbSearchCol cmbSearchTime ~
btnModBill btnDelBill brwBill btnSearch filSearch cmbSearchArea RECT-11 ~
RECT-12 RECT-13 RECT-14 
&Scoped-Define DISPLAYED-OBJECTS cmbArea cmbCus cmbVeh cmbEmp ~
filDiscountRate filPaid cmbName filPieses filCases filGoodP filGoodC ~
filDamP filDamC filExpP filExpC filDiscountRateItem filBill# cmbSearchCol ~
cmbSearchTime filTotal filDiscountedTotal filDiscountedAmount filAmount ~
filSearch filRecipt# filKg filUnitPrice filCasePrice cmbSearchArea 

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
DEFINE BUTTON btnAdd 
     LABEL "New Item >" 
     SIZE 14 BY 1.

DEFINE BUTTON btnCancel 
     LABEL "Cancel >" 
     SIZE 14 BY 1.

DEFINE BUTTON btnCancelBill 
     LABEL "Canel" 
     SIZE 14 BY 1.

DEFINE BUTTON btnDel 
     LABEL "Delete Item >" 
     SIZE 14 BY 1.

DEFINE BUTTON btnDelBill 
     LABEL "Delete Bill" 
     SIZE 14 BY 1.

DEFINE BUTTON btnMod 
     LABEL "Modify Item >" 
     SIZE 14 BY 1.

DEFINE BUTTON btnModBill 
     LABEL "Modify Bill" 
     SIZE 14 BY 1.

DEFINE BUTTON btnNewBill 
     LABEL "New Bill" 
     SIZE 14 BY 1.

DEFINE BUTTON btnSave 
     LABEL "Save to List >" 
     SIZE 14 BY 1.

DEFINE BUTTON btnSaveBill 
     LABEL "Save Bill" 
     SIZE 14 BY 1.

DEFINE BUTTON btnSearch 
     LABEL "Search" 
     SIZE 8 BY 1.

DEFINE VARIABLE cmbArea AS INTEGER FORMAT ">>>>9":U INITIAL 0 
     LABEL "Area" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "--Select Here--",0
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE cmbCus AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     LABEL "Customer" 
     VIEW-AS COMBO-BOX INNER-LINES 25
     LIST-ITEM-PAIRS "--Select Here--",0
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE cmbEmp AS INTEGER FORMAT ">>>>>9":U INITIAL 0 
     LABEL "Employee" 
     VIEW-AS COMBO-BOX INNER-LINES 25
     LIST-ITEM-PAIRS "--Select Here--",0
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE cmbName AS CHARACTER FORMAT "X(32)":U INITIAL "0" 
     LABEL "Name" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "--Select Here--","0"
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE cmbSearchArea AS INTEGER FORMAT ">>9":U INITIAL 0 
     LABEL "Area" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "All",0
     DROP-DOWN-LIST
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE cmbSearchCol AS CHARACTER FORMAT "X(20)":U INITIAL "Customer" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "Customer","Bill No" 
     DROP-DOWN-LIST
     SIZE 12 BY 1 NO-UNDO.

DEFINE VARIABLE cmbSearchTime AS INTEGER FORMAT ">>>,>>9":U INITIAL 3 
     LABEL "Within Last" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "All Time",0,
                     "1 Month",1,
                     "2 Months",2,
                     "3 Months",3,
                     "6 Months",6,
                     "1 Year",12,
                     "2 Years",24,
                     "3 Years",36,
                     "4 Years",48,
                     "5 Years",72
     DROP-DOWN-LIST
     SIZE 12.14 BY 1 NO-UNDO.

DEFINE VARIABLE cmbVeh AS INTEGER FORMAT ">>>>9":U INITIAL 0 
     LABEL "Vehical" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "--Select Here--",0
     DROP-DOWN-LIST
     SIZE 35 BY 1 NO-UNDO.

DEFINE VARIABLE filAmount AS DECIMAL FORMAT ">,>>>,>>9.99 Rs":U INITIAL 0 
     LABEL "Value" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filBill# AS INTEGER FORMAT ">>>>>>>>>>9":U INITIAL 0 
     LABEL "Bill No" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filCasePrice AS DECIMAL FORMAT ">,>>>,>>9.99 Rs":U INITIAL 0 
     LABEL "C Price" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filCases AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Cases" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filDamC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Dam C" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filDamP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Dam P" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filDiscountedAmount AS DECIMAL FORMAT ">,>>>,>>9.99 Rs":U INITIAL 0 
     LABEL "Amount" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 0 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE filDiscountedTotal AS DECIMAL FORMAT ">,>>>,>>9.99 Rs":U INITIAL 0 
     LABEL "Total" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 0 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE filDiscountRate AS DECIMAL FORMAT ">9.99 %":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filDiscountRateItem AS DECIMAL FORMAT ">9.99 %":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filExpC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Exp C" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filExpP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Exp P" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filGoodC AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Gd Rtrn C" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filGoodP AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Gd Rtrn P" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filKg AS DECIMAL FORMAT ">>9.999 kg":U INITIAL 0 
     LABEL "Weight" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filPaid AS DECIMAL FORMAT ">,>>>,>>9.99 Rs":U INITIAL 0 
     LABEL "Paid" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filPieses AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Pieses" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE filRecipt# AS INTEGER FORMAT ">,>>>,>>>,>>>9":U INITIAL 0 
     LABEL "ID" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filSearch AS CHARACTER FORMAT "X(256)":U 
     LABEL "Search" 
     VIEW-AS FILL-IN 
     SIZE 32.57 BY .88 NO-UNDO.

DEFINE VARIABLE filTotal AS DECIMAL FORMAT ">,>>>,>>9.99 Rs":U INITIAL 0 
     LABEL "Value" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE VARIABLE filUnitPrice AS DECIMAL FORMAT ">,>>>,>>9.99 Rs":U INITIAL 0 
     LABEL "P Price" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .88
     BGCOLOR 7 FGCOLOR 11  NO-UNDO.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 45.57 BY 2.42.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 45.57 BY 8.81.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 45.57 BY 14.81.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 6.73.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brw FOR 
      tt-sale SCROLLING.

DEFINE QUERY brwBill FOR 
      bills, 
      area, 
      customer, 
      vehical SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brw C-Win _FREEFORM
  QUERY brw DISPLAY
      /*       reciptID */
/*  tt-sale.bill# */
/*  item#         */
 itmName FORMAT "x(45)":u    
 weight  FORMAT ">>9.999"    
 cases   FORMAT ">>9"   
 pieses  FORMAT ">>9"    
 goodReturnC FORMAT ">>9"
 goodreturnP FORMAT ">>9"
 damageC     FORMAT ">>9"
 damP        FORMAT ">>9"
 expC        FORMAT ">>9"
 expP        FORMAT ">>9"
 ItmDiscount FORMAT ">9.99"
 amount
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS NO-TAB-STOP SIZE 97.86 BY 14.81
         FONT 10
         TITLE "Item List" ROW-HEIGHT-CHARS .65 FIT-LAST-COLUMN.

DEFINE BROWSE brwBill
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brwBill C-Win _STRUCTURED
  QUERY brwBill NO-LOCK DISPLAY
      bills.bill# FORMAT "9999999999":U
      bills.bilDate COLUMN-LABEL "      Date" FORMAT "99/99/9999":U
            WIDTH 9
      area.areaCode COLUMN-LABEL " Area" FORMAT "x(8)":U WIDTH 4
      customer.cusName COLUMN-LABEL "                                Customer" FORMAT "X(50)":U
            WIDTH 35
      bills.discountRate COLUMN-LABEL "Dis %" FORMAT ">9.99":U
            WIDTH 6
      bills.tol COLUMN-LABEL "Total" FORMAT ">>>>>>>>>9.99":U WIDTH 15
      bills.tol - bills.paidAmount COLUMN-LABEL "        Credits" FORMAT ">>>,>>>,>>9.99":U
            WIDTH 15 COLUMN-FGCOLOR 12 COLUMN-BGCOLOR 15 LABEL-FGCOLOR 4
      bills.paidAmount COLUMN-LABEL "Paid" FORMAT ">>>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS NO-TAB-STOP SIZE 97.86 BY 10.19
         FONT 10
         TITLE "Bills" ROW-HEIGHT-CHARS .65 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     cmbArea AT ROW 5.58 COL 8.86 COLON-ALIGNED WIDGET-ID 80
     cmbCus AT ROW 6.58 COL 8.86 COLON-ALIGNED WIDGET-ID 92
     cmbVeh AT ROW 7.58 COL 8.86 COLON-ALIGNED WIDGET-ID 84
     cmbEmp AT ROW 8.58 COL 8.86 COLON-ALIGNED WIDGET-ID 82
     filDiscountRate AT ROW 10.23 COL 31.57 COLON-ALIGNED NO-LABEL WIDGET-ID 118
     filPaid AT ROW 11.31 COL 9 COLON-ALIGNED WIDGET-ID 142 NO-TAB-STOP 
     btnAdd AT ROW 17.85 COL 43.43 RIGHT-ALIGNED WIDGET-ID 42
     cmbName AT ROW 15.62 COL 9 COLON-ALIGNED WIDGET-ID 54
     filPieses AT ROW 19.38 COL 9 COLON-ALIGNED WIDGET-ID 32
     btnNewBill AT ROW 1.27 COL 2 WIDGET-ID 94 NO-TAB-STOP 
     filCases AT ROW 20.38 COL 9 COLON-ALIGNED WIDGET-ID 30
     filGoodP AT ROW 21.38 COL 9 COLON-ALIGNED WIDGET-ID 28
     filGoodC AT ROW 22.35 COL 9 COLON-ALIGNED WIDGET-ID 26
     filDamP AT ROW 23.31 COL 9 COLON-ALIGNED WIDGET-ID 38
     filDamC AT ROW 24.27 COL 9 COLON-ALIGNED WIDGET-ID 10
     filExpP AT ROW 25.27 COL 9 COLON-ALIGNED WIDGET-ID 40
     filExpC AT ROW 26.19 COL 9 COLON-ALIGNED WIDGET-ID 36
     filDiscountRateItem AT ROW 13.5 COL 32 COLON-ALIGNED NO-LABEL WIDGET-ID 122
     btnSave AT ROW 21.81 COL 30.43 WIDGET-ID 52
     filBill# AT ROW 3.73 COL 8.86 COLON-ALIGNED WIDGET-ID 2 NO-TAB-STOP 
     cmbSearchCol AT ROW 1.15 COL 86.14 COLON-ALIGNED NO-LABEL WIDGET-ID 136 NO-TAB-STOP 
     cmbSearchTime AT ROW 1.15 COL 121.72 COLON-ALIGNED WIDGET-ID 130 NO-TAB-STOP 
     btnModBill AT ROW 1.27 COL 16.29 WIDGET-ID 96 NO-TAB-STOP 
     btnDelBill AT ROW 1.27 COL 30.57 WIDGET-ID 98 NO-TAB-STOP 
     brwBill AT ROW 2.19 COL 47.57 WIDGET-ID 300
     btnSaveBill AT ROW 2.35 COL 9.14 WIDGET-ID 102 NO-TAB-STOP 
     btnSearch AT ROW 1.08 COL 136.43 WIDGET-ID 134 NO-TAB-STOP 
     filTotal AT ROW 9.54 COL 8.86 COLON-ALIGNED WIDGET-ID 56 NO-TAB-STOP 
     filDiscountedTotal AT ROW 10.42 COL 8.86 COLON-ALIGNED WIDGET-ID 120 NO-TAB-STOP 
     btnCancel AT ROW 22.96 COL 30.43 WIDGET-ID 66 NO-TAB-STOP 
     btnDel AT ROW 20.23 COL 30.43 WIDGET-ID 48 NO-TAB-STOP 
     btnMod AT ROW 19 COL 30.43 WIDGET-ID 50 NO-TAB-STOP 
     filDiscountedAmount AT ROW 12.85 COL 9 COLON-ALIGNED WIDGET-ID 124 NO-TAB-STOP 
     brw AT ROW 12.46 COL 47.57 WIDGET-ID 200
     btnCancelBill AT ROW 2.35 COL 23.43 WIDGET-ID 154 NO-TAB-STOP 
     filAmount AT ROW 13.77 COL 9 COLON-ALIGNED WIDGET-ID 34 NO-TAB-STOP 
     filSearch AT ROW 1.15 COL 52.43 COLON-ALIGNED WIDGET-ID 126 NO-TAB-STOP 
     filRecipt# AT ROW 14.69 COL 9 COLON-ALIGNED WIDGET-ID 4 NO-TAB-STOP 
     filKg AT ROW 16.62 COL 9 COLON-ALIGNED WIDGET-ID 8 NO-TAB-STOP 
     filUnitPrice AT ROW 17.54 COL 9 COLON-ALIGNED WIDGET-ID 58 NO-TAB-STOP 
     filCasePrice AT ROW 18.46 COL 9 COLON-ALIGNED WIDGET-ID 64 NO-TAB-STOP 
     cmbSearchArea AT ROW 1.15 COL 103.43 COLON-ALIGNED WIDGET-ID 156 NO-TAB-STOP 
     "Discount for Item" VIEW-AS TEXT
          SIZE 14 BY .58 AT ROW 12.85 COL 31.57 WIDGET-ID 152
     "Discount for Total" VIEW-AS TEXT
          SIZE 15 BY .58 AT ROW 9.62 COL 30.72 WIDGET-ID 148
     "Date:" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 4.73 COL 6 WIDGET-ID 90
     RECT-11 AT ROW 1.12 COL 1.43 WIDGET-ID 138
     RECT-12 AT ROW 3.62 COL 1.43 WIDGET-ID 140
     RECT-13 AT ROW 12.5 COL 1.43 WIDGET-ID 146
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 144.86 BY 26.31
         FONT 10 WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     RECT-14 AT ROW 17.58 COL 29.43 WIDGET-ID 150
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 144.86 BY 26.31
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
         TITLE              = "ICS - Bills"
         COLUMN             = 1
         ROW                = 1.23
         HEIGHT             = 26.31
         WIDTH              = 144.86
         MAX-HEIGHT         = 28.69
         MAX-WIDTH          = 146.29
         VIRTUAL-HEIGHT     = 28.69
         VIRTUAL-WIDTH      = 146.29
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("E:/ICS/img/documents_256_48.ico":U) THEN
    MESSAGE "Unable to load icon: E:/ICS/img/documents_256_48.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB brwBill btnDelBill DEFAULT-FRAME */
/* BROWSE-TAB brw filDiscountedAmount DEFAULT-FRAME */
/* SETTINGS FOR BROWSE brw IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
ASSIGN 
       bills.paidAmount:VISIBLE IN BROWSE brwBill = FALSE.

/* SETTINGS FOR BUTTON btnAdd IN FRAME DEFAULT-FRAME
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR BUTTON btnCancel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnCancelBill IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnDel IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnMod IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnSave IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btnSaveBill IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbArea IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbCus IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbEmp IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbName IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX cmbVeh IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filAmount IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filBill# IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filCasePrice IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filCases IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filDamC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filDamP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filDiscountedAmount IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filDiscountedTotal IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filDiscountRate IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filDiscountRateItem IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filExpC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filExpP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filGoodC IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filGoodP IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filKg IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filPaid IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filPieses IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filRecipt# IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN filTotal IN FRAME DEFAULT-FRAME
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
OPEN QUERY brw FOR EACH tt-sale.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brw */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brwBill
/* Query rebuild information for BROWSE brwBill
     _TblList          = "ics.bills,ics.area WHERE ics.bills ...,ics.customer WHERE ics.bills ...,ics.vehical WHERE ics.bills ..."
     _Options          = "NO-LOCK"
     _TblOptList       = ",,,"
     _JoinCode[2]      = "area.ID = bills.areaCode"
     _JoinCode[3]      = "customer.cusID = bills.cusID"
     _JoinCode[4]      = "vehical.ID = bills.vehNo"
     _FldNameList[1]   > ics.bills.bill#
"bills.bill#" ? "9999999999" "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > ics.bills.bilDate
"bills.bilDate" "      Date" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > ics.area.areaCode
"area.areaCode" " Area" ? "character" ? ? ? ? ? ? no ? no no "4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > ics.customer.cusName
"customer.cusName" "                                Customer" ? "character" ? ? ? ? ? ? no ? no no "35" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > ics.bills.discountRate
"bills.discountRate" "Dis %" ? "decimal" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > ics.bills.tol
"bills.tol" "Total" ">>>>>>>>>9.99" "decimal" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > "_<CALC>"
"bills.tol - bills.paidAmount" "        Credits" ">>>,>>>,>>9.99" ? 15 12 ? ? 4 ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > ics.bills.paidAmount
"bills.paidAmount" "Paid" ">>>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? no no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brwBill */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame-2 ASSIGN
       FRAME           = FRAME DEFAULT-FRAME:HANDLE
       ROW             = 4.69
       COLUMN          = 10.86
       HEIGHT          = .81
       WIDTH           = 23.14
       WIDGET-ID       = 72
       HIDDEN          = no
       SENSITIVE       = yes.
/* CtrlFrame-2 OCXINFO:CREATE-CONTROL from: {20DD1B9E-87C4-11D1-8BE3-0000F8754DA1} type: DTPicker */
      CtrlFrame-2:MOVE-BEFORE(cmbArea:HANDLE IN FRAME DEFAULT-FRAME).

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* ICS - Bills */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* ICS - Bills */
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


&Scoped-define BROWSE-NAME brw
&Scoped-define SELF-NAME brw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brw C-Win
ON VALUE-CHANGED OF brw IN FRAME DEFAULT-FRAME /* Item List */
DO:
    RUN itemsLoaderAll.
    IF AVAILABLE tt-sale THEN     
    DO:
        filRecipt#     =  reciptID      .   
        filBill#       =  bill#         .   
        cmbName        =  STRING(item#) .   
        filKg          =  weight        .   
        filCases       =  cases         .   
        filPieses      =  pieses        .   
        filGoodC       =  goodReturnC   .   
        filGoodP       =  goodreturnP   .   
        filDamC        =  damageC       .   
        filDamP        =  damP          .   
        filExpC        =  expC          .   
        filExpP        =  expP          .   
        filAmount      =  valu          . 
        filDiscountedAmount = amount    .
        filDiscountRateItem = ItmDiscount.
    END.

DISPLAY filRecipt#
        filBill#  
        cmbName   
        filKg     
        filCases  
        filPieses 
        filGoodC  
        filGoodP  
        filDamC   
        filDamP   
        filExpC   
        filExpP   
        filAmount
        filDiscountedAmount
        filDiscountRateItem WITH FRAME DEFAULT-FRAME.

    APPLY "VALUE-CHANGED":U TO cmbName.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brwBill
&Scoped-define SELF-NAME brwBill
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brwBill C-Win
ON VALUE-CHANGED OF brwBill IN FRAME DEFAULT-FRAME /* Bills */
DO:
    RUN cusLoaderAll.
    IF AVAILABLE bills THEN
    DO:
        ASSIGN
        cmbArea             = bills.areaCode      
        cmbCus              = bills.cusID
        cmbEmp              = bills.empCode
        cmbVeh              = bills.vehNo
        filDiscountedTotal  = bills.tol
        filDiscountRate     = bills.discountRate
        filBill#            = bills.bill#
        calendr:VALUE       = bills.bilDate
        filTotal            = bills.tol + (bills.tol * bills.discountRate)
        filPaid             = bills.paidAmount
        .

        EMPTY TEMP-TABLE tt-sale.
        FOR EACH recipts WHERE recipts.bill# = bills.bill#.
            CREATE tt-sale.
                ASSIGN
                tt-sale.reciptID        = recipts.reciptID  
                tt-sale.bill#           = recipts.bill#
                tt-sale.item#           = recipts.item#
                tt-sale.itmName         = recipts.itmName
                tt-sale.weight          = recipts.weight
                tt-sale.cases           = recipts.cases
                tt-sale.pieses          = recipts.pieses
                tt-sale.goodReturnC     = recipts.goodReturnC
                tt-sale.goodreturnP     = recipts.goodreturnP
                tt-sale.damageC         = recipts.damageC
                tt-sale.damP            = recipts.damP 
                tt-sale.expC            = recipts.expC
                tt-sale.expP            = recipts.expP
                tt-sale.amount          = recipts.amount
                tt-sale.val             = recipts.valu
                tt-sale.ItmDiscount     = recipts.ItmDiscount
                .
        END.
        
        OPEN QUERY brw FOR EACH tt-sale.
        APPLY "VALUE-CHANGED":U TO brw.
        
        DISPLAY filPaid brw filTotal cmbArea cmbCus cmbEmp cmbVeh filDiscountedTotal filDiscountRate filBill#
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE
    DO:
        MESSAGE "No records found." VIEW-AS ALERT-BOX INFO BUTTONS OK.
        DISABLE btnDelBill btnModBill WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnAdd C-Win
ON CHOOSE OF btnAdd IN FRAME DEFAULT-FRAME /* New Item > */
DO:
    IF cmbArea = 0 THEN
    DO:
      MESSAGE "Select Area First." VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN.
    END.
    IF cmbCus = 0 THEN
    DO:
      MESSAGE "Select Customer First." VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN.
    END.
    IF cmbVeh = 0 THEN
    DO:
      MESSAGE "Select Vehicle First." VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN.
    END.
    IF cmbEmp = 0 THEN
    DO:
      MESSAGE "Select Employee First." VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN.
    END.

    ENABLE btnAdd btnMod btnDel btnCancelBill WITH FRAME {&FRAME-NAME}.
/*     DISABLE cmbArea cmbCus cmbEmp cmbVeh WITH FRAME {&FRAME-NAME}. */
/*     calendr:ENABLED = FALSE.                                       */


    ASSIGN
      cmbName      = "0"
      filAmount    = 0               
      filCases     = 0
      filDamC      = 0
      filDamP      = 0
      filUnitPrice = 0
      filExpC      = 0
      filExpP      = 0
      filGoodC     = 0
      filGoodP     = 0
      filKg        = 0
      filPieses    = 0
      filRecipt#   = tempReciptID
      filCasePrice = 0
      filDiscountedTotal = 0
      filDiscountRate = 0
      filDiscountRateItem = 0
        .
  ENABLE filDiscountRateItem btnCancel btnSave cmbName filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filPieses WITH FRAME DEFAULT-FRAME . 
  calendr:ENABLED = FALSE.
  DISABLE 
      filDiscountRate cmbArea cmbCus cmbEmp cmbVeh
      brw btnAdd btnDel btnMod btnCancelBill btnSaveBill WITH FRAME DEFAULT-FRAME.

  DISPLAY filDiscountRateItem btnCancel btnSave filCasePrice cmbName
          filAmount filBill# filCases filDamC filDamP filExpC filExpP 
          filGoodC filGoodP filKg filPieses filRecipt# filTotal filUnitPrice WITH FRAME DEFAULT-FRAME.
  addModify = "add".
  RUN itemsLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancel C-Win
ON CHOOSE OF btnCancel IN FRAME DEFAULT-FRAME /* Cancel > */
DO:
    MESSAGE "Conferm to cancel." SKIP "Unsaved changes will be lost." VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO UPDATE yn AS LOGICAL.
    IF yn =YES THEN
    DO:
        ASSIGN
        cmbName      = "0"
        filAmount    = 0               
        filCases     = 0
        filDamC      = 0
        filDamP      = 0
        filUnitPrice = 0
        filExpC      = 0
        filExpP      = 0
        filGoodC     = 0
        filGoodP     = 0
        filKg        = 0
        filPieses    = 0
        filRecipt#   = tempReciptID
        filCasePrice = 0
        filDiscountedTotal = 0
        filDiscountRate = 0
        filDiscountRateItem = 0
        .
        
        
        OPEN QUERY brw FOR EACH tt-sale.
        APPLY "VALUE-CHANGED":U TO brw.
        DISABLE filDiscountRateItem filDiscountRate btnCancel btnSave cmbName filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filPieses WITH FRAME DEFAULT-FRAME . 
        ENABLE brw btnAdd btnDel btnMod btnCancelBill btnSaveBill WITH FRAME DEFAULT-FRAME.
        DISPLAY btnCancel btnSave filCasePrice cmbName filAmount filBill# filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filKg filPieses filRecipt# filTotal filUnitPrice WITH FRAME DEFAULT-FRAME.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnCancelBill
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnCancelBill C-Win
ON CHOOSE OF btnCancelBill IN FRAME DEFAULT-FRAME /* Canel */
DO:
    MESSAGE "Conferm to cancel." SKIP "Unsaved changes will be lost." VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO UPDATE yn AS LOGICAL.
    IF yn =YES THEN
        DO:
            calendr:VALUE = TODAY.
            cmbArea = 0.
            cmbCus  = 0.
            cmbEmp  = 0.
            cmbVeh  = 0.
            filBill# =0. 
            filDiscountRate = 0.
            filDiscountedTotal = 0.
            filTotal = 0.
            filPaid = 0.
        END.
       
        calendr:ENABLED = FALSE.
        DISABLE
            brw
            filPaid filDiscountRate
            cmbArea cmbCus cmbEmp cmbVeh 
            btnCancelBill btnSaveBill
            btnAdd btnDel btnMod btnCancel btnSave
             cmbName filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filPieses WITH FRAME DEFAULT-FRAME . 
        ENABLE
             brwBill
             btnDelBill btnModBill btnNewBill
             WITH FRAME DEFAULT-FRAME.
        DISPLAY filPaid filTotal btnCancel btnSave filCasePrice cmbName filAmount filBill# filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filKg filPieses filRecipt# filTotal filUnitPrice WITH FRAME DEFAULT-FRAME.

        OPEN QUERY brwItem FOR EACH tt-sale.
        OPEN QUERY brwBill FOR 
            EACH ics.bills NO-LOCK,
            EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
            EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
            EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK INDEXED-REPOSITION.
        APPLY "VALUE-CHANGED":U TO brw.
        APPLY "VALUE-CHANGED":U TO brwBill.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDel C-Win
ON CHOOSE OF btnDel IN FRAME DEFAULT-FRAME /* Delete Item > */
DO:
  IF cmbName <> "0" THEN
  DO:
      MESSAGE "Conferm to delete the record?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE yn AS LOGICAL.
      IF yn = YES THEN
      DO:
          FIND FIRST tt-sale WHERE reciptID = filRecipt# EXCLUSIVE-LOCK NO-ERROR.
          IF AVAILABLE tt-sale THEN
            DELETE tt-sale.
          ELSE
              MESSAGE "No Records to Delete." VIEW-AS ALERT-BOX ERROR BUTTONS OK .
          RELEASE tt-sale.
          OPEN QUERY brw FOR EACH tt-sale.
          APPLY "VALUE-CHANGED":U TO brw.

          IF NOT ERROR-STATUS:ERROR THEN
              MESSAGE "Record successfully deleted." VIEW-AS ALERT-BOX INFO BUTTONS OK.

          
      END.
  END.
  ELSE
      MESSAGE "No records to Delete." VIEW-AS ALERT-BOX ERROR BUTTONS OK.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnDelBill
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDelBill C-Win
ON CHOOSE OF btnDelBill IN FRAME DEFAULT-FRAME /* Delete Bill */
DO:
  MESSAGE "Conferm to delete the record?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE yn AS LOGICAL.
      IF yn = YES THEN
      DO:
        FIND FIRST bills WHERE bills.bill# = filBill# EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE bills THEN
          DELETE bills.
        RELEASE bills.
        FOR EACH recipts WHERE recipts.bill# = filBill#.
            DELETE recipts.
        END.
      END.
        
/*       EMPTY TEMP-TABLE tt-sale.            */
/*       OPEN QUERY brwItem FOR EACH tt-sale. */
      OPEN QUERY brwBill FOR 
        EACH ics.bills NO-LOCK,
        EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
        EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
        EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK INDEXED-REPOSITION.
      APPLY "VALUE-CHANGED":U TO brw.
      APPLY "VALUE-CHANGED":U TO brwBill.
      
      IF NOT ERROR-STATUS:ERROR THEN
        MESSAGE "Record Deleted Successfully." VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "Loan Management System".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnMod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnMod C-Win
ON CHOOSE OF btnMod IN FRAME DEFAULT-FRAME /* Modify Item > */
DO:
  IF cmbName <> "0" THEN
  DO:
      ENABLE filCases filDiscountRateItem filDiscountRate btnCancel btnSave /*cmbName filCases*/ filDamC filDamP filExpC filExpP filGoodC filGoodP filPieses WITH FRAME DEFAULT-FRAME . 
      DISABLE brw btnAdd btnDel btnMod btnCancelBill btnSaveBill WITH FRAME DEFAULT-FRAME.

      addModify = "modify".
  END.
  ELSE
      MESSAGE "No records to Modify." VIEW-AS ALERT-BOX ERROR BUTTONS OK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnModBill
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnModBill C-Win
ON CHOOSE OF btnModBill IN FRAME DEFAULT-FRAME /* Modify Bill */
DO:

    addModifyBill = "modify".
/*     RUN cusLoader. */
    calendr:ENABLED = TRUE.
    ENABLE
        brw
        filPaid filDiscountRate
        cmbArea cmbCus cmbEmp cmbVeh 
        btnAdd btnDel btnMod btnCancelBill btnSaveBill WITH FRAME DEFAULT-FRAME.
    DISABLE brwBill btnDelBill btnModBill btnNewBill WITH FRAME DEFAULT-FRAME.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNewBill
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNewBill C-Win
ON CHOOSE OF btnNewBill IN FRAME DEFAULT-FRAME /* New Bill */
DO:
    APPLY "VALUE-CHANGED":U TO brwBill.
    addModifyBill = "add".
    
    calendr:VALUE = TODAY - 1.
    cmbArea = 0.
    cmbCus  = 0.
    cmbEmp  = 0.
    cmbVeh  = 0.
    filBill# =0. 
    filDiscountRate = 0.
    filDiscountedTotal = 0.
    filTotal = 0.
    filPaid = 0.

    cmbName             = "0".
    filAmount           = 0  .      
    filCases            = 0  .
    filDamC             = 0  .
    filDamP             = 0  .
    filUnitPrice        = 0  .
    filExpC             = 0  .
    filExpP             = 0  .
    filGoodC            = 0  .
    filGoodP            = 0  .
    filKg               = 0  .
    filPieses           = 0  .
    filRecipt#          = 0  .
    filCasePrice        = 0  .
    filDiscountedTotal  = 0  .
    filDiscountRate     = 0  .
    filDiscountRateItem = 0  .
    filDiscountedAmount = 0  .

    FIND FIRST paramtrs WHERE NAME = "lastbill#" EXCLUSIVE-LOCK NO-ERROR.
        filBill# = INT(paramtrs.val) + 1.
    RELEASE paramtrs.

    EMPTY TEMP-TABLE tt-sale.
    OPEN QUERY brw FOR EACH tt-sale.

    ENABLE  filPaid filDiscountRate btnAdd btnMod btnDel btnSaveBill btnCancelBill cmbArea cmbCus cmbEmp cmbVeh WITH FRAME {&FRAME-NAME}.
    calendr:ENABLED = TRUE.
    
    DISABLE brwBill btnNewBill btnModBill btnDelBill WITH FRAME {&FRAME-NAME}.
    DISPLAY 
        cmbName            
        filAmount           
        filCases           
        filDamC            
        filDamP            
        filUnitPrice       
        filExpC            
        filExpP            
        filGoodC           
        filGoodP           
        filKg              
        filPieses          
        filRecipt#         
        filCasePrice       
        filDiscountedTotal 
        filDiscountRate    
        filDiscountRateItem
        filDiscountedAmount
        WITH FRAME {&FRAME-NAME}.
    DISPLAY 
        filPaid filTotal filDiscountRate filDiscountedTotal cmbArea cmbCus cmbEmp cmbVeh filBill# WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSave
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSave C-Win
ON CHOOSE OF btnSave IN FRAME DEFAULT-FRAME /* Save to List > */
DO:
  DEFINE VARIABLE itemsName AS CHARACTER NO-UNDO.
  DEFINE VARIABLE itemsW AS DEC   NO-UNDO.

  FIND FIRST itms WHERE itmID = INT(cmbName) EXCLUSIVE-LOCK NO-ERROR.
            IF AVAILABLE itms THEN
            itemsName = itms.itmName.
            itemsW    = itms.unitWeightKG.
  RELEASE itms.

  IF cmbName = "0" THEN
  DO:
      MESSAGE "Item Name cannot be a blank." VIEW-AS ALERT-BOX INFO BUTTONS OK .
      RETURN.
  END.
  IF filCases = 0 AND filPieses = 0 AND filGoodC = 0 AND filGoodP = 0 AND filDamC = 0 AND filDamP = 0 AND filExpC = 0 AND filExpP= 0 THEN
  DO:
      MESSAGE "Enter some values first." VIEW-AS ALERT-BOX INFO BUTTONS OK.
      RETURN.
  END.
  FIND FIRST tt-sale WHERE tt-sale.itmName = itemsName AND tt-sale.weight = itemsW EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE tt-sale AND addModify = "add" THEN
        DO: 
            MESSAGE "This Item already added." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
            RETURN.
        END.
  RELEASE tt-sale.
  
  /*                                                                                                               */
/*   MESSAGE "Conferm to save the record?" VIEW-AS ALERT-BOX INFO BUTTONS YES-NO UPDATE yn AS LOGICAL. */
/*   IF yn = YES THEN                                                                                  */
  DO:
        IF addModify = "add" THEN
         DO:
            CREATE tt-sale.
            ASSIGN
            reciptID        = filRecipt#
            bill#           = filBill#
            item#           = INT(cmbName)
            tt-sale.itmName = itemsName
            weight          = filKg
            cases           = filCases
            pieses          = filPieses
            goodReturnC     = filGoodC
            goodreturnP     = filGoodP
            damageC         = filDamC
            damP            = filDamP
            expC            = filExpC
            expP            = filExpP
            amount          = filDiscountedAmount
            val             = filAmount
            ItmDiscount     = filDiscountRateItem
            .
            tempReciptID = tempReciptID + 1.

            billsStockP     = billsStockP     + filPieses.
            billsStockC     = billsStockC     + filCases.
            billgoodReturnC = billgoodReturnC + filGoodC.
            billgoodreturnP = billgoodreturnP + filGoodP. 
            billdamageC     = billdamageC     + filDamC. 
            billdamP        = billdamP        + filDamP. 
            billexpC        = billexpC        + filExpC. 
            billexpP        = billexpP        + filExpP. 

        END.
        IF addModify = "modify" THEN                                                                                                                                            
         DO:
            FIND FIRST itms WHERE itmID = INT(cmbName).
            IF AVAILABLE itms THEN
                itemsName = itms.itmName.
            RELEASE itms.

            FIND FIRST tt-sale WHERE reciptID = filRecipt#.
            IF AVAILABLE tt-sale THEN
            DO:
                ASSIGN
                reciptID        = filRecipt#
                bill#           = filBill#
                item#           = INT(cmbName)
                tt-sale.itmName = itemsName
                weight          = filKg
                cases           = filCases
                pieses          = filPieses
                goodReturnC     = filGoodC
                goodreturnP     = filGoodP
                damageC         = filDamC
                damP            = filDamP
                expC            = filExpC
                expP            = filExpP
                amount          = filAmount
                val             = filAmount
                ItmDiscount     = filDiscountRateItem
                .
            END.
        END.                                                                                                                                                                     
                                                                                       
        tempTotal = 0.
        FOR EACH tt-sale.
           tempTotal = tempTotal + tt-sale.amount.
        END.
        filTotal = tempTotal.
        filDiscountedTotal = filTotal - ((filTotal * filDiscountRate) / 100). 
        APPLY "VALUE-CHANGED":U TO filDiscountRate.

        DISABLE  filDiscountRateItem btnCancel btnSave cmbName filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filPieses WITH FRAME DEFAULT-FRAME . 
        ENABLE brw btnAdd btnDel btnMod btnCancelBill btnSaveBill WITH FRAME DEFAULT-FRAME.
        DISPLAY filDiscountedTotal filDiscountRateItem filDiscountedTotal btnCancel btnSave filCasePrice cmbName filAmount filBill# filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filKg filPieses filRecipt# filTotal filUnitPrice WITH FRAME DEFAULT-FRAME.

        OPEN QUERY brw FOR EACH tt-sale.
        APPLY "VALUE-CHANGED":U TO brw.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSaveBill
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSaveBill C-Win
ON CHOOSE OF btnSaveBill IN FRAME DEFAULT-FRAME /* Save Bill */
DO:
    IF (DATE(calendr:VALUE) - TODAY) > 0 THEN
    DO:
        MESSAGE "Incorrect Date." SKIP "You cannot Bill for a future Date." VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Inventry Control Syatem".
        RETURN.
    END.
    IF cmbArea = 0 THEN
    DO:
        MESSAGE "Select Area first" VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Inventry Control Syatem".
        RETURN.
    END.
    IF cmbCus = 0 THEN
    DO:
        MESSAGE "Select Customer first" VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Inventry Control Syatem".
        RETURN.
    END.
    IF cmbVeh = 0 THEN
    DO:
        MESSAGE "Select Vehical first" VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Inventry Control Syatem".
        RETURN.
    END.
    IF cmbEmp = 0 THEN
    DO:
        MESSAGE "Select Employee first" VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Inventry Control Syatem".
        RETURN.
    END.
    IF filDiscountedTotal = 0 THEN
    DO:
        MESSAGE "Enter Items First" VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Inventry Control Syatem".
        RETURN.
    END.
    
  MESSAGE "Conferm to save the record?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE yn AS LOGICAL.
  IF yn = YES THEN
  DO:
      FIND FIRST customer WHERE cusID = cmbCus.
        IF AVAILABLE customer THEN
        DO:
            tempCusName = customer.cusName.
        END.
/*   ----------Add--------------- */
        IF addModifyBill = "add" THEN
        DO:
            CREATE bills .
                bill#        = filBill#           .
                areaCode     = cmbArea            .
                bilDate      = DATE(calendr:VALUE).
          bills.cusID        = cmbCus             .
                empCode      = cmbEmp             .
                tol          = filDiscountedTotal .
                vehNo        = cmbVeh             .
                discountRate = filDiscountRate    .
                paidAmount   = filPaid           .
          bills.cusName      = tempCusName.
        
            FIND FIRST paramtrs WHERE NAME = "lastbill#" EXCLUSIVE-LOCK NO-ERROR.
                paramtrs.val = STRING(filBill#).
            RELEASE paramtrs.
        
            FOR EACH tt-sale.
                FIND FIRST itms WHERE itms.itmID = tt-sale.item#.
                    itms.stockC = (itms.stockC - billsStockC) + billgoodreturnC.
                    itms.stockP = (itms.stockP - billsStockP) + billgoodreturnP.
                RELEASE itms.

                CREATE recipts.
                    recipts.amount      = tt-sale.amount       .
                    recipts.bill#       = tt-sale.bill#        .
                    recipts.cases       = tt-sale.cases        .
                    recipts.damageC     = tt-sale.damageC      .
                    recipts.damP        = tt-sale.damP         .
                    recipts.expC        = tt-sale.expC         .
                    recipts.expP        = tt-sale.expP         .
                    recipts.goodReturnC = tt-sale.goodReturnC  .
                    recipts.goodreturnP = tt-sale.goodreturnP  .
                    recipts.item#       = tt-sale.item#        .
                    recipts.itmName     = tt-sale.itmName      .
                    recipts.pieses      = tt-sale.pieses       .
                    recipts.reciptID    = tt-sale.reciptID     .
                    recipts.weight      = tt-sale.weight       .
                    recipts.valu        = tt-sale.valu         .
                    recipts.ItmDiscount = tt-sale.ItmDiscount  .
            END.
        
            FIND FIRST paramtrs WHERE NAME = "transaction#".
            DO:
                paramtrs.val = STRING(tempReciptID - 1).
            END.
        END.
/* --------------modify----------------------- */
        IF addModifyBill = "modify" THEN
        DO:
            FIND FIRST bills WHERE bills.bill# = filBill#.
            IF AVAILABLE bills THEN
            DO:
                ASSIGN
                bills.bill#        = filBill#           
                      areaCode     = cmbArea            
                      bilDate      = DATE(calendr:VALUE)
                bills.cusID        = cmbCus             
                      empCode      = cmbEmp             
                      tol          = filDiscountedTotal 
                      vehNo        = cmbVeh             
                      discountRate = filDiscountRate    
                      paidAmount   = filPaid           
                bills.cusName      = tempCusName.
            END.

            FOR EACH recipts WHERE recipts.bill# = filBill#.
                DELETE recipts.
            END.
        
            FOR EACH tt-sale.
                CREATE recipts.
                    recipts.amount      = tt-sale.amount       .
                    recipts.bill#       = tt-sale.bill#        .
                    recipts.cases       = tt-sale.cases        .
                    recipts.damageC     = tt-sale.damageC      .
                    recipts.damP        = tt-sale.damP         .
                    recipts.expC        = tt-sale.expC         .
                    recipts.expP        = tt-sale.expP         .
                    recipts.goodReturnC = tt-sale.goodReturnC  .
                    recipts.goodreturnP = tt-sale.goodreturnP  .
                    recipts.item#       = tt-sale.item#        .
                    recipts.itmName     = tt-sale.itmName      .
                    recipts.pieses      = tt-sale.pieses       .
                    recipts.reciptID    = tt-sale.reciptID     .
                    recipts.weight      = tt-sale.weight       .
                    recipts.valu        = tt-sale.valu         .
                    recipts.ItmDiscount = tt-sale.ItmDiscount.
            END.
        END.

        calendr:ENABLED = FALSE.
        DISABLE 
            brw
            filDiscountRate
            cmbArea cmbCus cmbEmp cmbVeh 
            btnCancelBill btnSaveBill
            btnAdd btnDel btnMod btnCancel btnSave
             cmbName filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filPieses WITH FRAME DEFAULT-FRAME . 
        ENABLE 
             brwBill
             btnDelBill btnModBill btnNewBill
             WITH FRAME DEFAULT-FRAME.
        DISPLAY filDiscountRateItem btnCancel btnSave filCasePrice cmbName filAmount filBill# filCases filDamC filDamP filExpC filExpP filGoodC filGoodP filKg filPieses filRecipt# filTotal filUnitPrice WITH FRAME DEFAULT-FRAME.

        EMPTY TEMP-TABLE tt-sale.
        OPEN QUERY brw FOR EACH tt-sale.
        APPLY "VALUE-CHANGED":U TO brw.

        OPEN QUERY brwBill FOR 
            EACH ics.bills NO-LOCK,
            EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
            EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
            EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK INDEXED-REPOSITION.
        
        APPLY "VALUE-CHANGED":U TO brwBill.

        IF NOT ERROR-STATUS:ERROR THEN MESSAGE "Record successfully created." VIEW-AS ALERT-BOX INFO BUTTONS OK.
        IF ERROR-STATUS:ERROR THEN MESSAGE "Record saved with some errors." SKIP ERROR-STATUS VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSearch C-Win
ON CHOOSE OF btnSearch IN FRAME DEFAULT-FRAME /* Search */
DO:
    RUN finderBills.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbArea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbArea C-Win
ON VALUE-CHANGED OF cmbArea IN FRAME DEFAULT-FRAME /* Area */
DO:
  ASSIGN {&SELF-NAME}.
  RUN cusLoader.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbCus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbCus C-Win
ON ENTRY OF cmbCus IN FRAME DEFAULT-FRAME /* Customer */
DO:
/*   ASSIGN cmbArea. */
/*   ASSIGN cmbCus.  */
/*   RUN cusLoader.  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbCus C-Win
ON VALUE-CHANGED OF cmbCus IN FRAME DEFAULT-FRAME /* Customer */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbEmp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbEmp C-Win
ON VALUE-CHANGED OF cmbEmp IN FRAME DEFAULT-FRAME /* Employee */
DO:
  ASSIGN {&SELF-NAME}.
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
    filKg = unitWeightKG.
    filUnitPrice = unitPriceS.
    filCasePrice = casePriceS.
    
  END.
  ELSE IF NOT AVAILABLE itms THEN 
  DO:
    filKg = 0.
    filUnitPrice = 0.
  END.
  RELEASE itms.
  DISPLAY filKg filUnitPrice filCasePrice WITH FRAME {&FRAME-NAME}. 
  RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbSearchArea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbSearchArea C-Win
ON VALUE-CHANGED OF cmbSearchArea IN FRAME DEFAULT-FRAME /* Area */
DO:
  ASSIGN {&SELF-NAME}.
  RUN finderBills.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbSearchCol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbSearchCol C-Win
ON VALUE-CHANGED OF cmbSearchCol IN FRAME DEFAULT-FRAME
DO:
  ASSIGN {&SELF-NAME}.
  IF {&SELF-NAME} = "Bill No" THEN DISABLE cmbSearchTime cmbSearchArea WITH FRAME {&FRAME-NAME}.
  IF {&SELF-NAME} <> "Bill No" THEN ENABLE cmbSearchTime cmbSearchArea WITH FRAME {&FRAME-NAME}.
  RUN finderBills.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmbSearchTime
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmbSearchTime C-Win
ON VALUE-CHANGED OF cmbSearchTime IN FRAME DEFAULT-FRAME /* Within Last */
DO:
    ASSIGN {&SELF-NAME}.
    RUN finderBills.
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


&Scoped-define SELF-NAME CtrlFrame-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame-2 C-Win OCX.Click
PROCEDURE CtrlFrame-2.DTPicker.Click .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/

calendr:VALUE = STRING(TODAY,"99/99/9999").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filAmount
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filAmount C-Win
ON LEAVE OF filAmount IN FRAME DEFAULT-FRAME /* Value */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filAmount C-Win
ON VALUE-CHANGED OF filAmount IN FRAME DEFAULT-FRAME /* Value */
DO:
  ASSIGN {&SELF-NAME}.
  APPLY "VALUE-CHANGED":U TO filDiscountRateItem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filBill#
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBill# C-Win
ON LEAVE OF filBill# IN FRAME DEFAULT-FRAME /* Bill No */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filBill# C-Win
ON VALUE-CHANGED OF filBill# IN FRAME DEFAULT-FRAME /* Bill No */
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


&Scoped-define SELF-NAME filCases
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filCases C-Win
ON LEAVE OF filCases IN FRAME DEFAULT-FRAME /* Cases */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filDamC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDamC C-Win
ON LEAVE OF filDamC IN FRAME DEFAULT-FRAME /* Dam C */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filDamP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDamP C-Win
ON LEAVE OF filDamP IN FRAME DEFAULT-FRAME /* Dam P */
DO:
  ASSIGN {&SELF-NAME}.
  RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filDiscountedAmount
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDiscountedAmount C-Win
ON LEAVE OF filDiscountedAmount IN FRAME DEFAULT-FRAME /* Amount */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filDiscountedTotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDiscountedTotal C-Win
ON LEAVE OF filDiscountedTotal IN FRAME DEFAULT-FRAME /* Total */
DO:
    ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filDiscountRate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDiscountRate C-Win
ON LEAVE OF filDiscountRate IN FRAME DEFAULT-FRAME
DO:
  ASSIGN {&SELF-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDiscountRate C-Win
ON VALUE-CHANGED OF filDiscountRate IN FRAME DEFAULT-FRAME
DO:
   ASSIGN {&SELF-NAME}.
   filDiscountedTotal = filTotal - ((filTotal * filDiscountRate) / 100).  
   DISPLAY filDiscountedTotal WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filDiscountRateItem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDiscountRateItem C-Win
ON LEAVE OF filDiscountRateItem IN FRAME DEFAULT-FRAME
DO:
   ASSIGN {&SELF-NAME}.
    RUN calAmount.
    
    IF filDiscountedAmount > filAmount THEN
    DO:
        MESSAGE "No Discount For this Item." SKIP 
            "Limit exceded." SKIP "(Amount = " + STRING(filDiscountedAmount,">,>>>,>>>,>>9.99") + " Rs.)" 
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
        filDiscountedAmount = filAmount.
    END.
   DISPLAY filDiscountedAmount WITH FRAME {&FRAME-NAME}.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filDiscountRateItem C-Win
ON VALUE-CHANGED OF filDiscountRateItem IN FRAME DEFAULT-FRAME
DO:
  ASSIGN {&SELF-NAME}.
   filDiscountedAmount = filAmount - ((filAmount * filDiscountRateItem) / 100).  
   DISPLAY filDiscountedAmount WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filExpC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filExpC C-Win
ON LEAVE OF filExpC IN FRAME DEFAULT-FRAME /* Exp C */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filExpP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filExpP C-Win
ON LEAVE OF filExpP IN FRAME DEFAULT-FRAME /* Exp P */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filGoodC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filGoodC C-Win
ON LEAVE OF filGoodC IN FRAME DEFAULT-FRAME /* Gd Rtrn C */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filGoodP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filGoodP C-Win
ON LEAVE OF filGoodP IN FRAME DEFAULT-FRAME /* Gd Rtrn P */
DO:
    ASSIGN {&SELF-NAME}.
    RUN calAmount.
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


&Scoped-define SELF-NAME filPaid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filPaid C-Win
ON LEAVE OF filPaid IN FRAME DEFAULT-FRAME /* Paid */
DO:
    ASSIGN {&SELF-NAME}.
    IF {&SELF-NAME} > filDiscountedTotal THEN
    DO:
        MESSAGE "Paid amount is over Total." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
        RETURN.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filPieses
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filPieses C-Win
ON LEAVE OF filPieses IN FRAME DEFAULT-FRAME /* Pieses */
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


&Scoped-define SELF-NAME filSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filSearch C-Win
ON LEAVE OF filSearch IN FRAME DEFAULT-FRAME /* Search */
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filSearch C-Win
ON VALUE-CHANGED OF filSearch IN FRAME DEFAULT-FRAME /* Search */
DO:
  ASSIGN {&SELF-NAME}.
  RUN finderBills.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filTotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filTotal C-Win
ON LEAVE OF filTotal IN FRAME DEFAULT-FRAME /* Value */
DO:
  ASSIGN {&SELF-NAME}.
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

  session_Window = session_Window + 1.

  calendr = chCtrlFrame-2:DTPicker.
  calendr:ENABLED = FALSE.

  RUN getTbl.
  RUN getItems.
  RUN areaLoader.
  RUN empLoader.
/*   RUN cusLoader. */
  RUN cusLoaderAll.
  RUN vehLoader.
  RUN areaCodeLoader.

  APPLY "VALUE-CHANGED":U TO brwBill.

  FIND FIRST paramtrs WHERE NAME = "transaction#".
  DO:
    tempReciptID = INT(paramtrs.val) + 1.
  END.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE areaCodeLoader C-Win 
PROCEDURE areaCodeLoader :
FOR EACH area BY area.ID.
  cmbSearchArea:ADD-LAST(area.areaCode,area.ID) IN FRAME {&FRAME-NAME}.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE areaLoader C-Win 
PROCEDURE areaLoader :
FOR EACH area BY area.ID.
    cmbArea:ADD-LAST(areaCode + " - " + descrip,ID) IN FRAME DEFAULT-FRAME.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calAmount C-Win 
PROCEDURE calAmount :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
filAmount = ( filUnitPrice * filPieses ) + ( filCasePrice * filCases ).
returnC = filGoodC + filDamC + filExpC.
returnP = filGoodP + filDamP + filExpP.
excludeAmount = ((returnP) * filUnitPrice) + (returnC * filCasePrice).
DiscountValue = (((filAmount - excludeAmount) * filDiscountRateItem) / 100).

filDiscountedAmount = filAmount - DiscountValue.

IF filDiscountedAmount > filAmount THEN
DO:
    MESSAGE "No Discount For this Item." SKIP 
        "Limit exceded." SKIP "(Amount = " + STRING(filDiscountedAmount,">,>>>,>>>,>>9.99") + " Rs.)" 
        VIEW-AS ALERT-BOX WARNING BUTTONS OK.
    filDiscountedAmount = filAmount.
END.
DISPLAY filAmount filDiscountedAmount WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calendr C-Win 
PROCEDURE calendr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
calendr = chCtrlFrame-2:DTPicker.

MESSAGE 
    calendr:FONT
    VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "Loan Management System".

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

OCXFile = SEARCH( "biller.wrx":U ).
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
ELSE MESSAGE "biller.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cusLoader C-Win 
PROCEDURE cusLoader :
DEFINE VARIABLE areaCod AS CHARACTER     NO-UNDO.
DEFINE VARIABLE cmbList AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cnt     AS INTEGER     NO-UNDO.

DISPLAY WITH FRAME DEFAULT-FRAME.

cmbCus = 0.

IF cmbArea = 0 THEN
DO:
    MESSAGE "Select an Area first." VIEW-AS ALERT-BOX INFO BUTTONS OK.
    cmbCus:LIST-ITEM-PAIRS = "--Select Here--,0".
END.
ELSE
DO:
    FIND FIRST area WHERE ID = cmbArea EXCLUSIVE-LOCK NO-ERROR.
    areaCod = area.descrip.
    
    cmbCus:LIST-ITEM-PAIRS = "--Select Here--,0".
    
    FOR EACH customer WHERE CusArea = areaCod BY cusName.
        cmbCus:ADD-LAST(cusName,cusID) NO-ERROR.
        cnt = cnt + 1.
    END.
    IF cnt = 0 THEN
        MESSAGE "No Customers for this Area." VIEW-AS ALERT-BOX WARNING BUTTONS OK.
END.

DISPLAY cmbCus WITH FRAME DEFAULT-FRAME.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cusLoaderAll C-Win 
PROCEDURE cusLoaderAll :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DISPLAY WITH FRAME DEFAULT-FRAME.

cmbCus:LIST-ITEM-PAIRS = "--Select Here--,0" NO-ERROR. 
    
    FOR EACH customer BY cusName.
        cmbCus:ADD-LAST(cusName,cusID) NO-ERROR.
    END.

DISPLAY cmbCus WITH FRAME DEFAULT-FRAME.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE empLoader C-Win 
PROCEDURE empLoader :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH emp BY emp.name.
    cmbEmp:ADD-LAST(emp.NAME,emp#) IN FRAME {&FRAME-NAME}.
END.

DISPLAY cmbEmp WITH FRAME {&FRAME-NAME}.
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
  DISPLAY cmbArea cmbCus cmbVeh cmbEmp filDiscountRate filPaid cmbName filPieses 
          filCases filGoodP filGoodC filDamP filDamC filExpP filExpC 
          filDiscountRateItem filBill# cmbSearchCol cmbSearchTime filTotal 
          filDiscountedTotal filDiscountedAmount filAmount filSearch filRecipt# 
          filKg filUnitPrice filCasePrice cmbSearchArea 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btnNewBill cmbSearchCol cmbSearchTime btnModBill btnDelBill brwBill 
         btnSearch filSearch cmbSearchArea RECT-11 RECT-12 RECT-13 RECT-14 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE finderBills C-Win 
PROCEDURE finderBills :
IF cmbSearchCol = "Bill No" AND cmbSearchArea <> 0 THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills WHERE bills.bill# = int(filSearch) AND bills.areaCode = cmbSearchArea NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.
IF cmbSearchCol = "Bill No" AND cmbSearchArea = 0 THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills WHERE bills.bill# = int(filSearch) NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.
IF cmbSearchCol = "Customer" AND cmbSearchArea <> 0 AND cmbSearchTime <> 0 THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills WHERE bills.cusName BEGINS filSearch AND bills.bilDate >= (TODAY - (cmbSearchTime * 30)) AND bills.areaCode = cmbSearchArea NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.
IF cmbSearchCol = "Customer" AND cmbSearchArea = 0 AND cmbSearchTime <> 0 THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills WHERE bills.cusName BEGINS filSearch AND bills.bilDate >= (TODAY - (cmbSearchTime * 30)) NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.
IF cmbSearchCol = "Customer" AND cmbSearchArea <> 0 AND cmbSearchTime = 0 THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills WHERE bills.cusName BEGINS filSearch AND bills.areaCode = cmbSearchArea NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.
IF cmbSearchCol = "Customer" AND cmbSearchArea = 0 AND cmbSearchTime = 0 THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills WHERE bills.cusName BEGINS filSearch NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.

IF filSearch = "" AND cmbSearchArea <> 0  THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode AND bills.areaCode = cmbSearchArea NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.
IF filSearch = "" AND cmbSearchArea = 0  THEN
DO:
    OPEN QUERY brwBill FOR
    EACH ics.bills NO-LOCK,
    EACH ics.area WHERE area.ID = bills.areaCode NO-LOCK,
    EACH ics.customer WHERE customer.cusID = bills.cusID NO-LOCK,
    EACH ics.vehical WHERE vehical.ID = bills.vehNo NO-LOCK.
END.


bills.bill#:SORT-ASCENDING IN BROWSE brwBill = TRUE.

APPLY "VALUE-CHANGED":U TO brw IN FRAME {&FRAME-NAME}.
APPLY "VALUE-CHANGED":U TO brwBill.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getItems C-Win 
PROCEDURE getItems :
FOR EACH itms BY itms.itmName.
    cmbName:ADD-LAST(itms.itmName + " - " + STRING(unitWeightKG,">>9.999") + " kg",STRING(itmID)) IN FRAME DEFAULT-FRAME.
END.

DISPLAY cmbName WITH FRAME DEFAULT-FRAME.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getStock C-Win 
PROCEDURE getStock :
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE getTbl C-Win 
PROCEDURE getTbl :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST recipts NO-ERROR.
IF AVAILABLE recipts THEN
DO:
    CREATE tt-sale.
    ASSIGN
        tt-sale.reciptID     = recipts.reciptID    
        tt-sale.bill#        = recipts.bill#      
        tt-sale.item#        = recipts.item#      
        tt-sale.itmName      = recipts.itmName    
        tt-sale.weight       = recipts.weight     
        tt-sale.cases        = recipts.cases      
        tt-sale.pieses       = recipts.pieses     
        tt-sale.goodReturnC  = recipts.goodReturnC
        tt-sale.goodreturnP  = recipts.goodreturnP
        tt-sale.damageC      = recipts.damageC    
        tt-sale.damP         = recipts.damP       
        tt-sale.expC         = recipts.expC       
        tt-sale.expP         = recipts.expP       
        tt-sale.amount       = recipts.amount  
        .
END.
/* ELSE                                                               */
/*     MESSAGE "No records found." VIEW-AS ALERT-BOX INFO BUTTONS OK. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE itemsLoader C-Win 
PROCEDURE itemsLoader :
DISPLAY WITH FRAME DEFAULT-FRAME.
cmbName:LIST-ITEM-PAIRS = "--Select Here--,0" NO-ERROR. 
FOR EACH itms BY itms.itmName.
    FIND FIRST tt-sale WHERE tt-sale.itmName = itms.itmName AND tt-sale.weight = unitWeightKG NO-ERROR.
    IF NOT AVAILABLE tt-sale THEN
    cmbName:ADD-LAST(itms.itmName + " - " + STRING(unitWeightKG,">>9.999") + " kg",STRING(itmID)) IN FRAME DEFAULT-FRAME.
    RELEASE tt-sale.
END.
DISPLAY cmbName WITH FRAME {&FRAME-NAME}.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE itemsLoaderAll C-Win 
PROCEDURE itemsLoaderAll :
DISPLAY WITH FRAME DEFAULT-FRAME.
cmbName:LIST-ITEM-PAIRS = "--Select Here--,0" NO-ERROR. 
FOR EACH itms.
    cmbName:ADD-LAST(itms.itmName + " - " + STRING(unitWeightKG,">>9.999") + " kg",STRING(itmID)) IN FRAME DEFAULT-FRAME.
END.
DISPLAY cmbName WITH FRAME {&FRAME-NAME}.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE vehLoader C-Win 
PROCEDURE vehLoader :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH vehical BY veh#.
    cmbVeh:ADD-LAST(veh# + " - " + descrip,ID) IN FRAME DEFAULT-FRAME.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

