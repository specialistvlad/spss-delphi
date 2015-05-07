unit SPSSDIO;

interface

uses
  spssdiocodes;

const
{$IFDEF WIN32}
  DLLName = 'spssio32.dll';
{$ENDIF}
{$IFDEF WIN64}
  DLLName = 'spssio64.dll';
{$ENDIF}

  { For describing one multiple response set }
type
  /// <summary>
  /// Pointer type to the Multiple response record
  /// </summary>
  PSpssMultRespDef = ^TSpssMultRespDef;
{$EXTERNALSYM spssMultRespDef_T}

  /// <summary>
  /// Multiple response record
  /// </summary>
  /// <remarks>
  /// For describing one multiple response set
  /// </remarks>
  spssMultRespDef_T = record
    /// <summary>
    /// Null-terminated MR set name
    /// </summary>
    szMrSetName: Array [0 .. SPSS_MAX_VARNAME] of AnsiChar;
    /// <summary>
    /// Null-terminated set label
    /// </summary>
    szMrSetLabel: Array [0 .. SPSS_MAX_VARLABEL] of AnsiChar;
    /// <summary>
    /// Whether a multiple dichotomy set
    /// </summary>
    qIsDichotomy: Integer;
    /// <summary>
    /// Whether the counted value is numeric
    /// </summary>
    qIsNumeric: Integer;
    /// <summary>
    /// Whether to use var category labels
    /// </summary>
    qUseCategoryLabels: Integer;
    /// <summary>
    /// Whether using var label as set label
    /// </summary>
    qUseFirstVarLabel: Integer;
    /// <summary>
    /// Reserved for expansion
    /// </summary>
    Reserved: Array [0 .. 13] of Integer;
    /// <summary>
    /// Counted value if numeric
    /// </summary>
    nCountedValue: LongInt;
    /// <summary>
    /// Null-terminated counted value if string
    /// </summary>
    pszCountedValue: PAnsiChar;
    /// <summary>
    /// Vector of null-terminated var names
    /// </summary>
    ppszVarNames: PPAnsiChar;
    /// <summary>
    /// Number of constituent variables
    /// </summary>
    nVariables: Integer;
  end;
{$EXTERNALSYM spssMultRespDef}

  spssMultRespDef = spssMultRespDef_T;
  /// <summary>
  /// Type of Multiple response record
  /// </summary>
  TSpssMultRespDef = spssMultRespDef_T; { spssMultRespDef_T }

  { API FUNCTIONS IN ALPHABETIC ORDER }

{$EXTERNALSYM spssAddFileAttribute}
  /// <summary>
  /// This function adds a single datafile attribute. If the attribute already
  /// exists, it is replaced. The attribute name and its subscript are
  /// specified separately. The subscript is unit origin. If the attribute is
  /// not subscripted, the subscript must be specified as -1.
  /// </summary>
  /// <param name="hFile">
  /// Handle to the data file
  /// </param>
  /// <param name="attribName">
  /// Name of the attribute. Not case sensitive
  /// </param>
  /// <param name="attribSub">
  /// Unit origin subscript or -1
  /// </param>
  /// <param name="attribText">
  /// Text which used as the attribute's value
  /// </param>
  /// <returns>
  /// One of the following codes. Success is indicated by zero (SPSS_OK),
  /// errors by positive values, and warnings, if any, by negative values.
  /// </returns>
function spssAddFileAttribute(hFile: Integer; attribName: PAnsiChar;
  attribSub: Integer; attribText: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssAddMultRespDefC}
///	<summary>
///	  This function adds a multiple-response set definition over short string
///	  variables to the dictionary.
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="mrSetName">
///	  Name of the multiple response set. A null-terminated string up to 64
///	  bytes long that begins with a dollar sign and obeys the rules for a valid
///	  variable name. Case is immaterial.
///	</param>
///	<param name="mrSetLabel">
///	  Label for the multiple response set. A null-terminated string up to 256
///	  bytes long. May be NULLor the empty string to indicate that no label is
///	  desired.
///	</param>
///	<param name="isDichotomy">
///	  Nonzero if the variables in the set are coded as dichotomies, zero
///	  otherwise.
///	</param>
///	<param name="countedValue">
///	  A null-terminated string containing the counted value. Necessary when
///	  isDichotomy is nonzero, in which case it must be 1–8 characters long, and
///	  ignored otherwise. May beNULLif isDichotomy is zero.
///	</param>
///	<param name="varNames">
///	  Array of null-terminated strings containing the names of the variables in
///	  the set. All variables in the list must be short strings. Case is
///	  immaterial.
///	</param>
///	<param name="numVars">
///	  Number of variables in the list (in varNames). Must be at least two.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssAddMultRespDefC(hFile: Integer; mrSetName: PAnsiChar;
  mrSetLabel: PAnsiChar; isDichotomy: Integer; countedValue: PAnsiChar;
  var varNames: PAnsiChar; numVars: Integer): Integer; stdcall;

{$EXTERNALSYM spssAddMultRespDefExt}
///	<summary>
///	  This function adds one multiple response set to the dictionary. The set
///	  is described in a struct which is defined in spssdio.h
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="pSet">
///	  Pointer to the struct defining the set.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssAddMultRespDefExt(hFile: Integer; var pSet: spssMultRespDef)
  : Integer; stdcall;

{$EXTERNALSYM spssAddMultRespDefN}
///	<summary>
///	  This function adds a multiple-response set definition over numeric
///	  variables to the dictionary
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="mrSetName">
///	  Name of the multiple response set. A null-terminated string up to 64
///	  bytes that begins with a dollar sign and obeys the rules for a valid
///	  variable name. Case is immaterial.
///	</param>
///	<param name="mrSetLabel">
///	  Label for the multiple response set. A null-terminated string up to 256
///	  bytes long. May be NULLor the empty string to indicate no label is
///	  desired.
///	</param>
///	<param name="isDichotomy">
///	  Nonzero if the variables in the set are coded as dichotomies, zero
///	  otherwise.
///	</param>
///	<param name="countedValue">
///	  The counted value. Necessary when isDichotomy is nonzero and ignored
///	  otherwise. Note that the value is specified as a long int, not a double.
///	</param>
///	<param name="varNames">
///	  Array of null-terminated strings containing the names of the variables in
///	  the set. All variables in the list must be numeric. Case is immaterial.
///	</param>
///	<param name="numVars">
///	  Number of variables in the list (in varNames). Must be at least two.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssAddMultRespDefN(hFile: Integer; mrSetName: PAnsiChar;
  mrSetLabel: PAnsiChar; isDichotomy: Integer; countedValue: LongInt;
  var varNames: PAnsiChar; numVars: Integer): Integer; stdcall;

{$EXTERNALSYM spssAddVarAttribute}
///	<summary>
///	  This function is analogous to spssAddFileAttribute, but it operates on a
///	  single variable's set of attributes. If the named attribute does not
///	  already exist, it is added to the set of attributes. If it does exist,
///	  the existing definition is replaced. If the attribute is not subscripted,
///	  the unit origin subscript is specified as –1
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Name of the variable. Not case sensitive.
///	</param>
///	<param name="attribName">
///	  Name of the attribute. Not case sensitive.
///	</param>
///	<param name="attribSub">
///	  Unit origin attribute or –1.
///	</param>
///	<param name="attribText">
///	  Text which used as the attribute's value.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssAddVarAttribute(hFile: Integer; varName: PAnsiChar;
  attribName: PAnsiChar; attribSub: Integer; attribText: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssCloseAppend}
/// <summary>
/// This function closes the data file associated with handle, which must have been opened for appending cases using spssOpenAppend. The file handle handle becomes invalid and no further operations can be performed using it
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssCloseAppend(hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssCloseRead}
/// <summary>
/// This function closes the data file associated withhandle, which must have
/// been opened for reading using spssOpenRead. The file handle handlebecomes
/// invalid and no further operations can be performed using it
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values
/// </returns>
function spssCloseRead(hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssCloseWrite}
/// <summary>
/// This function closes the data file associated withhandle, which must have
/// been opened for writing using spssOpenWrite. The file handle
/// handlebecomes invalid and no further operations can be performed using it
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values
/// </returns>
function spssCloseWrite(hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssCommitCaseRecord}
/// <summary>
/// This function writes a case to the data file specified by thehandle. It
/// must be called after setting the values of variables
/// throughspssSetValueNumericandspssSetValueChar. Any variables left unset
/// will get the system-missing value if they are numeric and all blanks if
/// they are strings. Unless spssCommitCaseRecordis called, the case will not
/// be written out
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values
/// </returns>
function spssCommitCaseRecord(hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssCommitHeader}
/// <summary>
/// This function writes the data dictionary to the data file associated
/// withhandle. Before any case data can be written, the dictionary must be
/// committed; once the dictionary has been committed, no further changes can
/// be made to it
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssCommitHeader(hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssConvertDate}
///	<summary>
///	  This function converts a Gregorian date expressed as day-month-year to
///	  the internal date format. The time portion of the date variable is set to
///	  0:00. To set the time portion of the date variable to another value, use
///	  spssConvertTime and add the resulting value to *spssDate. Dates before
///	  October 15, 1582, are considered invalid
///	</summary>
///	<param name="day">
///	  Day of month (1–31)
///	</param>
///	<param name="month">
///	  Month (1–12)
///	</param>
///	<param name="year">
///	  Year in full (94 means 94 A.D.)
///	</param>
///	<param name="spssDate">
///	  Pointer to date in internal format
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssConvertDate(day: Integer; month: Integer; year: Integer;
  var spssDate: Double): Integer; stdcall;

{$EXTERNALSYM spssConvertSPSSDate}
///	<summary>
///	  This function converts the date (as distinct from time) portion of a
///	  value in internal date format to Gregorian style
///	</summary>
///	<param name="day">
///	  Pointer to day of month value
///	</param>
///	<param name="month">
///	  Pointer to month value
///	</param>
///	<param name="year">
///	  Pointer to year value
///	</param>
///	<param name="spssDate">
///	  Date in internal format
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssConvertSPSSDate(var day, month, year: Integer; spssDate: Double)
  : Integer; stdcall;

{$EXTERNALSYM spssConvertSPSSTime}
///	<summary>
///	  This function breaks a value in internal date format into a day number
///	  (since October 14, 1582) plus the hour, minute, and second values. Note
///	  that the seconds value is stored in a double since it may have a
///	  fractional part
///	</summary>
///	<param name="day">
///	  Pointer to day count value (note that the value is long)
///	</param>
///	<param name="hourh">
///	  Pointer to hour of day
///	</param>
///	<param name="minute">
///	  Pointer to minute of the hour
///	</param>
///	<param name="second">
///	  Pointer to second of the minute
///	</param>
///	<param name="spssDate">
///	  Date in internal format
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssConvertSPSSTime(var day: LongInt; var hourh, minute: Integer;
  var second: Double; spssDate: Double): Integer; stdcall;

