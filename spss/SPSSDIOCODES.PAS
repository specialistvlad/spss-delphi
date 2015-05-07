unit SPSSDIOCODES;

interface

const
  SPSS_NUMERIC = 0;

  { MISSING VALUE TYPE CODES }
  SPSS_NO_MISSVAL = 0;
  SPSS_ONE_MISSVAL = 1;
  SPSS_TWO_MISSVAL = 2;
  SPSS_THREE_MISSVAL = 3;
  SPSS_MISS_RANGE = -2;
  SPSS_MISS_RANGEANDVAL = -3;

  { ERROR CODES }
  SPSS_OK = 0;
  SPSS_FILE_OERROR = 1;
  SPSS_FILE_WERROR = 2;
  SPSS_FILE_RERROR = 3;
  SPSS_FITAB_FULL = 4;
  SPSS_INVALID_HANDLE = 5;
  SPSS_INVALID_FILE = 6;
  SPSS_NO_MEMORY = 7;
  SPSS_OPEN_RDMODE = 8;
  SPSS_OPEN_WRMODE = 9;
  SPSS_INVALID_VARNAME = 10;
  SPSS_DICT_EMPTY = 11;
  SPSS_VAR_NOTFOUND = 12;
  SPSS_DUP_VAR = 13;
  SPSS_NUME_EXP = 14;
  SPSS_STR_EXP = 15;
  SPSS_SHORTSTR_EXP = 16;
  SPSS_INVALID_VARTYPE = 17;
  SPSS_INVALID_MISSFOR = 18;
  SPSS_INVALID_COMPSW = 19;
  SPSS_INVALID_PRFOR = 20;
  SPSS_INVALID_WRFOR = 21;
  SPSS_INVALID_DATE = 22;
  SPSS_INVALID_TIME = 23;
  SPSS_NO_VARIABLES = 24;
  SPSS_MIXED_TYPES = 25;
  SPSS_DUP_VALUE = 27;
  SPSS_INVALID_CASEWGT = 28;
  SPSS_INCOMPATIBLE_DICT = 29;
  SPSS_DICT_COMMIT = 30;
  SPSS_DICT_NOTCOMMIT = 31;
  SPSS_NO_TYPE2 = 33;
  SPSS_NO_TYPE73 = 41;
  SPSS_INVALID_DATEINFO = 45;
  SPSS_NO_TYPE999 = 46;
  SPSS_EXC_STRVALUE = 47;
  SPSS_CANNOT_FREE = 48;
  SPSS_BUFFER_SHORT = 49;
  SPSS_INVALID_CASE = 50;
  SPSS_INTERNAL_VLABS = 51;
  SPSS_INCOMPAT_APPEND = 52;
  SPSS_INTERNAL_D_A = 53;
  SPSS_FILE_BADTEMP = 54;
  SPSS_DEW_NOFIRST = 55;
  SPSS_INVALID_MEASURELEVEL = 56;
  SPSS_INVALID_7SUBTYPE = 57;
  SPSS_INVALID_VARHANDLE = 58;
  SPSS_INVALID_ENCODING = 59;
  SPSS_FILES_OPEN = 60;
  SPSS_INVALID_MRSETDEF = 70;
  SPSS_INVALID_MRSETNAME = 71;
  SPSS_DUP_MRSETNAME = 72;
  SPSS_BAD_EXTENSION = 73;
  SPSS_INVALID_EXTENDEDSTRING = 74;
  SPSS_INVALID_ATTRNAME = 75;
  SPSS_INVALID_ATTRDEF = 76;
  SPSS_INVALID_MRSETINDEX = 77;
  SPSS_INVALID_VARSETDEF = 78;
  SPSS_INVALID_ROLE = 79;
  SPSS_INVALID_PASSWORD = 80;
  SPSS_EMPTY_PASSWORD = 81;

  { WARNING CODES }
  SPSS_EXC_LEN64 = -1;
  /// <summary>
  /// Retain for compatibility
  /// </summary>
  SPSS_EXC_LEN120 = -2;
  SPSS_EXC_VARLABEL = -2;
  SPSS_EXC_LEN60 = -4;
  SPSS_EXC_VALLABEL = -4;
  SPSS_FILE_END = -5;
  SPSS_NO_VARSETS = -6;
  SPSS_EMPTY_VARSETS = -7;
  SPSS_NO_LABELS = -8;
  SPSS_NO_LABEL = -9;
  SPSS_NO_CASEWGT = -10;
  SPSS_NO_DATEINFO = -11;
  SPSS_NO_MULTRESP = -12;
  SPSS_EMPTY_MULTRESP = -13;
  SPSS_NO_DEW = -14;
  SPSS_EMPTY_DEW = -15;

  { FORMAT TYPE CODES }
  /// <summary>
  /// Alphanumeric
  /// </summary>
  SPSS_FMT_A = 1;
  /// <summary>
  /// Alphanumeric hexadecimal
  /// </summary>
  SPSS_FMT_AHEX = 2;
  /// <summary>
  /// F Format with commas
  /// </summary>
  SPSS_FMT_COMMA = 3;
  /// <summary>
  /// Commas and floating dollar sign
  /// </summary>
  SPSS_FMT_DOLLAR = 4;
  /// <summary>
  /// Default Numeric Format
  /// </summary>
  SPSS_FMT_F = 5;
  /// <summary>
  /// Integer binary
  /// </summary>
  SPSS_FMT_IB = 6;
  /// <summary>
  /// Positive integer binary - hex
  /// </summary>
  SPSS_FMT_PIBHEX = 7;
  /// <summary>
  /// Packed decimal
  /// </summary>
  SPSS_FMT_P = 8;
  /// <summary>
  /// Positive integer binary unsigned
  /// </summary>
  SPSS_FMT_PIB = 9;
  /// <summary>
  /// Positive integer binary unsigned
  /// </summary>
  SPSS_FMT_PK = 10;
  /// <summary>
  /// Floating point binary
  /// </summary>
  SPSS_FMT_RB = 11;
  /// <summary>
  /// Floating point binary hex
  /// </summary>
  SPSS_FMT_RBHEX = 12;
  /// <summary>
  /// Zoned decimal
  /// </summary>
  SPSS_FMT_Z = 15;
  /// <summary>
  /// N Format- unsigned with leading 0s
  /// </summary>
  SPSS_FMT_N = 16;
  /// <summary>
  /// E Format- with explicit power of 10
  /// </summary>
  SPSS_FMT_E = 17;
  /// <summary>
  /// Date format dd-mmm-yyyy
  /// </summary>
  SPSS_FMT_DATE = 20;
  /// <summary>
  /// Time format hh:mm:ss.s
  /// </summary>
  SPSS_FMT_TIME = 21;
  /// <summary>
  /// Date and Time
  /// </summary>
  SPSS_FMT_DATE_TIME = 22;
  /// <summary>
  /// Date format mm/dd/yyyy
  /// </summary>
  SPSS_FMT_ADATE = 23;
  /// <summary>
  /// Julian date - yyyyddd
  /// </summary>
  SPSS_FMT_JDATE = 24;
  /// <summary>
  /// Date-time dd hh:mm:ss.s
  /// </summary>
  SPSS_FMT_DTIME = 25;
  /// <summary>
  /// Day of the week
  /// </summary>
  SPSS_FMT_WKDAY = 26;
  /// <summary>
  /// Month
  /// </summary>
  SPSS_FMT_MONTH = 27;
  /// <summary>
  /// mmm yyyy
  /// </summary>
  SPSS_FMT_MOYR = 28;
  /// <summary>
  /// q Q yyyy
  /// </summary>
  SPSS_FMT_QYR = 29;
  /// <summary>
  /// ww WK yyyy
  /// </summary>
  SPSS_FMT_WKYR = 30;
  /// <summary>
  /// Percent - F followed by %
  /// </summary>
  SPSS_FMT_PCT = 31;
  /// <summary>
  /// Like COMMA, switching dot for comma
  /// </summary>
  SPSS_FMT_DOT = 32;
  /// <summary>
  /// User Programmable currency format
  /// </summary>
  SPSS_FMT_CCA = 33;
  /// <summary>
  /// User Programmable currency format
  /// </summary>
  SPSS_FMT_CCB = 34;
  /// <summary>
  /// User Programmable currency format
  /// </summary>
  SPSS_FMT_CCC = 35;
  /// <summary>
  /// User Programmable currency format
  /// </summary>
  SPSS_FMT_CCD = 36;
  /// <summary>
  /// User Programmable currency format
  /// </summary>
  SPSS_FMT_CCE = 37;
  /// <summary>
  /// Date in dd.mm.yyyy style
  /// </summary>
  SPSS_FMT_EDATE = 38;
  /// <summary>
  /// Date in yyyy/mm/dd style
  /// </summary>
  SPSS_FMT_SDATE = 39;

  { MEASUREMENT LEVEL CODES }
  /// <summary>
  /// Unknown
  /// </summary>
  SPSS_MLVL_UNK = 0;
  /// <summary>
  /// Nominal
  /// </summary>
  SPSS_MLVL_NOM = 1;
  /// <summary>
  /// Ordinal
  /// </summary>
  SPSS_MLVL_ORD = 2;
  /// <summary>
  /// Scale (Ratio) (Continues)
  /// </summary>
  SPSS_MLVL_RAT = 3;
  /// <summary>
  /// Flag
  /// </summary>
  SPSS_MLVL_FLA = 4;
  /// <summary>
  /// Typeless
  /// </summary>
  SPSS_MLVL_TPL = 5;

  { ALIGNMENT CODES }
  SPSS_ALIGN_LEFT = 0;
  SPSS_ALIGN_RIGHT = 1;
  SPSS_ALIGN_CENTER = 2;

  { ROLE CODES }
  /// <summary>
  /// Input Role
  /// </summary>
  SPSS_ROLE_INPUT = 0;
  /// <summary>
  /// Target Role
  /// </summary>
  SPSS_ROLE_TARGET = 1;
  /// <summary>
  /// Both Roles
  /// </summary>
  SPSS_ROLE_BOTH = 2;
  /// <summary>
  /// None Role
  /// </summary>
  SPSS_ROLE_NONE = 3;
  /// <summary>
  /// Partition Role
  /// </summary>
  SPSS_ROLE_PARTITION = 4;
  /// <summary>
  /// Split Role
  /// </summary>
  SPSS_ROLE_SPLIT = 5;
  /// <summary>
  /// Frequency Role
  /// </summary>
  SPSS_ROLE_FREQUENCY = 6;
  /// <summary>
  /// Record ID
  /// </summary>
  SPSS_ROLE_RECORDID = 7;

  { DIAGNOSTICS REGARDING VAR NAMES }
  /// <summary>
  /// Valid standard name
  /// </summary>
  SPSS_NAME_OK = 0;
  /// <summary>
  /// Valid scratch var name
  /// </summary>
  SPSS_NAME_SCRATCH = 1;
  /// <summary>
  /// Valid system var name
  /// </summary>
  SPSS_NAME_SYSTEM = 2;
  /// <summary>
  /// Empty or longer than SPSS_MAX_VARNAME
  /// </summary>
  SPSS_NAME_BADLTH = 3;
  /// <summary>
  /// Invalid character or imbedded blank
  /// </summary>
  SPSS_NAME_BADCHAR = 4;
  /// <summary>
  /// Name is a reserved word
  /// </summary>
  SPSS_NAME_RESERVED = 5;
  /// <summary>
  /// Invalid initial character
  /// </summary>
  SPSS_NAME_BADFIRST = 6;

  { MAXIMUM LENGTHS OF DATA FILE OBJECTS }
  /// <summary>
  /// Variable name
  /// </summary>
  SPSS_MAX_VARNAME = 64;
  /// <summary>
  /// Short (compatibility) variable name
  /// </summary>
  SPSS_MAX_SHORTVARNAME = 8;
  /// <summary>
  /// Short string variable
  /// </summary>
  SPSS_MAX_SHORTSTRING = 8;
  /// <summary>
  /// File label string
  /// </summary>
  SPSS_MAX_IDSTRING = 64;
  /// <summary>
  /// Long string variable
  /// </summary>
  SPSS_MAX_LONGSTRING = 32767;
  /// <summary>
  /// Value label
  /// </summary>
  SPSS_MAX_VALLABEL = 120;
  /// <summary>
  /// Variable label
  /// </summary>
  SPSS_MAX_VARLABEL = 256;
  /// <summary>
  /// Maximum encoding text
  /// </summary>
  SPSS_MAX_ENCODING = 64;
  /// <summary>
  /// Maximum record 7 subtype
  /// </summary>
  SPSS_MAX_7SUBTYPE = 40;
  /// <summary>
  /// Maximum password
  /// </summary>
  SPSS_MAX_PASSWORD = 10;

  { Type 7 record subtypes }
  /// <summary>
  /// Documents (actually type 6
  /// </summary>
  SPSS_T7_DOCUMENTS = 0;
  /// <summary>
  /// VAX Data Entry - dictionary version
  /// </summary>
  SPSS_T7_VAXDE_DICT = 1;
  /// <summary>
  /// VAX Data Entry - data
  /// </summary>
  SPSS_T7_VAXDE_DATA = 2;
  /// <summary>
  /// Source system characteristics
  /// </summary>
  SPSS_T7_SOURCE = 3;
  /// <summary>
  /// Source system floating pt ants
  /// </summary>
  SPSS_T7_HARD = 4;
  /// <summary>
  /// Variable sets
  /// </summary>
  SPSS_T7_VARSETS = 5;
  /// <summary>
  /// Trends date information
  /// </summary>
  SPSS_T7_TRENDS = 6;
  /// <summary>
  /// Multiple response groups
  /// </summary>
  SPSS_T7_MULTRESP = 7;
  /// <summary>
  /// Windows Data Entry data
  /// </summary>
  SPSS_T7_DEW_DATA = 8;
  /// <summary>
  /// TextSmart data
  /// </summary>
  SPSS_T7_TEXTSMART = 10;
  /// <summary>
  /// Msmt level, col width, &amp; alignment
  /// </summary>
  SPSS_T7_MSMTLEVEL = 11;
  /// <summary>
  /// Windows Data Entry GUID
  /// </summary>
  SPSS_T7_DEW_GUID = 12;
  /// <summary>
  /// Extended variable names
  /// </summary>
  SPSS_T7_XVARNAMES = 13;
  /// <summary>
  /// Extended strings
  /// </summary>
  SPSS_T7_XSTRINGS = 14;
  /// <summary>
  /// Clementine Metadata
  /// </summary>
  SPSS_T7_CLEMENTINE = 15;
  /// <summary>
  /// 64 bit N of cases
  /// </summary>
  SPSS_T7_NCASES = 16;
  /// <summary>
  /// File level attributes
  /// </summary>
  SPSS_T7_FILE_ATTR = 17;
  /// <summary>
  /// Variable attributes
  /// </summary>
  SPSS_T7_VAR_ATTR = 18;
  /// <summary>
  /// Extended multiple response groups
  /// </summary>
  SPSS_T7_EXTMRSETS = 19;
  /// <summary>
  /// Encoding, aka code page
  /// </summary>
  SPSS_T7_ENCODING = 20;
  /// <summary>
  /// Value labels for long strings
  /// </summary>
  SPSS_T7_LONGSTRLABS = 21;
  /// <summary>
  /// Missing values for long strings
  /// </summary>
  SPSS_T7_LONGSTRMVAL = 22;
  /// <summary>
  /// Sort Index information
  /// </summary>
  SPSS_T7_SORTINDEX = 23;

  { Encoding modes }
  /// <summary>
  /// Text encoded in current code page
  /// </summary>
  SPSS_ENCODING_CODEPAGE = 0;
  /// <summary>
  /// Text encoded as UTF-8
  /// </summary>
  SPSS_ENCODING_UTF8 = 1;

function SPSS_STRING(length: Integer): Integer;

implementation

function SPSS_STRING(length: Integer): Integer;
begin
  Result := length;
end;

end.
