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

## Performance: ##

The extended set can calculate the intersection of two sets of elements with 1 M each in less than 300 ms in an ordinary cpu. Check the demo project for better examples.

## Quick Example ##

```Pascal
unit Demo;

interface

uses
  ExtendSet;
    
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
    
end.