{$EXTERNALSYM spssConvertTime}
///	<summary>
///	  This function converts a time given as day, hours, minutes, and seconds
///	  to the internal format. The day value is the number of days since October
///	  14, 1582, and is typically zero, especially when this function is used in
///	  conjunction with spssConvertDate. Note that the seconds value is stored
///	  in a double since it may have a fractional part
///	</summary>
///	<param name="day">
///	  Day (non-negative; note that the value is long)
///	</param>
///	<param name="hour">
///	  Hour (0–23)
///	</param>
///	<param name="minute">
///	  Minute (0–59)
///	</param>
///	<param name="second">
///	  Seconds (non-negative and less than 60)
///	</param>
///	<param name="spssTime">
///	  Pointer to time in internal format
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssConvertTime(day: LongInt; hour: Integer; minute: Integer;
  second: Double; var spssTime: Double): Integer; stdcall;

{$EXTERNALSYM spssCopyDocuments}
///	<summary>
///	  This function copies stored documents, if any, from the file associated
///	  with fromHandle to that associated with toHandle. The latter must be open
///	  for output. If the target file already has documents, they are discarded.
///	  If the source file has no documents, the target will be set to have none,
///	  too
///	</summary>
///	<param name="fromHandle">
///	  Handle to the file documents are to be copied from.
///	</param>
///	<param name="toHandle">
///	  Handle to the file documents are to be copied to. Must be open for output.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssCopyDocuments(fromHandle: Integer; toHandle: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssFreeAttributes}
///	<summary>
///	  This function frees the memory dynamically allocated by either
///	  spssGetFileAttributes or spssGetVarAttributes
///	</summary>
///	<param name="attribNames">
///	  Pointer to the vector of attribute names
///	</param>
///	<param name="attribText">
///	  Pointer to the vector of text values
///	</param>
///	<param name="nAttributes">
///	  The number of elements in each vector
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssFreeAttributes(var attribNames: PAnsiChar;
  var attribText: PAnsiChar; nAttributes: Integer): Integer; stdcall;

{$EXTERNALSYM spssFreeDateVariables}
///	<summary>
///	  This function is called to return the memory allocated by
///	  spssGetDateVariables
///	</summary>
///	<param name="dateInfo">
///	  Vector of date variable indexes
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssFreeDateVariables(var dateInfo: LongInt): Integer; stdcall;

{$EXTERNALSYM spssFreeMultRespDefs}
///	<summary>
///	  This function releases the memory which was acquired by
///	  spssGetMultRespDefs. mrespDefs. ASCII string containing the definitions
///	</summary>
///	<param name="mrespDefs">
///	  ASCII string containing the definitions
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssFreeMultRespDefs(var mrespDefs: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssFreeMultRespDefStruct}
/// <summary>
/// This function releases the memory acquired by spssGetMultRespDefByIndex. It has a single parameter, a pointer to the allocated struct
/// </summary>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssFreeMultRespDefStruct(var pSet: spssMultRespDef): Integer; stdcall;

{$EXTERNALSYM spssFreeVarCValueLabels}
///	<summary>
///	  This function frees the two arrays and the value and label strings
///	  allocated on the heap by spssGetVarCValueLabels
///	</summary>
///	<param name="values">
///	  Array of pointers to values returned by spssGetVarCValueLabels
///	</param>
///	<param name="labels">
///	  Array of pointers to labels returned by spssGetVarCValueLabels
///	</param>
///	<param name="numLabels">
///	  Number of values or labels returned by spssGetVarCValueLabels
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssFreeVarCValueLabels(var values: PAnsiChar; var labels: PAnsiChar;
  numLabels: Integer): Integer; stdcall;

{$EXTERNALSYM spssFreeVariableSets}
///	<summary>
///	  This function is called to return the memory allocated by
///	  spssGetVariableSets. varSets. The string defining the variable sets
///	</summary>
///	<param name="varSets">
///	  The string defining the variable sets
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssFreeVariableSets(var varSets: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssFreeVarNames}
/// <summary>
/// This function frees the two arrays and the name strings allocated on the
/// heap byspssGetVarNames
/// </summary>
/// <param name="varNames">
/// Array of pointers to names returned by spssGetVarNames
/// </param>
/// <param name="varTypes">
/// Array of variable types returned by spssGetVarNames
/// </param>
/// <param name="numVars">
/// Number of variables returned by spssGetVarNames
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// SPSS_OK. No error SPSS_CANNOT_FREE. Unable to free because arguments are
/// illegal or inconsistent (for example, negative numVars)
/// </returns>
function spssFreeVarNames(varNames: PPAnsiChar; varTypes: PInteger;
  numVars: Integer): Integer; stdcall;

{$EXTERNALSYM spssFreeVarNValueLabels}
/// <summary>
/// This function frees the two arrays and the label strings allocated on the heap by spssGetVarNValueLabels
/// </summary>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssFreeVarNValueLabels(var values: Double; var labels: PAnsiChar;
  numLabels: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetCaseSize}
///	<summary>
///	  This function reports the size of a raw case record for the file
///	  associated withhandle. The case size is reported in bytes and is meant to
///	  be used in conjunction with the low-level case input/output procedures
///	  spssWholeCaseInandspssWholeCaseOut
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="caseSize">
///	  Pointer to size of case in bytes
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetCaseSize(hFile: Integer; var caseSize: LongInt)
  : Integer; stdcall;

{$EXTERNALSYM spssGetCaseWeightVar}
/// <summary>
/// This function reports the name of the case weight variable. The name is
/// copied to the buffer pointed to byvarNameas a null-terminated string.
/// Since a variable name can be up to 64 bytes in length, the size of the
/// buffer must be at least 65
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varName">
/// Pointer to the buffer to hold name of the case weight variable
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetCaseWeightVar(hFile: Integer; var varName: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetCompression}
///	<summary>
///	  This function reports the compression attribute of a data file
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="compSwitch">
///	  Pointer to compression attribute. Upon return, *compSwitchis 1 if the
///	  file is compressed with standard compression, 2 if compressed in ZSAV
///	  format, and 0 otherwise.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetCompression(hFile: Integer; var compSwitch: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetDateVariables}
///	<summary>
///	  This function reports the Forecasting (Trends) date variable information,
///	  if any, in IBM SPSS Statistics data files. It places the information in a
///	  dynamically allocated long array, sets *numofElements to the number of
///	  elements in the array, and sets *dateInfo to point to the array. The
///	  caller is expected to free the array by calling spssFreeDateVariables
///	  when it is no longer needed. The variable information is copied directly
///	  from record 7, subtype 3. Its first six elements comprise the "fixed"
///	  information, followed by a sequence of one or more three-element groups
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="numofElements">
///	  Number of elements in allocated array
///	</param>
///	<param name="dateInfo">
///	  Pointer to first element of the allocated array
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetDateVariables(hFile: Integer; var numofElements: Integer;
  var dateInfo: PLongint): Integer; stdcall;

{$EXTERNALSYM spssGetDEWFirst}
///	<summary>
///	  The client can retrieve DEW information (file information that is private
///	  to the Data Entry product) from a file in whatever increments are
///	  convenient. The first such increment is retrieved by calling
///	  spssGetDEWFirst, and subsequent segments are retrieved by calling
///	  spssGetDEWNext as many times as necessary. As with spssGetDEWInfo,
///	  spssGetDEWFirst will return SPSS_NO_DEW if the file was written with a
///	  byte order that is the reverse of that of the host
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="pData">
///	  Returned as data from the file
///	</param>
///	<param name="maxData">
///	  Maximum bytes to return
///	</param>
///	<param name="nData">
///	  Returned as number of bytes returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetDEWFirst(hFile: Integer; var pData: Pointer; maxData: LongInt;
  var nData: LongInt): Integer; stdcall;

{$EXTERNALSYM spssGetDEWGUID}
///	<summary>
///	  Data Entry for Windows maintains a GUID in character form as a uniqueness
///	  indicator. Two files have identical dictionaries and DEW information if
///	  they have the same GUID. Note that the Chapter 5. I/O Module procedure
///	  reference 31 spssOpenWriteCopy function will not copy the source file's
///	  GUID. spssGetDEWGUID allows the client to read a file's GUID, if any. The
///	  client supplies a 257-byte string in which the null-terminated GUID is
///	  returned
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="asciiGUID">
///	  Returned as the file's GUID in character form or a null string if the
///	  file contains no GUID
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetDEWGUID(hFile: Integer; var asciiGUID: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetDEWInfo}
///	<summary>
///	  This function can be called before actually retrieving DEW information
///	  (file information that is private to the Data Entry product) from a file,
///	  to obtain some attributes of that information—specifically its length in
///	  bytes and its hash total. The hash total is, by convention, contained in
///	  the last four bytes to be written. Because it is not cognizant of the
///	  structure of the DEW information, the I/O Module is unable to correct the
///	  byte order of numeric information generated on a foreign host. As a
///	  result, the DEW information is discarded if the file has a byte order
///	  that is the reverse of that of the host, and calls to spssGetDEWInfo will
///	  return SPSS_NO_DEW
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="pLength">
///	  Returned as the length in bytes
///	</param>
///	<param name="pHashTotal">
///	  Returned as the hash total
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetDEWInfo(hFile: Integer; var pLength: LongInt;
  var pHashTotal: LongInt): Integer; stdcall;

{$EXTERNALSYM spssGetDEWNext}
///	<summary>
///	  The client can retrieve DEW information (file information that is private
///	  to the Data Entry product) from a file in whatever increments are
///	  convenient. The first such increment is retrieved by calling
///	  spssGetDEWFirst, and subsequent segments are retrieved by calling
///	  spssGetDEWNext as many times as necessary. As with spssGetDEWInfo,
///	  spssGetDEWFirst will return SPSS_NO_DEW if the file was written with a
///	  byte order that is the reverse of that of the host
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="pData">
///	  Returned as data from the file
///	</param>
///	<param name="maxData">
///	  Maximum bytes to return
///	</param>
///	<param name="nData">
///	  Returned as number of bytes returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetDEWNext(hFile: Integer; var pData: Pointer; maxData: LongInt;
  var nData: LongInt): Integer; stdcall;

