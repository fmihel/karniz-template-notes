program simple;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  KTN_EditorForm in '..\..\KTN\KTN_EditorForm\KTN_EditorForm.pas' {KTNEditorForm},
  KTN_Data in '..\..\KTN\KTN_Data.pas',
  KTN_MediaItem in '..\..\KTN\KTN_MediaItem.pas',
  KTN_MediaList in '..\..\KTN\KTN_MediaList.pas',
  KTN_consts in '..\..\KTN\KTN_consts.pas',
  KTN_Utils in '..\..\KTN\KTN_Utils.pas',
  KTN_ScrollBox in '..\..\KTN\KTN_ScrollBox.pas',
  KTN_console in '..\..\KTN\KTN_console.pas',
  KTN_Base64 in '..\..\KTN\KTN_Base64.pas',
  KTN_Base64_native in '..\..\KTN\KTN_Base64_native.pas',
  UHash in '..\..\KTN\utils\UHash.pas',
  uLkJSON in '..\..\KTN\utils\uLkJSON.pas',
  UUtils in '..\..\KTN\utils\UUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TKTNEditorForm, KTNEditorForm);
  Application.Run;
end.
