program TestExcept;

uses
  Forms,
  UTestExcept in 'UTestExcept.pas' {TestExcept},
  KTN_console in '..\..\KTN\KTN_console.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(UTestExcept.TTestExcept, UTestExcept.TestExcept);

  Application.Run;
end.