{$EXTERNALSYM spssGetEstimatedNofCases}
/// <summary>
/// Although not strictly required for direct access input, this function
/// helps in reading IBM SPSS Statistics data files from versions earlier
/// than 6.0. Some of these data files did not contain number of cases
/// information, and spssGetNumberofCaseswill return �1 cases. This function
/// will return a precise number for uncompressed files and an estimate
/// (based on overall file size) for compressed files. It cannot be used on
/// files open for appending data
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="caseCount">
/// Returned as estimated nof cases
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetEstimatedNofCases(hFile: Integer; var caseCount: LongInt)
  : Integer; stdcall;

{$EXTERNALSYM spssGetFileAttributes}
///	<summary>
///	  This function returns all the datafile attributes. It allocates the
///	  memory necessary to hold the attribute names and values. For subscripted
///	  attributes, the names include the unit origin subscripts enclosed in
///	  square brackets, for example Prerequisite[11]. The acquired memory must
///	  be released by calling spssFreeAttributes
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="attribNames">
///	  Returned as a pointer to a vector of attribute names
///	</param>
///	<param name="attribText">
///	  Returned as a pointer to a vector of attribute values
///	</param>
///	<param name="nAttributes">
///	  Returned as the number of element in each vector
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetFileAttributes(hFile: Integer; var attribNames: PPAnsiChar;
  var attribText: PPAnsiChar; var nAttributes: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetFileCodePage}
///	<summary>
///	  This function provides the Windows code page number of the encoding
///	  applicable to a file. For instance, the Windows code page for ISO-8859-1
///	  is 28591. Note that the Windows code page for UTF-8 is 65001
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="nCodePage">
///	  Returned as the code page of the file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetFileCodePage(hFile: Integer; var nCodePage: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetFileEncoding}
///	<summary>
///	  This function obtains the encoding applicable to a file. The encoding is
///	  returned as an IANA encoding name, such as ISO-8859-1. The maximum length
///	  of the returned string is SPSS_MAX_ENCODING plus a null terminator
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="pszEncoding">
///	  Returned as the encoding of the file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetFileEncoding(hFile: Integer; var pszEncoding: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetIdString}
///	<summary>
///	  This function copies the file label of the IBM SPSS Statistics data file
///	  associated with handle into the buffer pointed to by id. The label is at
///	  most 64 characters long and null-terminated. Thus, the size of the buffer
///	  should be at least 65. If an input data file is associated with the
///	  handle, the label will be exactly 64 characters long, padded with blanks
///	  as necessary
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="id">
///	  File label buffer
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetIdString(hFile: Integer; var id: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssGetInterfaceEncoding}
/// <summary>
/// This function returns the current interface encoding
/// </summary>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetInterfaceEncoding(): Integer; stdcall;

{$EXTERNALSYM spssGetMultRespCount}
///	<summary>
///	  This function obtains a count of the number of multiple response sets
///	  stored in the dictionary
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="nSets">
///	  Returned as the number of sets
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetMultRespCount(hFile: Integer; var nSets: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetMultRespDefByIndex}
///	<summary>
///	  This function obtains a description of a single multiple response set.
///	  The set is specified via a zero origin index, and the description is
///	  returned in a struct for which the memory is allocated by the function
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="iSet">
///	  Zero origin index of the set
///	</param>
///	<param name="ppSet">
///	  Returned as a pointer to the set's description
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetMultRespDefByIndex(hFile: Integer; iSet: Integer;
  var ppSet: PSpssMultRespDef): Integer; stdcall;

{$EXTERNALSYM spssGetMultRespDefs}
///	<summary>
///	  This function retrieves the multiple-response set definitions from IBM
///	  SPSS Statistics data files. The definitions are stored as a
///	  null-terminated code page or UTF-8 string based on whether the
///	  spssGetInterfaceEncoding() type is SPSS_ENCODING_CODEPAGE or
///	  SPSS_ENCODING_UTF8. The memory allocated by this function to contain the
///	  string must be freed by calling spssFreeMultRespDefs. If the file
///	  contains no multiple response definitions, *mrespDefs is set to NULL, and
///	  the function returns the warning code SPSS_NO_MULTRESP
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="mrespDefs">
///	  Returned as a pointer to a string
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetMultRespDefs(hFile: Integer; var mrespDefs: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetMultRespDefsEx}
///	<summary>
///	  This function retrieves the multiple-response set definitions for from
///	  IBM SPSS Statistics data files for "extended" multiple dichotomy sets.
///	  The definitions are stored as a null-terminated code page or UTF-8 string
///	  based on whether thespssGetInterfaceEncoding()type is
///	  SPSS_ENCODING_CODEPAGEor SPSS_ENCODING_UTF8. The memory allocated by this
///	  function to contain the string must be freed by calling
///	  spssFreeMultRespDefs. If the file contains no multiple response
///	  definitions, *mrespDefsis set to NULL, and the function returns the
///	  warning code SPSS_NO_MULTRESP
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="mrespDefs">
///	  Returned as a pointer to a string
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetMultRespDefsEx(hFile: Integer; var mrespDefs: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetNumberofCases}
/// <summary>
/// This function reports the number of cases present in a data file open for
/// reading
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="caseCount">
/// Pointer to number of cases
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetNumberofCases(hFile: Integer; var caseCount: LongInt)
  : Integer; stdcall;

{$EXTERNALSYM spssGetNumberofVariables}
/// <summary>
/// This function reports the number of variables present in a data file
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="numVars">
/// Pointer to number of variables
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetNumberofVariables(hFile: Integer; var numVars: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetReleaseInfo}
///	<summary>
///	  This function reports release- and machine-specific information about the
///	  file associated with handle. The information consists of an array of
///	  eight int values copied from record type 7, subtype 3 of the file, and is
///	  useful primarily for debugging. The array elements are, in order, release
///	  number (index 0), release subnumber (1), special release identifier
///	  number (2), machine code (3), floating-point representation code (4),
///	  compression scheme code (5), big/little-endian code (6), and character
///	  representation code (7).
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="relInfo">
///	  Array of intin which release- and machine-specific data will be stored.
///	  This array must have at least eight elements.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetReleaseInfo(hFile: Integer; var relInfo: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetSystemString}
///	<summary>
///	  This function returns the name of the system under which the file was
///	  created. It is a 40-byte, blank-padded character field corresponding to
///	  the last 40 bytes of record type 1. Thus, in order to accommodate the
///	  information, the parameter sysName must be at least 41 bytes in length
///	  plus the terminating null character
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="sysName">
///	  The originating system name
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetSystemString(hFile: Integer; var sysName: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetTextInfo}
///	<summary>
///	  This function places the text data created by TextSmart as a
///	  null-terminated string in the user-supplied buffer textInfo. The buffer
///	  is assumed to be at least 256 characters long; the text data may be up to
///	  255 characters long. If text data are not present in the file, the first
///	  character in textInfo is set to NULL
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="textInfo">
///	  Buffer for text data
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetTextInfo(hFile: Integer; var textInfo: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetTimeStamp}
///	<summary>
///	  This function returns the creation date of the file as recorded in the
///	  file itself. The creation date is a null-terminated nine-byte character
///	  field in dd mmm yy format (27 Feb 96), and the receiving field must be at
///	  least 10 bytes in length. The creation time is a null-terminated
///	  eight-byte character field in hh:mm:ss format (13:12:15), and the
///	  receiving field must be at least nine bytes in length
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="fileDate">
///	  File creation date
///	</param>
///	<param name="fileTime">
///	  File creation time
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetTimeStamp(hFile: Integer; var fileDate, fileTime: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetValueChar}
///	<summary>
///	  This function gets the value of a string variable for the current case,
///	  which is the case read by the most recent call to spssReadCaseRecord. The
///	  value is returned as a null-terminated string in the caller-provided
///	  buffer value; the length of the string is the length of the string
///	  variable. The argument valueSize is the allocated size of the buffer
///	  value, which must be at least the length of the variable plus 1.
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varHandle">
///	  Handle of the variable
///	</param>
///	<param name="value">
///	  Buffer for the value of the string variable
///	</param>
///	<param name="valueSize">
///	  Size of value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetValueChar(hFile: Integer; varHandle: Double;
  var value: PAnsiChar; valueSize: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetValueNumeric}
///	<summary>
///	  This function gets the value of a numeric variable for the current case,
///	  which is the case read by the most recent call to spssReadCaseRecord
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varHandle">
///	  Handle to the variable
///	</param>
///	<param name="value">
///	  Pointer to the value of the numeric variable
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetValueNumeric(hFile: Integer; varHandle: Double;
  var value: Double): Integer; stdcall;

{$EXTERNALSYM spssGetVarAlignment}
///	<summary>
///	  This function reports the value of the alignment attribute of a variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="alignment">
///	  Pointer to alignment. Set to SPSS_ALIGN_LEFT,
///	  SPSS_ALIGN_RIGHT,orSPSS_ALIGN_CENTER.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarAlignment(hFile: Integer; varName: PAnsiChar;
  var alignment: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarAttributes}
///	<summary>
///	  This function is analogous to spssGetFileAttributes. It returns all the
///	  attributes for a single variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  The name of the variable
///	</param>
///	<param name="attribNames">
///	  Returned as a pointer to a vector of attribute names
///	</param>
///	<param name="attribText">
///	  Returned as a pointer to a vector of attribute values
///	</param>
///	<param name="nAttributes">
///	  Returned as the number of element in each vector
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarAttributes(hFile: Integer; varName: PAnsiChar;
  var attribNames: PPAnsiChar; var attribText: PPAnsiChar;
  var nAttributes: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarCMissingValues}
///	<summary>
///	  This function reports the missing values of a short string variable. The
///	  value of *missingFormat will be in the range 0–3, indicating the number
///	  of missing values. The appropriate number of missing values is copied to
///	  the buffers missingVal1, missingVal2, and missingVal3. The lengths of the
///	  null-terminated missing value strings will be the length of the short
///	  string variable in question. Since the latter can be at most eight
///	  characters long, nine-character buffers are adequate for any short string
///	  variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="missingFormat">
///	  Pointer to missing value format code
///	</param>
///	<param name="missingVal1">
///	  Buffer for first missing value
///	</param>
///	<param name="missingVal2">
///	  Buffer for second missing value
///	</param>
///	<param name="missingVal3">
///	  Buffer for third missing value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarCMissingValues(hFile: Integer; varName: PAnsiChar;
  var missingFormat: Integer; var missingVal1, missingVal2,
  missingVal3: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssGetVarColumnWidth}
