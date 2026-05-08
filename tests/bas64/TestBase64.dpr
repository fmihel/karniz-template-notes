program TestBase64;

uses
  Forms,
  UMain in 'UMain.pas' {TestBase84},
  KTN_Base64 in '..\..\KTN\KTN_Base64.pas',
  KTN_Base64_native in '..\..\KTN\KTN_Base64_native.pas',
  KTN_Utils in '..\..\KTN\KTN_Utils.pas',
  KTN_consts in '..\..\KTN\KTN_consts.pas',
  KTN_console in '..\..\KTN\KTN_console.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestBase84, TestBase84);
  Application.Run;
end.
