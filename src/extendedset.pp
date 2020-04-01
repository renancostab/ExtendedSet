unit ExtendedSet;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  ESAlgorithm;

type
  TES = ESAlgorithm.TES;

  procedure ESInclude(var ASet: TES; AValue: Integer);
  procedure ESIncludeNonOrdered(var ASet: TES; AValue: Integer);
  procedure ESIncludeNonOrderedIndex(var ASet: TES; AIndex, AValue: Integer);
  procedure ESExclude(var ASet: TES; AValue: Integer);
  procedure ESAssign(var ASource: TES; var ADest: TES);
  procedure ESIndexAssign(var ASource: TES; AIndex: Integer; var ADest: TES);
  procedure ESSort(var ASet: TES);
  procedure ESRemoveDuplicate(var ASet: TES);

  function ESEqual(var S1, S2: TES): Boolean;

  operator := (const S1: TESByte): TES;
  operator := (const S1: TES): TESByte;

  operator = (const S1: TES; const S2: TESByte): Boolean;

  operator + (const S1, S2: TES): TES;
  operator + (const S1: TESByte; const S2: TES): TES;

  operator - (const S1: TES; const S2: TES): TES;
  operator - (const S1: TES; const S2: TESByte): TES;

  operator * (const S1, S2: TES): TES;
  operator * (const S1: TES; const S2: TESByte): TES;

  operator <= (const S1, S2: TES): Boolean;
  operator <= (const S1: TES; S2: TESByte): Boolean;
  operator <= (const S1: TES; S2: Integer): Boolean;

implementation

procedure ESInclude(var ASet: TES; AValue: Integer);
var
  Found: Boolean;
  Index: Integer;
begin
  Index := ESBinarySortSearch(ASet, AValue, Found);
  if Found then
    Exit;

  SetLength(ASet, Length(ASet) + 1);
  if (Length(ASet) > 1) and (Index <> High(ASet)) then
    Move(ASet[Index], ASet[Index + 1], (High(ASet) - Index) * SizeOf(Integer));
  ASet[Index] := AValue;
end;

procedure ESIncludeNonOrdered(var ASet: TES; AValue: Integer);
begin
  SetLength(ASet, Length(ASet) + 1);
  ASet[High(ASet)] := AValue;
end;

procedure ESIncludeNonOrderedIndex(var ASet: TES; AIndex, AValue: Integer);
begin
  ASet[AIndex] := AValue;
end;

procedure ESExclude(var ASet: TES; AValue: Integer);
var
  Index: Integer;
begin
  if Length(ASet) = 0 then
    Exit;

  Index := ESBinarySearch(ASet, AValue);
  if Index = -1 then
    Exit;

  if Index <> High(ASet) then
    Move(ASet[Index + 1], ASet[Index], (High(ASet) - Index) * SizeOf(Integer));

  SetLength(ASet, Length(ASet) - 1);
end;

procedure ESAssign(var ASource: TES; var ADest: TES);
begin
  if Length(ASource) = 0 then
    Exit;

  SetLength(ADest, Length(ASource));
  Move(ASource[0], ADest[0], Length(ASource) * SizeOf(Integer));
end;

procedure ESIndexAssign(var ASource: TES; AIndex: Integer; var ADest: TES);
begin
  if Length(ASource) = 0 then
    Exit;

  SetLength(ADest, Length(ASource) - AIndex);
  Move(ASource[AIndex], ADest[0], (Length(ASource) - AIndex) * SizeOf(Integer));
end;

procedure ESSort(var ASet: TES);
  procedure Quick(var ASet: TES; ALow, AHigh: Integer);
  var
    Lo, Hi, Mid, Temp: Integer;
  begin
    Lo  := ALow;
    Hi  := AHigh;
    Mid := ASet[(Lo + Hi) >> 1];

    repeat
      while ASet[Lo] < Mid do
        Lo += 1;

      while ASet[Hi] > Mid do
        Hi -= 1;

      if Lo <= Hi then begin
        Temp := ASet[Lo];
        ASet[Lo] := ASet[Hi];
        ASet[Hi] := Temp;
        Lo += 1;
        Hi -= 1;
      end;
    until Lo > Hi;

    if Hi > ALow then
      Quick(ASet, ALow, Hi);

    if Lo < AHigh then
      Quick(ASet, Lo, AHigh);
  end;