///	<summary>
///	  This function reports the value of the column width attribute of a
///	  variable. A value of zero is special and means that the IBM SPSS
///	  Statistics Data Editor, which is the primary user of this attribute, will
///	  set an appropriate width using its own algorithm
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="columnWidth">
///	  Pointer to column width. Non-negative.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarColumnWidth(hFile: Integer; varName: PAnsiChar;
  var columnWidth: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarCompatName}
///	<summary>
///	  When writing IBM SPSS Statistics data files, the I/O Module creates
///	  variable names that are compatible with legacy versions. These names are
///	  no more than eight bytes in length, are all upper case, and are unique
///	  within the file. spssGetVarCompatName allows access to these "mangled"
///	  name for input files and for output files after spssCommitHeader has been
///	  called
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="longName">
///	  The variable's extended name as a null-terminated string
///	</param>
///	<param name="shortName">
///	  A nine-byte character variable to receive the mangled name as a
///	  null-terminate string
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarCompatName(hFile: Integer; longName: PAnsiChar;
  var shortName: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssGetVarCValueLabel}
///	<summary>
///	  This function gets the value label for a given value of a short string
///	  variable. The label is copied as a null-terminated string into the buffer
///	  label, whose size must be at least 61 to hold the longest possible value
///	  label (60 characters plus the null terminator). To get value labels more
///	  than 60 characters long, use the spssGetVarCValueLabelLong function
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="value">
///	  Short string value for which the label is wanted
///	</param>
///	<param name="_label">
///	  Label for the value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarCValueLabel(hFile: Integer; varName: PAnsiChar;
  value: PAnsiChar; var _label: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssGetVarCValueLabelLong}
///	<summary>
///	  This function returns a null-terminated value label corresponding to one
///	  value of a specified variable whose values are short strings. The
///	  function permits the client to limit the number of bytes (including the
///	  null terminator) stored and returns the number of data bytes (excluding
///	  the null terminator) actually stored. If an error is detected, the label
///	  is returned as a null string, and the length is returned as 0.
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Null-terminated variable name
///	</param>
///	<param name="value">
///	  Null-terminated value for which label is requested
///	</param>
///	<param name="labelBuff">
///	  Returned as null-terminated label
///	</param>
///	<param name="lenBuff">
///	  Overall size of labelBuff in bytes
///	</param>
///	<param name="lenLabel">
///	  Returned as bytes stored excluding terminator
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarCValueLabelLong(hFile: Integer; varName: PAnsiChar;
  value: PAnsiChar; var labelBuff: PAnsiChar; lenBuff: Integer;
  var lenLabel: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarCValueLabels}
///	<summary>
///	  This function gets the set of labeled values and associated labels for a
///	  short string variable. The number of values is returned as *numLabels.
///	  Values are stored into an array of *numLabels pointers, each pointing to
///	  a char string containing a null-terminated value, and *values is set to
///	  point to the first element of the array. Each value string is as long as
///	  the variable. The corresponding labels are structured as an array of
///	  *numLabels pointers, each pointing to a char string containing a
///	  null-terminated label, and *labels is set to point to the first element
///	  of the array
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="values">
///	  Pointer to array of pointers to values
///	</param>
///	<param name="labels">
///	  Pointer to array of pointers to labels
///	</param>
///	<param name="numofLabels">
///	  Pointer to number of values or labels
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarCValueLabels(hFile: Integer; varName: PAnsiChar;
  var values: PPAnsiChar; var labels: PPAnsiChar; var numofLabels: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetVarHandle}
/// <summary>
/// This function returns a handle for a variable, which can then be used to
/// read or write (depending on how the file was opened) values of the
/// variable. If handleis associated with an output file, the dictionary must
/// be written withspssCommitHeaderbefore variable handles can be obtained
/// viaspssGetVarHandle
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varName">
/// Variable name
/// </param>
/// <param name="varHandle">
/// Pointer to handle for the variable. Note that the variable handleis a
/// double, and not intor long
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values
/// </returns>
function spssGetVarHandle(hFile: Integer; varName: PAnsiChar;
  var varHandle: Double): Integer; stdcall;

{$EXTERNALSYM spssGetVariableSets}
///	<summary>
///	  This function reports the variable sets information in the data file.
///	  Variable sets information is stored in a null-terminated string and a
///	  pointer to the string is returned in *varSets. Since the variable sets
///	  string is allocated on the heap, the caller should free it by calling
///	  spssFreeVariableSets when it is no longer needed
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varSets">
///	  Pointer to pointer to variable sets string
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVariableSets(hFile: Integer; var varSets: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssGetVarInfo}
/// <summary>
/// This function gets the name and type of one of the variables present in a
/// data file. It serves the same purpose asspssGetVarNamesbut returns the
/// information one variable at a time and, therefore, can be passed to a
/// Visual Basic program. The storage to receive the variable name must be at
/// least 65 bytes in length because the name is returned as a
/// null-terminated string. The type code is an integer in the range
/// 0�32767--0 indicating a numeric variable and a positive value indicating
/// a string variable of that size
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="iVar">
/// Zero-origin variable number
/// </param>
/// <param name="varName">
/// Returned as the variable name
/// </param>
/// <param name="varType">
/// Returned as the variable type
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetVarInfo(hFile: Integer; iVar: Integer; var varName: PAnsiChar;
  var varType: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarLabel}
/// <summary>
/// This function copies the label of variablevarNameinto the buffer pointed
/// to by varLabel. Since the variable label is at most 120 characters long
/// and null-terminated, the size of the buffer should be at least 121. To
/// get labels more than 120 characters long, use
/// thespssGetVarLabelLongfunction
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varName">
/// Variable name
/// </param>
/// <param name="varLabel">
/// Variable label buffer
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetVarLabel(hFile: Integer; varName: PAnsiChar; var varLabel: AnsiChar): Integer; stdcall;

{$EXTERNALSYM spssGetVarLabelLong}
/// <summary>
/// This function returns the null-terminated label associated with the
/// specified variable but restricts the number of bytes (including the null
/// terminator) returned tolenBuff bytes. This length can be conveniently
/// specified assizeof(labelBuff). The function also returns the number of
/// data bytes (this time excluding the null terminator) stored. If an error
/// is detected, the label is returned as a null string, and the length is
/// returned as 0
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varName">
/// Variable name
/// </param>
/// <param name="labelBuff">
/// Variable label buffer
/// </param>
/// <param name="lenBuff">
/// Overall size of labelBuff in bytes
/// </param>
/// <param name="lenLabel">
/// Returned as bytes stored excluding terminator
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssGetVarLabelLong(hFile: Integer; varName: PAnsiChar;
  var labelBuff: AnsiChar; lenBuff: Integer; var lenLabel: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetVarMeasureLevel}
///	<summary>
///	  This function reports the value of the measurement level attribute of a
///	  variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="measureLevel">
///	  Pointer to measurement level. Set to SPSS_MLVL_NOM,
///	  SPSS_MLVL_ORD,orSPSS_MLVL_RAT, for nominal, ordinal, and scale (ratio),
///	  respectively.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarMeasureLevel(hFile: Integer; varName: PAnsiChar;
  var measureLevel: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarRole}
///	<summary>
///	  This function reports the role of a variable. The role is returned as
///	  *varRole
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="varRole">
///	  Pointer to variable role. Set to SPSS_ROLE_INPUT, SPSS_ROLE_TARGET,
///	  SPSS_ROLE_BOTH, SPSS_ROLE_NONE, SPSS_ROLE_PARTITION,orSPSS_ROLE_SPLIT
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarRole(hFile: Integer; varName: PAnsiChar;
  var varRole: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarNames}
/// <summary>
/// <para>
/// This function gets the names and types of all the variables present in
/// a data file. The number of variables is returned as *numVars. Variable
/// names are structured as an array of *numVarspointers, each pointing to
/// acharstring containing a variable name, and*varNamesis set to point to
/// the first element of the array. Variable types are stored into a
/// corresponding array of*numVarsin elements, and *varTypesis set to point
/// to the first element of the array. The type code is an integer in the
/// range 0�32767--0 indicating a numeric variable and a positive value
/// indicating a string variable of that size
/// </para>
/// <para>
/// The two arrays and the variable name strings are allocated on the heap.
/// When they are no longer needed, spssFreeVarNamesshould be called to
/// free the memory
/// </para>
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="numVars">
/// Pointer to number of variables
/// </param>
/// <param name="varNames">
/// Pointer to array of pointers to variable names
/// </param>
/// <param name="varTypes">
/// Pointer to array of variable types
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// SPSS_OK. No error SPSS_INVALID_HANDLE. The file handle is not valid
/// SPSS_INVALID_FILE. The data file contains no variables SPSS_NO_MEMORY.
/// Insufficient memory
/// </returns>
function spssGetVarNames(hFile: Integer; var numVars: Integer;
  var varNames: PPAnsiChar; var varTypes: PInteger): Integer; stdcall;

{$EXTERNALSYM spssGetVarNMissingValues}
///	<summary>
///	  This function reports the missing values of a numeric variable. The value
///	  of *missingFormat determines the interpretation of *missingVal1,
///	  *missingVal2, and *missingVal3. If*missingFormat is SPSS_MISS_RANGE,
///	  *missingVal1 and *missingVal2 represent the upper and lower limits,
///	  respectively, of the range, and *missingVal3 is not used. If
///	  *missingFormat is SPSS_MISS_RANGEANDVAL, *missingval1 and *missingVal2
///	  represent the range and *missingVal3 is the discrete missing value. If
///	  *missingFormat is neither of the above, it will be in the range 0–3,
///	  indicating the number of discrete missing values present. (The macros
///	  SPSS_NO_MISSVAL, SPSS_ONE_MISSVAL, SPSS_TWO_MISSVAL, and
///	  SPSS_THREE_MISSVAL may be used as synonyms for 0–3.)
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="missingFormat">
///	  Pointer to missing value format code
///	</param>
///	<param name="missingVal1">
///	  Pointer to first missing value
///	</param>
///	<param name="missingVal2">
///	  Pointer to second missing value
///	</param>
///	<param name="missingVal3">
///	  Pointer to third missing value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarNMissingValues(hFile: Integer; varName: PAnsiChar;
  var missingFormat: Integer; var missingVal1, missingVal2, missingVal3: Double)
  : Integer; stdcall;

{$EXTERNALSYM spssGetVarNValueLabel}
///	<summary>
///	  This function gets the value label for a given value of a numeric
///	  variable. The label is copied as a null-terminated string into the buffer
///	  label, whose size must be at least 61 to hold the longest possible value
///	  label (60 characters) plus the terminator. To get value labels more than
///	  60 characters long, use the spssGetVarNValueLabelLong function
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="value">
///	  Numeric value for which the label is wanted
///	</param>
///	<param name="_label">
///	  Label for the value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarNValueLabel(hFile: Integer; varName: PAnsiChar;
  value: Double; var _label: AnsiChar): Integer; stdcall;

