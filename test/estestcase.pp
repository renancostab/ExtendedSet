unit ESTestCase;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FpcUnit,
  TestRegistry,
  ExtendedSet;

type

  { TTestExtendedSet }

  TTestExtendedSet = class(TTestCase)
  published
    procedure Equal;
    procedure NotEqual;
    procedure HasIntersection;
    procedure NoIntersection;
    procedure Addition;
    procedure Subtraction;
    procedure ContainValue;
    procedure ContainSet;
    procedure NotContainValue;
    procedure NotContainSet;
    procedure AssignSet;
    procedure AssignSetIndex;
    procedure SortSet;
    procedure IncludeValueOverLimit;
    procedure Include;
  end;

implementation



{ TTestExtendedSet }

procedure TTestExtendedSet.Addition;
var
  A: TES;
  B: TES;
  C: TES;
begin
  A := [1, 2, 3];
  B := [3, 4, 5];
  C := A + B;

  CheckTrue(C = [1, 2, 3, 4, 5], 'A + B = [1, 2, 3, 4, 5]');
end;

procedure TTestExtendedSet.AssignSet;
var
  A: TES;
  B: TES;
begin
  A := [40, 45, 65];
  B := Default(TES);
  ESAssign(A, B);

  CheckTrue(B = [40, 45, 65], 'A should be equal B');
end;

procedure TTestExtendedSet.AssignSetIndex;
var
  A: TES;
  B: TES;
begin
  A := [1, 2, 5, 6, 10, 11, 55, 120];
  B := Default(TES);
  ESIndexAssign(A, 3, B);
  CheckTrue(B = [6, 10, 11, 55, 120], 'B = [6, 10, 11, 55, 120]');
end;

procedure TTestExtendedSet.ContainSet;
var
  A: TES;
  B: TES;
begin
  A := [10, 20, 30];
  B := [20, 30];

  CheckTrue(A <= B, 'A contains B');
end;

procedure TTestExtendedSet.ContainValue;
var
  A: TES;
begin
  A := [1, 2, 5, 6, 10, 11];
  CheckTrue(A <= 11, 'A <= 11 -> True');
end;

procedure TTestExtendedSet.Equal;
var
  A: TES;
  B: TES;
begin
  A := [10, 20, 30];
  B := [10, 20, 30];

  CheckTrue(ESEqual(A, B), 'A should be equal B');
end;

procedure TTestExtendedSet.Include;
var
  A: TES;
begin
  A := Default(TES);
  ESInclude(A, 40);
  ESInclude(A, 10);
  ESInclude(A, 30);
  ESInclude(A, 20);
  ESInclude(A, 50);

  CheckTrue(A = [10, 20, 30, 40, 50], 'A = [10, 20, 30, 40, 50]');
end;

procedure TTestExtendedSet.HasIntersection;
var
  A: TES;
  B: TES;
  C: TES;
begin
  A := [10, 20, 30];
  B := [30, 40, 50];
  C := A * B;
  CheckTrue(C = [30], 'Intersection 30');
end;

procedure TTestExtendedSet.IncludeValueOverLimit;
const
  VALUE = 75689;
var
  A: TES;
begin
  A := [10, 20, 30];
  ESInclude(A, VALUE);

  CheckTrue(A[High(A)] = VALUE, 'OverLimit ' + VALUE.ToString());
end;

procedure TTestExtendedSet.NoIntersection;
var
  A: TES;
  B: TES;
  C: TES;
begin
  A := [10, 20, 30];
  B := [35, 40, 50];
  C := A * B;

  CheckTrue(C = [], 'No intersection A * B');
end;

procedure TTestExtendedSet.NotContainSet;
var
  A: TES;
  B: TES;
begin
  A := [1, 2, 3];
  B := [4, 5, 6];

  CheckFalse(A <= B, 'A not contains B');
end;

procedure TTestExtendedSet.NotContainValue;
var
  A: TES;
begin
  A := [1, 2, 3];
  CheckFalse(A <= 10, 'A <= 10 -> False');
end;

procedure TTestExtendedSet.NotEqual;
var
  A: TES;
  B: TES;
begin
  A := [1, 2, 3];
  B := [1, 2, 3, 4];
  CheckFalse(ESEqual(A, B), 'A is not equal B');
  CheckFalse(A = [1, 2, 3, 4], 'A is not equal [1, 2, 3, 4]');
end;

procedure TTestExtendedSet.SortSet;
var
  A: TES;
begin
  A := Default(TES);
  ESIncludeNonOrdered(A, 20);
  ESIncludeNonOrdered(A, 10);
  ESIncludeNonOrdered(A, 40);
  ESIncludeNonOrdered(A, 5);
  ESIncludeNonOrdered(A, 2);
  ESIncludeNonOrdered(A, 55);

  ESSort(A);
  CheckTrue(A = [2, 5, 10, 20, 40, 55], 'A = [2, 5, 10, 20, 40, 55]');
end;

procedure TTestExtendedSet.Subtraction;
var
  A: TES;
  B: TES;
  C: TES;
begin
  A := [1, 2, 3, 7, 10];
  B := [1, 2, 4];
  C := A - B;
  CheckTrue(C = [3, 7, 10], 'C = [3, 7, 10]');
end;

initialization
  RegisterTest(TTestExtendedSet);

end.

