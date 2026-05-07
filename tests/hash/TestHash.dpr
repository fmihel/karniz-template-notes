program TestHash;

uses
  Forms,
  UTestHash in 'UTestHash.pas' {Form30},
  UHash in '..\..\KTN\utils\UHash.pas',
  uLkJSON in '..\..\KTN\utils\uLkJSON.pas',
  UUtils in '..\..\KTN\utils\UUtils.pas',
  KTN_console in '..\..\KTN\KTN_console.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm30, Form30);
  Application.Run;
end.