{$EXTERNALSYM spssGetVarNValueLabelLong}
///	<summary>
///	  This function returns a null-terminated value label corresponding to one
///	  value of a specified numeric variable. It permits the client to limit the
///	  number of bytes (including the null terminator) stored and returns the
///	  number of data bytes (excluding the null terminator) actually stored. If
///	  an error is detected, the label is returned as a null string, and the
///	  length is returned as 0
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Null-terminated variable name
///	</param>
///	<param name="value">
///	  Value for which label is requested
///	</param>
///	<param name="labelBuff">
///	  Returned as null-terminated label
///	</param>
///	<param name="lenBuff">
///	  Overall size of labelBuff in bytes
///	</param>
///	<param name="lenLabel">
///	  Returned as bytes stored excluding terminator
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarNValueLabelLong(hFile: Integer; varName: PAnsiChar;
  value: Double; var labelBuff: PAnsiChar; lenBuff: Integer;
  var lenLabel: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarNValueLabels}
///	<summary>
///	  This function gets the set of labeled values and associated labels for a
///	  numeric variable. The number of values is returned as *numLabels. Values
///	  are stored into an array of *numLabels double elements, and *values is
///	  set to point to the first element of the array. The corresponding labels
///	  are structured as an array of *numLabels pointers, each pointing to a
///	  char string containing a null-terminated label, and *labels is set to
///	  point to the first element of the array.
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="values">
///	  Pointer to array of double values
///	</param>
///	<param name="labels">
///	  Pointer to array of pointers to labels
///	</param>
///	<param name="numofLabels">
///	  Pointer to number of values or labels
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarNValueLabels(hFile: Integer; varName: PAnsiChar;
  var values: PDouble; var labels: PPAnsiChar; var numofLabels: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssGetVarPrintFormat}
///	<summary>
///	  This function reports the print format of a variable. Format type, number
///	  of decimal places, and field width are returned as *printType, *printDec,
///	  and *printWid, respectively
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="printType">
///	  Pointer to print format type code (file spssdio.hdefines macros of the
///	  formSPSS_FMT_...for all valid format type codes)
///	</param>
///	<param name="printDec">
///	  Pointer to number of digits after the decimal
///	</param>
///	<param name="printWidth">
///	  Pointer to print format width
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarPrintFormat(hFile: Integer; varName: PAnsiChar;
  var printType, printDec, printWidth: Integer): Integer; stdcall;

{$EXTERNALSYM spssGetVarWriteFormat}
///	<summary>
///	  This function reports the write format of a variable. Format type, number
///	  of decimal places, and field width are returned as *writeType, *writeDec,
///	  and *writeWid, respectively
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="writeType">
///	  Pointer to write format type code (file spssdio.hdefines macros of the
///	  formSPSS_FMT_...for all valid format type codes)
///	</param>
///	<param name="writeDec">
///	  <para>
///	    Pointer to number of digits after the decima
///	  </para>
///	  <para>
///	    l
///	  </para>
///	</param>
///	<param name="writeWidth">
///	  Pointer to write format width
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssGetVarWriteFormat(hFile: Integer; varName: PAnsiChar;
  var writeType, writeDec, writeWidth: Integer): Integer; stdcall;

{$EXTERNALSYM spssHostSysmisVal}
///	<summary>
///	  This function accesses the same information as spssSysmisVal but returns
///	  the information via a parameter rather than on the stack as the function
///	  result. The problem being addressed is that not all languages return
///	  doubles from functions in the same fashion
///	</summary>
///	<param name="missVal">
///	  Returned as the system missing value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
procedure spssHostSysmisVal(var missVal: Double); stdcall;

{$EXTERNALSYM spssIsCompatibleEncoding}
///	<summary>
///	  This function determines whether the file's encoding is compatible with
///	  the current interface encoding. The result value of *bCompatible will be
///	  false when reading a code page file in UTF-8 mode, when reading a UTF-8
///	  file in code page mode when reading a code page file encoded in other
///	  than the current locale's code page, or when reading a file with numbers
///	  represented in reverse bit order. If the encoding is incompatible, data
///	  stored in the file by other applications, particularly Data Entry for
///	  Windows, may be unreliable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="bCompatible">
///	  Returned as the code page of the file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssIsCompatibleEncoding(hFile: Integer; var bCompatible: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssLowHighVal}
///	<summary>
///	  This function returns the "lowest" and "highest" values used for numeric
///	  missing value ranges on the host system. It may be called at any time
///	</summary>
///	<param name="lowest">
///	  Pointer to "lowest" value
///	</param>
///	<param name="highest">
///	  Pointer to "highest" value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
procedure spssLowHighVal(var lowest, highest: Double); stdcall;

{$EXTERNALSYM spssOpenAppend}
///	<summary>
///	  This function opens IBM SPSS Statistics data files for appending cases
///	  and returns a handle that should be used for subsequent operations on the
///	  file. (Note: This function will not work correctly on compressed data
///	  files created by versions prior to 14.0.)
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenAppend(var fileName: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenAppendEx}
/// <summary>
/// This function opens encrypted IBM SPSS Statistics data files for appending cases and returns a handle that should be used for subsequent operations on the file. (Note: This function will not work correctly on compressed data files created by versions prior to 14.0.)
/// Tip: This function also works for opening unencrypted IBM SPSS Statistics data files. In that case, the specified password is ignored.
/// There are some precautions involving encoding. If you are in UTF-8 mode, you can't open a data file in code page. If you are in code page mode, you can't open a system file in UTF-8. You also can't open a file in reversed bit order. If the file violates any of these rules, spssOpenAppendEx returns SPSS_INCOMPATIBLE_APPEND. While in code page mode, you can open a file in a different code page, but the results are not predictable. For more information about encoding, see “Interface and file encoding” on page 3
/// </summary>
/// <param name="fileName">
/// Name of the file
/// </param>
/// <param name="password">
/// A string that specifies the password that is required to open the file.
/// The password can be specified as encrypted or unencrypted. For reference,
/// passwords are always encrypted in pasted syntax within IBM SPSS Statistics
/// </param>
/// <param name="hFile">
/// Pointer to handle to be returned
/// </param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenAppendEx(fileName, password: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenAppendU8}
///	<summary>
///	  This function opens IBM SPSS Statistics data files for appending cases
///	  and returns a handle that should be used for subsequent operations on the
///	  file. (Note: This function will not work correctly on compressed data
///	  files created by versions prior to 14.0.)
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenAppendU8(fileName: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenAppendU8Ex}
///	<summary>
///	  This function opens IBM SPSS Statistics data files for appending cases
///	  and returns a handle that should be used for subsequent operations on the
///	  file. (Note: This function will not work correctly on compressed data
///	  files created by versions prior to 14.0.)
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values
///	</returns>
function spssOpenAppendU8Ex(fileName, password: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenRead}
///	<summary>
///	  This function opens IBM SPSS Statistics data files for reading and
///	  returns a handle that should be used for subsequent operations on the file
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values
///	</returns>
function spssOpenRead(fileName: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenReadEx}
///	<summary>
///	  This function opens encrypted IBM SPSS Statistics data files for reading
///	  and returns a handle that should be used for subsequent operations on the
///	  file. Tip: This function also works for opening unencrypted IBM SPSS
///	  Statistics data files. In that case, the specified password is ignored
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values
///	</returns>
function spssOpenReadEx(fileName, password: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenReadU8}
///	<summary>
///	  This function opens IBM SPSS Statistics data files for reading and
///	  returns a handle that should be used for subsequent operations on the file
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values
///	</returns>
function spssOpenReadU8(fileName: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenReadU8Ex}
///	<summary>
///	  This function opens encrypted IBM SPSS Statistics data files for reading
///	  and returns a handle that should be used for subsequent operations on the
///	  file. Tip:This function also works for opening unencrypted IBM SPSS
///	  Statistics data files. In that case, the specified password is ignored
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values
///	</returns>
function spssOpenReadU8Ex(fileName, password: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenWrite}
/// <summary>
/// This function opens a file in preparation for creating a new IBM SPSS
/// Statistics data file and returns a handle that should be used for
/// subsequent operations on the file
/// </summary>
/// <param name="fileName">
/// Name of the file
/// </param>
/// <param name="hFile">
/// Pointer to handle to be returned
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values
/// </returns>
function spssOpenWrite(fileName: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenWriteEx}
///	<summary>
///	  This function opens a file in preparation for creating a new encrypted
///	  IBM SPSS Statistics data file and returns a handle that should be used
///	  for subsequent operations on the file
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values
///	</returns>
function spssOpenWriteEx(fileName, password: PAnsiChar; hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenWriteU8}
///	<summary>
///	  This function opens a file in preparation for creating a new encrypted
///	  IBM SPSS Statistics data file and returns a handle that should be used
///	  for subsequent operations on the file
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values
///	</returns>
function spssOpenWriteU8(fileName: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenWriteU8Ex}
///	<summary>
///	  This function opens a file in preparation for creating a new encrypted
///	  IBM SPSS Statistics data file and returns a handle that should be used
///	  for subsequent operations on the file.
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteU8Ex(fileName, password: PAnsiChar; var hFile: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopy}
///	<summary>
///	  This function opens a file in preparation for creating a new IBM SPSS
///	  Statistics data file and initializes its dictionary from that of an
///	  existing IBM SPSS Statistics data file. It is useful when you want to
///	  modify the dictionary or data of an existing file or replace all of its
///	  data. The typical sequence of operations is to call spssOpenWriteCopy
///	  (newFileName, oldFileName, ...) to open a new file initialized with a
///	  copy of the old file's dictionary, then spssOpenRead (oldFileName, ...)
///	  to open the old file to access its data
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="dictFileName">
///	  Name of existing file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopy(fileName, dictFileName: PAnsiChar;
  var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopyEx}
///	<summary>
///	  This function opens a file in preparation for creating a new encrypted
///	  IBM SPSS Statistics data file and initializes its dictionary from an
///	  existing encrypted IBM SPSS Statistics data file. It is useful when you
///	  72 IBM SPSS Statistics Input/Output Module want to modify the dictionary
///	  or data of an existing file or replace all of its data. The typical
///	  sequence of operations is to call spssOpenWriteCopyEx (newFileName,
///	  oldFileName, ...) to open a new file initialized with a copy of the old
///	  file's dictionary, then spssOpenReadEx (oldFileName, ...) to open the old
///	  file to access its data. Tip: This function also works when the file from
///	  which the dictionary is obtained is an unencrypted IBM SPSS Statistics
///	  data file. In that case, the password that is specified for that file is
///	  ignored
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="dictFileName">
///	  Name of the new file
///	</param>
///	<param name="dictPassword">
///	  A string that specifies the password that is required to open the new
///	  file. Passwords are limited to 10 characters and are case-sensitive. All
///	  spaces, including leading and trailing spaces, are retained.
///	</param>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopyEx(fileName, password, dictFileName,
  dictPassword: PAnsiChar; var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopyExFile}
