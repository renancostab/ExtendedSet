program ESTest;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, ESTestCase, ExtendedSet, ESAlgorithm;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

