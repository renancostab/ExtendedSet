program DemoES;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, ESAlgorithm, ExtendedSet, CustApp
  { you can add units after this };

type

  { TMyApplication }

  TMyApplication = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
  end;

{ TMyApplication }

procedure TMyApplication.DoRun;
var
  I: Integer;
  A: TES;
  B: TES;
  C: TES;
  D: TES;
  E: TES;
  Start: QWord;
begin
  Randomize;
  WriteLn('Demo that demonstrate how the extended set works');

  A := [10, 20, 35];
  ESInclude(A, 350); // Including a value over the limit
  B := [25, 30, 35];
  ESInclude(B, 350); // Including a value over the limit
  ESInclude(B, 75254); // Including a value over the limit
  C := A * B; // Intersection
  D := A + B;
  E := A - B;

  if A * B <> [] then
     WriteLn('A has an intersection with B');

  WriteLn('The intersection is: ');
  for I := Low(C) to High(C) do
    WriteLn(C[I]);

  if A <> B then
    WriteLn('A is different from B');

  WriteLn('A + B');
  for I := Low(D) to High(D) do
    WriteLn(D[I]);

  WriteLn('A - B');
  for I := Low(E) to High(E) do
    WriteLn(E[I]);

  if A <= 10 then
    WriteLn('10 is contained in A');

  if not (A <= 25) then
    WriteLn('25 is not contained in A');

  WriteLn(EmptyStr);
  WriteLn('Large set intersection A * B, 1M members per set');

  Start := TThread.GetTickCount64;

  A := [];
  B := [];

  SetLength(A, 1000000);
  SetLength(B, 1000000);

  for I := 0 to 1000000 do
  begin
    A[I] := Random(Integer.MaxValue);
    B[I] := Random(Integer.MaxValue);
  end;

  ESSort(A);
  ESSort(B);
  ESRemoveDuplicate(A);
  ESRemoveDuplicate(B);

  C := A * B;
  if C = [] then
    WriteLn('No intersection')
  else
    WriteLn('Intersection of: ', Length(C), ' members');

  if ESEqual(A, B) then
    WriteLn('A = B')
  else
    WriteLn('A <> B');

  if A <= B then
    WriteLn('A <= B')
  else
    WriteLn('A not contains B');

  WriteLn('Time elapsed: ', TThread.GetTickCount64 - Start, ' ms');

  ReadLn;
  Terminate;
end;

var
  Application: TMyApplication;
begin
  Application := TMyApplication.Create(nil);
  Application.Title := 'My Application';
  Application.Run;
  Application.Free;
end.