///	<summary>
///	  This function opens a file in preparation for creating a new encrypted
///	  IBM SPSS Statistics data file and initializes its dictionary from that of
///	  an existing unencrypted IBM SPSS Statistics data file. It is useful when
///	  you want to modify the dictionary or data of an existing file or replace
///	  all of its data. The typical sequence of operations is to call
///	  spssOpenWriteCopyExFile (newFileName, oldFileName, ...) to open a new
///	  file initialized with a copy of the old file's dictionary, then
///	  spssOpenRead (oldFileName, ...) to open the old file to access its data
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="dictFileName">
///	  Name of existing file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopyExFile(fileName, password, dictFileName: PAnsiChar;
  var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopyExDict}
///	<summary>
///	  This function opens a file in preparation for creating a new unencrypted
///	  IBM SPSS Statistics data file and initializes its dictionary from an
///	  existing encrypted IBM SPSS Statistics data file. It is useful when you
///	  want to modify the dictionary or data of an existing file or replace all
///	  of its data. The typical sequence of operations is to call
///	  spssOpenWriteCopyExDict (newFileName, oldFileName, ...) to open a new
///	  file initialized with a copy of the old file's dictionary, then
///	  spssOpenReadEx (oldFileName, ...) to open the old file to access its data
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="dictFileName">
///	  Name of existing file
///	</param>
///	<param name="dictPassword">
///	  A string that specifies the password that is required to open the
///	  existing file. The password can be specified as encrypted or unencrypted.
///	  For reference, passwords are always encrypted in pasted syntax within IBM
///	  SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopyExDict(fileName, dictFileName,
  dictPassword: PAnsiChar; var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopyU8}
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="dictFileName">
///	  Name of existing file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopyU8(fileName, dictFileName: PAnsiChar;
  var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopyU8Ex}
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="dictFileName">
///	  Name of existing file
///	</param>
///	<param name="dictPassword">
///	  A string that specifies the password that is required to open the
///	  existing file. The password can be specified as encrypted or unencrypted.
///	  For reference, passwords are always encrypted in pasted syntax within IBM
///	  SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopyU8Ex(fileName, password, dictFileName,
  dictPassword: PAnsiChar; var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopyU8ExFile}
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="password">
///	  A string that specifies the password that is required to open the file.
///	  The password can be specified as encrypted or unencrypted. For reference,
///	  passwords are always encrypted in pasted syntax within IBM SPSS Statistics
///	</param>
///	<param name="dictFileName">
///	  Name of existing file
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopyU8ExFile(fileName, password, dictFileName: PAnsiChar;
  var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssOpenWriteCopyU8ExDict}
///	<summary>
///	  This function opens a file in preparation for creating a new unencrypted
///	  IBM SPSS Statistics data file and initializes its dictionary from an
///	  existing encrypted IBM SPSS Statistics data file. It is useful when you
///	  want to modify the dictionary or data of an existing file or replace all
///	  of its data. The typical sequence of operations is to call
///	  spssOpenWriteCopyExDict (newFileName, oldFileName, ...) to open a new
///	  file initialized with a copy of the old file's dictionary, then
///	  spssOpenReadEx (oldFileName, ...) to open the old file to access its data
///	</summary>
///	<param name="fileName">
///	  Name of the file
///	</param>
///	<param name="dictFileName">
///	  Name of existing file
///	</param>
///	<param name="dictPassword">
///	  A string that specifies the password that is required to open the
///	  existing file. The password can be specified as encrypted or unencrypted.
///	  For reference, passwords are always encrypted in pasted syntax within IBM
///	  SPSS Statistics
///	</param>
///	<param name="hFile">
///	  Pointer to handle to be returned
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssOpenWriteCopyU8ExDict(fileName, dictFileName,
  dictPassword: PAnsiChar; var hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssQueryType7}
///	<summary>
///	  This function can be used to determine whether a file opened for reading
///	  or append contains a specific "type 7" record. The following type 7
///	  subtypes might be of interest: Subtype 3. Release information Subtype 4.
///	  Floating point constants including the system missing value Subtype 5.
///	  Variable set definitions Subtype 6. Date variable information Subtype 7.
///	  multiple-response set definitions Subtype 8. Data Entry for Windows (DEW)
///	  information Subtype 10. TextSmart information Subtype 11. Measurement
///	  level, column width, and alignment for each variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="subType">
///	  Specific subtype record
///	</param>
///	<param name="bFound">
///	  Returned set if the specified subtype was encountered
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssQueryType7(hFile, subType: Integer; var bFound: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssReadCaseRecord}
/// <summary>
/// This function reads the next case from a data file into internal buffers.
/// Values of individual variables for the case may then be obtained by
/// calling the spssGetValueNumeric and spssGetValueChar procedures
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssReadCaseRecord(hFile: Integer): Integer; stdcall;

{$EXTERNALSYM spssSeekNextCase}
/// <summary>
/// This function sets the file pointer of an input file so that the next
/// data case read will be the one specified via thecaseNumberparameter. A
/// zero-origin scheme is used. That is, the first case is number 0. The next
/// case can be read by calling eitherspssWholeCaseInorspssReadCaseRecord. If
/// the specified case is greater than or equal to the number of cases in the
/// file, the call to the input function will return SPSS_FILE_END
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="caseNumber">
/// Zero-origin case number
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssSeekNextCase(hFile: Integer; caseNumber: LongInt)
  : Integer; stdcall;

{$EXTERNALSYM spssSetCaseWeightVar}
/// <summary>
/// This function defines variablevarNameas the case weight variable for the
/// data file specified by thehandle
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varName">
/// The name of the case weight variable
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssSetCaseWeightVar(hFile: Integer; varName: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssSetCompression}
///	<summary>
///	  This function sets the compression attribute of a data file. Compression
///	  is set on if compSwitch is 1 (standard compression) or 2 (ZSAV
///	  compression), and off if it is 0. If this function is not called, the
///	  output file will be uncompressed by default
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="compSwitch">
///	  Compression switch. Specify 1 for standard compression and 2 for
///	  compression to a ZSAV file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetCompression(hFile, compSwitch: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetDateVariables}
///	<summary>
///	  This function sets the Trends date variable information. The array at
///	  dateInfo is assumed to have numofElements elements that correspond to the
///	  data array portion of record 7, subtype 3. Its first six elements
///	  comprise the "fixed" information, followed by a sequence of one or more
///	  three-element groups. Since very little validity checking is done on the
///	  input array, this function should be used with caution and is recommended
///	  only for copying Trends information from one file to another
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="numofElements">
///	  Size of the array dateInfo
///	</param>
///	<param name="dateInfo">
///	  Array containing date variables information
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetDateVariables(hFile, numofElements: Integer; dateInfo: LongInt)
  : Integer; stdcall;

{$EXTERNALSYM spssSetDEWFirst}
///	<summary>
///	  DEW information (file information which is private to the Data Entry
///	  product) can be delivered to the I/O Module in whatever segments are
///	  convenient for the client. The spssSetDEWFirst function is called to
///	  deliver the first such segment, and subsequent segments are delivered by
///	  calling spssSetDEWNext as many times as necessary
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="pData">
///	  Pointer to the data to be written
///	</param>
///	<param name="nBytes">
///	  Number of bytes to write
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetDEWFirst(hFile: Integer; pData: Pointer; nBytes: LongInt)
  : Integer; stdcall;

{$EXTERNALSYM spssSetDEWGUID}
///	<summary>
///	  This function stores the Data Entry for Windows uniqueness indicator on
///	  the data file. It should only be used by the DEW product
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="asciiGUID">
///	  The GUID (as a null-terminated string) to be stored on the file
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetDEWGUID(hFile: Integer; asciiGUID: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssSetDEWNext}
///	<summary>
///	  The DEW information (file information that is private to the Data Entry
///	  product) can be delivered to the I/O Module in whatever segments are
///	  convenient for the client. The spssSetDEWFirst function is called to
///	  deliver the first such segment, and subsequent segments are delivered by
///	  calling spssSetDEWNext as many times as necessary
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="pData">
///	  Pointer to the data to be written
///	</param>
///	<param name="nBytes">
///	  Number of bytes to write
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetDEWNext(hFile: Integer; pData: Pointer; nBytes: LongInt)
  : Integer; stdcall;

{$EXTERNALSYM spssSetFileAttributes}
///	<summary>
///	  This function replaces all the datafile attributes. It is the converse of
///	  spssGetFileAttributes, and the names of subscripted attributes must
///	  contain the unit origin subscripts in square brackets as in
///	  Prerequisite[11]. If the number of attributes is zero, the vector
///	  pointers can be NULL, and all attributes will be discarded
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="attribNames">
///	  Pointer to a vector of attribute names
///	</param>
///	<param name="attribText">
///	  Pointer to a vector of attribute values
///	</param>
///	<param name="nAttributes">
///	  The number of element in each vector
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetFileAttributes(hFile: Integer;
  attribNames, attribText: PPAnsiChar; nAttributes: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetIdString}
///	<summary>
///	  This function sets the file label of the output data file associated with
///	  handle to the given string id
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="id">
///	  File label. The length of the string should not exceed 64 characters.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetIdString(hFile: Integer; id: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssSetInterfaceEncoding}
/// <summary>
/// Use this function to change the interface encoding. If the call is
/// successful, all text communicated to or from the I/O Module in subsequent
/// calls will be in the specified mode. Also, all text in files written will
/// be in the specified mode. There can be no open files when this call is
/// made
/// </summary>
/// <param name="iEncoding">
/// iEncoding. An encoding mode, SPSS_ENCODING_CODEPAGE(the default)
/// orSPSS_ENCODING_UTF8
/// </param>
/// <returns>
/// Returns one of the following codes. Success is indicated by zero
/// (SPSS_OK), errors by positive values, and warnings, if any, by negative
/// values. SPSS_OK. No error SPSS_INVALID_ENCODING. The specified encoding
/// is not valid SPSS_FILES_OPEN. IBM SPSS Statistics files are open
/// </returns>
function spssSetInterfaceEncoding(iEncoding: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetLocale}
///	<summary>
///	  The I/O Module's locale is separate from that of the client application.
///	  When the I/O Module is first loaded, its locale is set to the system
///	  default. The spssSetLocale function gives the client application control
///	  over the I/O Module's locale. The parameters and return value are
///	  identical to those for the C runtime function setlocale
///	</summary>
///	<param name="iCategory">
///	  A locale category, for example LC_ALLorLC_CTYPE. These are defined in the
///	  header file locale.h
///	</param>
///	<param name="pszLocale">
///	  A locale, for example "Japanese.932"
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetLocale(iCategory: Integer; pszLocale: PAnsiChar)
  : PAnsiChar; stdcall;

