(**************************************************************************************************
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.

Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
ANY KIND, either express or implied. See the License for the specific language governing rights
and limitations under the License.

Project......: ExtendedSet
Author.......: Renan Bellódi
Original Code: ESAlgorithm.pp

***************************************************************************************************)


unit ESAlgorithm;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils;

type
  TES = array of Integer;
  TESByte = set of Byte;

  function ESBinarySortSearch(const ASet: TES; AValue: Integer; out AFound: Boolean; ALeft: Boolean = True): Integer;
  function ESBinarySearch(const ASet: TES; AValue: Integer): Integer;
  function ESBinaryRangeSearch(const ASet: TES; ALeft, ARight, AValue: Integer): Integer;

implementation

function ESBinarySortSearch(const ASet: TES; AValue: Integer; out AFound: Boolean; ALeft: Boolean = True): Integer;
var
  Left, Right, Mid: Integer;
begin
  Left := 0;
  Right := High(ASet);
  AFound := False;

  while Left <= Right do
  begin
    Mid := (Left + Right) >> 1;
    if AValue = ASet[Mid] then
    begin
      AFound := True;
      Exit(Mid);
    end;

    if AValue < ASet[Mid] then
      Right := Mid - 1
    else
      Left := Mid + 1;
  end;

  if ALeft then
    Result := Left
  else
    Result := Right;
end;

function ESBinarySearch(const ASet: TES; AValue: Integer): Integer;
begin
  Result := ESBinaryRangeSearch(ASet, Low(ASet), High(ASet), AValue);
end;

function ESBinaryRangeSearch(const ASet: TES; ALeft, ARight, AValue: Integer): Integer;
var
  Left, Right, Mid: Integer;
begin
  Left := ALeft;
  Right := ARight;

  while Left <= Right do
  begin
    Mid := (Left + Right) >> 1;
    if AValue = ASet[Mid] then
      Exit(Mid);

    if AValue < ASet[Mid] then
      Right := Mid - 1
    else
      Left := Mid + 1;
  end;
  Result := -1;
end;

end.

