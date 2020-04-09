![Version](https://img.shields.io/badge/version-v1.0-yellow.svg)
![License](https://img.shields.io/github/license/renancostab/ExtendedSet.svg)
![Lang](https://img.shields.io/github/languages/top/renancostab/ExtendedSet.svg)

# ExtendedSet

ExtendedSet is a extension of the set usually found in the Lazarus, the main goal is provide the regular set to support values over 250.

## Features: ##

* Compatible with Lazarus/Free Pascal
* Support for x86 and x64
* Operations supported:
  - Contains
  - Intersection
  - Add
  - Sub
  - Equal

## Roadmap: ##

 * Add parallel algorithms

## Performance: ##

The extended set can calculate the intersection of two sets of elements with 1 M each in less than 300 ms in an ordinary cpu, check the demo project for better examples.

## Quick Example ##

```Pascal
unit Demo;

interface

uses
  ExtendSet;

const
  VALUE = 1000000;

var
  A: TES;
  B: TES;
  C: TES;
 
begin
  A := [1, 2, 3, 4]
  B := [4, 5, 6, 7]
  C := A * B; // Intersection
  
  if C = [] then
    WriteLn("No intersection between A and B")
  else
    WriteLn("A has a intersection with B");
        
  A := [];
  B := [];

  SetLength(A, VALUE);
  SetLength(B, VALUE);

  for I := 0 to High(A) do
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
    WriteLn('A contains B')
  else
    WriteLn('A not contains B');    
end.