{$EXTERNALSYM spssSetMultRespDefs}
///	<summary>
///	  This function is used to write multiple response definitions to the file.
///	  The definitions are stored as a null-terminated code page or UTF-8 string
///	  based on whether thespssGetInterfaceEncoding()type is
///	  SPSS_ENCODING_CODEPAGE or SPSS_ENCODING_UTF8.
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="mrespDefs">
///	  Code page or UTF-8 string containing definitions
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetMultRespDefs(hFile: Integer; mrespDefs: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssSetTempDir}
///	<summary>
///	  The I/O Module spills some large object to temporary files. Normally
///	  these files reside in the directory supplied by the Windows GetTempPath
///	  function. The spssSetTempDir function permits the I/O Module client to
///	  specify a different directory
///	</summary>
///	<param name="dirName">
///	  Fully-qualified directory name as a null-terminated string
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetTempDir(dirName: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssSetTextInfo}
///	<summary>
///	  This function sets the text data from the null-terminated string in
///	  textInfo. If the string is longer than 255 characters, only the first 255
///	  are (quietly) used. If textInfo contains the empty string, existing text
///	  data, if any, are deleted
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="textInfo">
///	  Text data
///	</param>
function spssSetTextInfo(hFile: Integer; textInfo: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssSetValueChar}
/// <summary>
/// This function sets the value of a string variable for the current case.
/// The current case is not written out to the data file until
/// spssCommitCaseRecord is called
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varHandle">
/// Handle to the variable
/// </param>
/// <param name="value">
/// Value of the variable as a null-terminated string. The length of the
/// string (ignoring trailing blanks, if any) should be less than or equal to
/// the length of the variable
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values
/// </returns>
function spssSetValueChar(hFile: Integer; varHandle: Double; value: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssSetValueNumeric}
///	<summary>
///	  This function sets the value of a numeric variable for the current case.
///	  The current case is not written out to the data file until
///	  spssCommitCaseRecord is called
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varHandle">
///	  Handle to the variable
///	</param>
///	<param name="value">
///	  Value of the variable
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetValueNumeric(hFile: Integer; varHandle: Double; value: Double)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVarAlignment}
///	<summary>
///	  This function sets the value of the alignment attribute of a variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="alignment">
///	  Alignment. Must be one of SPSS_ALIGN_LEFT,
///	  SPSS_ALIGN_RIGHT,orSPSS_ALIGN_CENTER. If not a legal value, alignment is
///	  set to a type-appropriate default
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarAlignment(hFile: Integer; varName: PAnsiChar;
  alignment: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetVarAttributes}
///	<summary>
///	  This function is analogous to spssSetFileAttributes. It replaces all the
///	  attributes for one variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Name of the variable
///	</param>
///	<param name="attribNames">
///	  Pointer to a vector of attribute names
///	</param>
///	<param name="attribText">
///	  Pointer to a vector of attribute values
///	</param>
///	<param name="nAttributes">
///	  The number of element in each vector
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarAttributes(hFile: Integer; varName: PAnsiChar;
  attribNames, attribText: PPAnsiChar; nAttributes: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetVarCMissingValues}
///	<summary>
///	  This function sets missing values for a short string variable. The
///	  argument missingFormat must be set to a value in the range 0–3 to
///	  indicate the number of missing values supplied. When fewer than three
///	  missing values are to be defined, the redundant arguments must still be
///	  present, although their values are not inspected. For example, if
///	  missingFormat is 2, missingVal3 is unused. The supplied missing values
///	  must be null-terminated and not longer than the length of the variable
///	  unless the excess length is made up of blanks, which are ignored. If the
///	  missing value is shorter than the length of the variable, trailing blanks
///	  are assumed
///	</summary>
///	<param name="hFile">
///	  The handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="missingFormat">
///	  Missing format code
///	</param>
///	<param name="missingVal1">
///	  First missing value
///	</param>
///	<param name="missingVal2">
///	  Second missing value
///	</param>
///	<param name="missingVal3">
///	  Third missing value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarCMissingValues(hFile: Integer; varName: PAnsiChar;
  missingFormat: Integer; missingVal1, missingVal2, missingVal3: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVarColumnWidth}
///	<summary>
///	  This function sets the value of the column width attribute of a variable.
///	  A value of zero is special and means that the IBM SPSS Statistics Data
///	  Editor, which is the primary user of this attribute, is to set an
///	  appropriate width using its own algorithm
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="columnWidth">
///	  Column width. If negative, a value of zero is (quietly) used instead.
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarColumnWidth(hFile: Integer; varName: PAnsiChar;
  columnWidth: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetVarCValueLabel}
///	<summary>
///	  This function changes or adds a value label for the specified value of a
///	  short string variable. The label should be a null-terminated string not
///	  exceeding 60 characters in length
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="_label">
///	  Value to be labeled
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarCValueLabel(hFile: Integer; varName: PAnsiChar;
  value: PAnsiChar; _label: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssSetVarCValueLabels}
///	<summary>
///	  This function defines a set of value labels for one or more short string
///	  variables. Value labels already defined for any of the given variable(s),
///	  if any, are discarded (if the labels are shared with other variables,
///	  they remain associated)
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varNames">
///	  Array of pointers to variable names
///	</param>
///	<param name="numofVars">
///	  Number of variables
///	</param>
///	<param name="values">
///	  Array of pointers to values
///	</param>
///	<param name="labels">
///	  Array of pointers to labels
///	</param>
///	<param name="numofLabels">
///	  Number of labels or values
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarCValueLabels(hFile: Integer; varNames: PPAnsiChar;
  numofVars: Integer; values, labels: PPAnsiChar; numofLabels: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVariableSets}
/// <summary>
/// This function sets the variable sets information in the data file. The
/// information must be provided in the form of a null-terminated string. No
/// validity checks are performed on the supplied string beyond ensuring that
/// its length is not 0. Any existing variable sets information is discarded
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varSets">
/// Variable sets information
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssSetVariableSets(hFile: Integer; varSets: PAnsiChar)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVarLabel}
///	<summary>
///	  This function sets the label of a variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="varLabel">
///	  Variable label. The length of the string should not exceed 120
///	  characters. If varLabelis the empty string, the existing label, if any,
///	  is deleted
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarLabel(hFile: Integer; varName: PAnsiChar;
  varLabel: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssSetVarMeasureLevel}
/// <summary>
/// This function sets the value of the measurement level attribute of a variable
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="varName">
/// Variable name
/// </param>
/// <param name="measureLevel">
/// Type and size of the variable
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssSetVarMeasureLevel(hFile: Integer; varName: PAnsiChar;
  measureLevel: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetVarRole}
///	<summary>
///	  This function sets the role of a variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="varRole">
///	  Variable role. Must be one of the following values: SPSS_ROLE_INPUT,
///	  SPSS_ROLE_TARGET, SPSS_ROLE_BOTH, SPSS_ROLE_NONE,
///	  SPSS_ROLE_PARTITION,orSPSS_ROLE_SPLIT
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarRole(hFile: Integer; varName: PAnsiChar; varRole: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVarName}
///	<summary>
///	  This function creates a new variable namedvarName, which will be either
///	  numeric or string based on varLength. If the latter is zero, a numeric
///	  variable with a default format of F8.2 will be created; if it is greater
///	  than 0 and less than or equal to 32767, a string variable with
///	  lengthvarLengthwill be created; any other value will be rejected as
///	  invalid. For better readability, the macrosSPSS_NUMERICandSPSS_STRING(
///	  length )may be used as values forvarLength
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="varLength">
///	  Variable name
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarName(hFile: Integer; varName: PAnsiChar; varLength: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVarNMissingValues}
///	<summary>
///	  This function sets missing values for a numeric variable. The
///	  interpretation of the arguments missingVal1, missingVal2, and missingVal3
///	  depends on the value of missingFormat. IfmissingFormat is set to
///	  SPSS_MISS_RANGE, missingVal1 and missingVal2 are taken as the upper and
///	  lower limits, respectively, of the range, and missingVal3 is ignored. If
///	  missingFormat is SPSS_MISS_RANGEANDVAL, missingval1 and missingVal2 are
///	  taken as limits of the range and missingVal3 is taken as the discrete
///	  missing value. If missingFormat is neither of the above, it must be in
///	  the range 0–3, indicating the number of discrete missing values present.
///	  For example, if missingFormat is 2, missingVal1 and missingVal2 are taken
///	  as two discrete missing values and missingVal3 is ignored. (The macros
///	  SPSS_NO_MISSVAL, SPSS_ONE_MISSVAL, SPSS_TWO_MISSVAL, and
///	  SPSS_THREE_MISSVAL may be used as synonyms for 0–3.)
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="missingFormat">
///	  Missing values format code
///	</param>
///	<param name="missingVal1">
///	  First missing value
///	</param>
///	<param name="missingVal2">
///	  Second missing value
///	</param>
///	<param name="missingVal3">
///	  Third missing value
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarNMissingValues(hFile: Integer; varName: PAnsiChar;
  missingFormat: Integer; missingVal1, missingVal2, missingVal3: Double)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVarNValueLabel}
///	<summary>
///	  This function changes or adds a value label for the specified value of a
///	  numeric variable. The label should be a null-terminated string not
///	  exceeding 60 characters in length
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="value">
///	  Value to be labeled
///	</param>
///	<param name="_label">
///	  Label
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarNValueLabel(hFile: Integer; varName: PAnsiChar;
  value: Double; _label: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssSetVarNValueLabels}
///	<summary>
///	  This function defines a set of value labels for one or more numeric
///	  variables. Value labels already defined for any of the given variable(s),
///	  if any, are discarded (if the labels are shared with other variables,
///	  they remain associated with those variables)
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varNames">
///	  Array of pointers to variable names
///	</param>
///	<param name="numofVars">
///	  Number of variables
///	</param>
///	<param name="values">
///	  Array of values
///	</param>
///	<param name="labels">
///	  Array of pointers to labels
///	</param>
///	<param name="numofLabels">
///	  Number of labels or values
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarNValueLabels(hFile: Integer; varNames: PPAnsiChar;
  numofVars: Integer; values: PDouble; labels: PPAnsiChar; numofLabels: Integer)
  : Integer; stdcall;

