program Demo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  SPSSDIO in '..\spss\SPSSDIO.PAS',
  SPSSDIOCODES in '..\spss\SPSSDIOCODES.PAS';

/// <summary>
/// Raise exception if code &lt;&gt; SPSS_OK
/// </summary>
/// <param name="AValue">
/// SPSS function result
/// </param>
procedure ErrorHandler(AValue: Integer);
begin
  if AValue <= SPSS_OK then
    Exit;

  raise Exception.Create('Error code = ' + IntToStr(AValue));
end;

/// <summary>
/// <para>
/// ResultHandler
/// </para>
/// <para>
/// Handler for SPSS functions result
/// </para>
/// </summary>
/// <param name="Caption">
/// Function name or caption
/// </param>
/// <param name="AValue">
/// SPSS function result
/// </param>
procedure RHnd(Caption: string; AValue: Integer);
begin
  if Caption <> '' then
    Write(#13#10 + Caption + ' ');
  if AValue <= SPSS_OK then
    Write('Success!')
  else
    ErrorHandler(AValue);
end;

/// <summary>
/// First example from PDF documentation to the library
/// </summary>
procedure DoVariableReading;
const
  SPSSFILEPATH: PAnsiChar = 'spss.sav';
  // SPSSFILEPATH: PAnsiChar = 'spss_new.sav';
var
  i, j, FileH, VariableCount: Integer;
  VarArray: PInteger;
  VarNames: PPAnsiChar;
  VarName: PAnsiChar;
  ArrLabel: Array [0..120] of AnsiChar;
  VarLength: Integer;
  VarHandles: array of Double;
  VarType: Integer;
  CasesCount: LongInt;
  ValChar: PAnsiChar;
  ValNum: Double;
  str: string;
begin
  Writeln(#13#10'DoVariableReading');
  //RHnd('SetInterfaceEncoding ', (spssSetInterfaceEncoding(SPSS_ENCODING_UTF8)));
  RHnd('OpenRead ', spssOpenRead(SPSSFILEPATH, FileH));
  RHnd('GetVarNames ', spssGetVarNames(FileH, VariableCount, VarNames,
    VarArray));
  Write(Format(' Variables count: %d', [VariableCount]));
  SetLength(VarHandles, VariableCount);

  // HACK for delphi > 2009. This directive is not documented.
  // Easy access to values of pointers
{$POINTERMATH ON}
  for i := 0 to 55 do
  begin
    //saving var name and handle
    VarName := PAnsiChar((VarNames + i)^);
    VarType := Integer((VarArray + i)^);
    RHnd('GetVarHandle', spssGetVarHandle(FileH, VarName, VarHandles[i]));
    //ErrorHandler(spssGetVarLabel(FileH, VarName, ArrLabel[0]));
    //or
    ErrorHandler(spssGetVarLabelLong(FileH, VarName, ArrLabel[0], 120, VarLength));

    Write(Format(' Name: %s, type: %d  |%s|', [VarName, VarLength, string(ArrLabel)]));
  end;

  RHnd('GetNumberofCases', spssGetNumberofCases(FileH, CasesCount));
  WriteLn(Format(#13#10' CasesCount: %d', [CasesCount]));

  //for j := 0 to CasesCount-1 do
  for j := 0 to 50 do
  begin
    ErrorHandler(spssReadCaseRecord(FileH));

    for i := 0 to 10 do
    begin
      if VarType = 0 then
      begin
        ErrorHandler(spssGetValueNumeric(FileH, VarHandles[i], ValNum));
        ErrorHandler(spssGetVarNValueLabel(FileH, PAnsiChar((VarNames + i)^), ValNum, ArrLabel[0]));
        //Write(Format(' %.2f, %s', [ValNum, ArrLabel]));
        Write(Format('%s(%.2f) ', [ArrLabel, ValNum]));
      end
      else
      begin
        ErrorHandler(spssGetValueChar(FileH, VarHandles[i], ValChar, 256));
        Write(Format(' %s ', [ValChar]));
      end;
    end;
    WriteLn('');
  end;
{$POINTERMATH OFF}
  RHnd('FreeVarNames', spssFreeVarNames(VarNames, VarArray, VariableCount));
  RHnd('CloseRead ', spssCloseRead(FileH));
end;

/// <summary>
/// Second example from PDF documentation to the library
/// </summary>
procedure DoNewFileWriting;
const
  SPSSFILEPATH: PAnsiChar = 'spss_new.sav';
var
  i, FileH, VariableCount: Integer;
  VarArray: PInteger;
  VarNames: PPAnsiChar;
  VarName: PAnsiChar;
  VarH: Double;
  Str: PAnsiChar;
begin
  Writeln('DoNewFileWriting');

  Str := 'test';
  RHnd('SetInterfaceEncoding', spssSetInterfaceEncoding(SPSS_ENCODING_UTF8));
  RHnd('OpenWrite', spssOpenWrite(SPSSFILEPATH, FileH));
  RHnd('SetVarName', spssSetVarName(FileH, Str, SPSS_STRING(10)));
  RHnd('CommitHeader', spssCommitHeader(FileH));
  RHnd('GetVarHandle', spssGetVarHandle(FileH, Str, VarH));
  RHnd('SetValueChar', spssSetValueChar(FileH, VarH, PAnsiChar('varvalue')));
  RHnd('CommitCaseRecord', spssCommitCaseRecord(FileH));
  RHnd('CloseWrite', spssCloseWrite(FileH));
end;

begin
  try
    //DoNewFileWriting;
    DoVariableReading;
    Writeln(#13#10'Finished. No errors found!');
    ReadLn;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      ReadLn;
    end;
  end;
end.