begin
  if Length(ASet) = 0 then
      Exit;

  Quick(ASet, 0, High(ASet));
end;

procedure ESRemoveDuplicate(var ASet: TES);
var
  I: Integer;
  J: Integer = 0;
begin
  for I := 0 to High(ASet) do
  begin
    if ASet[I] <> ASet[I + 1] then
    begin
      ASet[J] := ASet[I];
      J += 1;
    end;
  end;

  if J <> Length(ASet) then
    SetLength(ASet, J);
end;

function ESEqual(var S1, S2: TES): Boolean;
begin
  if S1 = S2 then
    Exit(True);

  if Length(S1) <> Length(S2) then
    Exit(False);

  Result := CompareMem(@S1[0], @S2[0], Length(S1) * SizeOf(Integer));
end;

operator := (const S1: TESByte): TES;
var
  I: Integer;
begin
  SetLength(Result, 0);
  for I in S1 do
    ESInclude(Result, I);
end;

operator := (const S1: TES): TESByte;
var
  I: Integer;
begin
  Result := [];
  for I := 0 to High(S1) do
    Include(Result, I);
end;

operator = (const S1: TES; const S2: TESByte): Boolean;
var
  I, C: Integer;
begin
  C := 0;
  for I in S2 do
  begin
    if ESBinarySearch(S1, I) = -1 then
      Exit(False);

    C += 1;
  end;
  Result := C = Length(S1);
end;

operator + (const S1, S2: TES): TES;
begin
  SetLength(Result, Length(S1) + Length(S2));
  if Length(Result) = 0 then
    Exit;

  if Length(S1) > 0 then
    Move(S1[0], Result[0], Length(S1) * SizeOf(Integer));

  if Length(S2) > 0 then
    Move(S2[0], Result[Length(S1)], Length(S2) * SizeOf(Integer));

  ESSort(Result);
  ESRemoveDuplicate(Result);
end;

operator + (const S1: TESByte; const S2: TES): TES;
var
  I: Integer;
begin
  SetLength(Result, Length(S2));
  Move(S2[0], Result[0], Length(S2) * SizeOf(Integer));
  ESSort(Result);

  for I in S1 do
    ESInclude(Result, I);
end;

operator - (const S1: TES; const S2: TES): TES;
var
  I: Integer;
  J: Integer = 0;
  Inters: TES;
begin
  Inters := S1 * S2;
  if Inters = [] then
  begin
    Result := S1;
    Exit;
  end;

  SetLength(Result, Length(S1) - Length(Inters));
  if Length(Result) = 0 then
    Exit;

  for I := 0 to High(S1) do
  begin
    if Inters <= S1[I] then
      Continue;

    Result[J] := S1[I];
    J += 1;
  end;
end;

operator - (const S1: TES; const S2: TESByte): TES;
var
  I: Integer;
  Inters: TES;
begin
  Result := S1 + S2;
  Inters := S1 * S2;
  for I in Inters do
    ESExclude(Result, I);
end;

operator * (const S1, S2: TES): TES;
var
  I: Integer;
  J: Integer = 0;
begin
  SetLength(Result, Length(S1));
  for I := 0 to High(S1) do
  begin
    if ESBinarySearch(S2, S1[I]) = -1 then
      Continue;

    Result[J] := S1[I];
    J += 1;
  end;

  if J <> Length(Result) then
    SetLength(Result, J);
end;

operator * (const S1: TES; const S2: TESByte): TES;
var
  I: Integer;
  J: Integer = 0;
begin
  SetLength(Result, Length(S1));
  for I in S2 do
  begin
    if ESBinarySearch(S1, I) = -1 then
      Continue;

    Result[I] := I;
    J += 1;
  end;

  if J <> Length(Result) then
    SetLength(Result, J);
end;

operator <= (const S1, S2: TES): Boolean;
begin
  Result := Length((S1 * S2)) = Length(S2);
end;

operator <= (const S1: TES; S2: TESByte): Boolean;
begin
  Result := (S1 * S2) = S2;
end;

operator <= (const S1: TES; S2: Integer): Boolean;
begin
  Result := ESBinarySearch(S1, S2) > -1;
end;

end.