{$EXTERNALSYM spssSetVarPrintFormat}
///	<summary>
///	  This function sets the print format of a variable
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="printType">
///	  Print format type code (file spssdio.hdefines macros of the
///	  formSPSS_FMT_...for all valid format type codes)
///	</param>
///	<param name="printDec">
///	  Number of digits after the decimal
///	</param>
///	<param name="printWidth">
///	  Print format width
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarPrintFormat(hFile: Integer; varName: PAnsiChar;
  printType, printDec, printWidth: Integer): Integer; stdcall;

{$EXTERNALSYM spssSetVarWriteFormat}
///	<summary>
///	  This function sets the variable sets information in the data file. The
///	  information must be provided in the form of a null-terminated string. No
///	  validity checks are performed on the supplied string beyond ensuring that
///	  its length is not 0. Any existing variable sets information is discarded
///	</summary>
///	<param name="hFile">
///	  Handle to the data file
///	</param>
///	<param name="varName">
///	  Variable name
///	</param>
///	<param name="writeType">
///	  Write format type code (file spssdio.hdefines macros of the
///	  formSPSS_FMT_...for all valid format type codes)
///	</param>
///	<param name="writeDec">
///	  Number of digits after the decimal
///	</param>
///	<param name="writeWidth">
///	  Write format width
///	</param>
///	<returns>
///	  One of the following codes. Success is indicated by zero (SPSS_OK),
///	  errors by positive values, and warnings, if any, by negative values.
///	</returns>
function spssSetVarWriteFormat(hFile: Integer; varName: PAnsiChar;
  writeType, writeDec, writeWidth: Integer): Integer; stdcall;

{$EXTERNALSYM spssSysmisVal}
/// <summary>
/// This function returns the IBM SPSS Statistics system-missing value for
/// the host system. It may be called at any time
/// </summary>
/// <returns>
/// The IBM SPSS Statistics system-missing value for the host system
/// </returns>
function spssSysmisVal(): Double; stdcall;

{$EXTERNALSYM spssValidateVarname}
/// <summary>
/// This function allows the client to validate a potential variable name.
/// The name is checked for lexical validity only; there is no check for
/// whether it is a duplicate name. Note that the error code
/// SPSS_NAME_BADFIRSTindicates that the name is entirely composed of valid
/// characters but that the first character is not valid in that
/// position--for example, the name begins with a period or digit. Note also
/// that names ending with a period are technically valid but are to be
/// discouraged because they cause difficulty if they appear at the end of a
/// line of syntax
/// </summary>
/// <param name="varName">
/// Null-terminated variable name
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssValidateVarname(varName: PAnsiChar): Integer; stdcall;

{$EXTERNALSYM spssWholeCaseIn}
/// <summary>
/// This function reads a case from a data file into a case buffer provided
/// by the user. The required size of the buffer may be obtained by calling
/// spssGetCaseSize. This is a fairly low-level function whose use should not
/// be mixed with calls tospssReadCaseRecordusing the same file handle
/// because both procedures read a new case from the data file
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="caseRec">
/// Case record to be written to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssWholeCaseIn(hFile: Integer; var caseRec: Pointer)
  : Integer; stdcall;

{$EXTERNALSYM spssWholeCaseOut}
/// <summary>
/// This function writes a case assembled by the caller to a data file. The
/// case is assumed to have been constructed correctly in the buffercaseRec,
/// and its validity is not checked. This is a fairly low-level function
/// whose use should not be mixed with calls tospssCommitCaseRecordusing the
/// same file handle because both procedures write a new case to the data file
/// </summary>
/// <param name="hFile">
/// Handle to the data file
/// </param>
/// <param name="caseRec">
/// Case record to be written to the data file
/// </param>
/// <returns>
/// One of the following codes. Success is indicated by zero (SPSS_OK),
/// errors by positive values, and warnings, if any, by negative values.
/// </returns>
function spssWholeCaseOut(hFile: Integer; caseRec: Pointer): Integer; stdcall;

implementation

function spssAddFileAttribute; external DLLName;
function spssAddMultRespDefC; external DLLName;
function spssAddMultRespDefExt; external DLLName;
function spssAddMultRespDefN; external DLLName;
function spssAddVarAttribute; external DLLName;
function spssCloseAppend; external DLLName;
function spssCloseRead; external DLLName;
function spssCloseWrite; external DLLName;
function spssCommitCaseRecord; external DLLName;
function spssCommitHeader; external DLLName;
function spssConvertDate; external DLLName;
function spssConvertSPSSDate; external DLLName;
function spssConvertSPSSTime; external DLLName;
function spssConvertTime; external DLLName;
function spssCopyDocuments; external DLLName;
function spssFreeAttributes; external DLLName;
function spssFreeDateVariables; external DLLName;
function spssFreeMultRespDefs; external DLLName;
function spssFreeMultRespDefStruct; external DLLName;
function spssFreeVarCValueLabels; external DLLName;
function spssFreeVariableSets; external DLLName;
function spssFreeVarNames; external DLLName;
function spssFreeVarNValueLabels; external DLLName;
function spssGetCaseSize; external DLLName;
function spssGetCaseWeightVar; external DLLName;
function spssGetCompression; external DLLName;
function spssGetDateVariables; external DLLName;
function spssGetDEWFirst; external DLLName;
function spssGetDEWGUID; external DLLName;
function spssGetDEWInfo; external DLLName;
function spssGetDEWNext; external DLLName;
function spssGetEstimatedNofCases; external DLLName;
function spssGetFileAttributes; external DLLName;
function spssGetFileCodePage; external DLLName;
function spssGetFileEncoding; external DLLName;
function spssGetIdString; external DLLName;
function spssGetInterfaceEncoding; external DLLName;
function spssGetMultRespCount; external DLLName;
function spssGetMultRespDefByIndex; external DLLName;
function spssGetMultRespDefs; external DLLName;
function spssGetMultRespDefsEx; external DLLName;
function spssGetNumberofCases; external DLLName;
function spssGetNumberofVariables; external DLLName;
function spssGetReleaseInfo; external DLLName;
function spssGetSystemString; external DLLName;
function spssGetTextInfo; external DLLName;
function spssGetTimeStamp; external DLLName;
function spssGetValueChar; external DLLName;
function spssGetValueNumeric; external DLLName;
function spssGetVarAlignment; external DLLName;
function spssGetVarAttributes; external DLLName;
function spssGetVarCMissingValues; external DLLName;
function spssGetVarColumnWidth; external DLLName;
function spssGetVarCompatName; external DLLName;
function spssGetVarCValueLabel; external DLLName;
function spssGetVarCValueLabelLong; external DLLName;
function spssGetVarCValueLabels; external DLLName;
function spssGetVarHandle; external DLLName;
function spssGetVariableSets; external DLLName;
function spssGetVarInfo; external DLLName;
function spssGetVarLabel; external DLLName;
function spssGetVarLabelLong; external DLLName;
function spssGetVarMeasureLevel; external DLLName;
function spssGetVarRole; external DLLName;
function spssGetVarNames; external DLLName;
function spssGetVarNMissingValues; external DLLName;
function spssGetVarNValueLabel; external DLLName;
function spssGetVarNValueLabelLong; external DLLName;
function spssGetVarNValueLabels; external DLLName;
function spssGetVarPrintFormat; external DLLName;
function spssGetVarWriteFormat; external DLLName;
procedure spssHostSysmisVal; external DLLName;
function spssIsCompatibleEncoding; external DLLName;
procedure spssLowHighVal; external DLLName;
function spssOpenAppend; external DLLName;
function spssOpenAppendEx; external DLLName;
function spssOpenAppendU8; external DLLName;
function spssOpenAppendU8Ex; external DLLName;
function spssOpenRead; external DLLName;
function spssOpenReadEx; external DLLName;
function spssOpenReadU8; external DLLName;
function spssOpenReadU8Ex; external DLLName;
function spssOpenWrite; external DLLName;
function spssOpenWriteEx; external DLLName;
function spssOpenWriteU8; external DLLName;
function spssOpenWriteU8Ex; external DLLName;
function spssOpenWriteCopy; external DLLName;
function spssOpenWriteCopyEx; external DLLName;
function spssOpenWriteCopyExFile; external DLLName;
function spssOpenWriteCopyExDict; external DLLName;
function spssOpenWriteCopyU8; external DLLName;
function spssOpenWriteCopyU8Ex; external DLLName;
function spssOpenWriteCopyU8ExFile; external DLLName;
function spssOpenWriteCopyU8ExDict; external DLLName;
function spssQueryType7; external DLLName;
function spssReadCaseRecord; external DLLName;
function spssSeekNextCase; external DLLName;
function spssSetCaseWeightVar; external DLLName;
function spssSetCompression; external DLLName;
function spssSetDateVariables; external DLLName;
function spssSetDEWFirst; external DLLName;
function spssSetDEWGUID; external DLLName;
function spssSetDEWNext; external DLLName;
function spssSetFileAttributes; external DLLName;
function spssSetIdString; external DLLName;
function spssSetInterfaceEncoding; external DLLName;
function spssSetLocale; external DLLName;
function spssSetMultRespDefs; external DLLName;
function spssSetTempDir; external DLLName;
function spssSetTextInfo; external DLLName;
function spssSetValueChar; external DLLName;
function spssSetValueNumeric; external DLLName;
function spssSetVarAlignment; external DLLName;
function spssSetVarAttributes; external DLLName;
function spssSetVarCMissingValues; external DLLName;
function spssSetVarColumnWidth; external DLLName;
function spssSetVarCValueLabel; external DLLName;
function spssSetVarCValueLabels; external DLLName;
function spssSetVariableSets; external DLLName;
function spssSetVarLabel; external DLLName;
function spssSetVarMeasureLevel; external DLLName;
function spssSetVarRole; external DLLName;
function spssSetVarName; external DLLName;
function spssSetVarNMissingValues; external DLLName;
function spssSetVarNValueLabel; external DLLName;
function spssSetVarNValueLabels; external DLLName;
function spssSetVarPrintFormat; external DLLName;
function spssSetVarWriteFormat; external DLLName;
function spssSysmisVal; external DLLName;
function spssValidateVarname; external DLLName;
function spssWholeCaseIn; external DLLName;
function spssWholeCaseOut; external DLLName;

end.
