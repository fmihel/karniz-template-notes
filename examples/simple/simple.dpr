program simple;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  KTN_EditorForm in '..\..\KTN\KTN_EditorForm\KTN_EditorForm.pas' {KTNEditorForm},
  KTN_Type in '..\..\KTN\KTN_Type.pas',
  KTN_MediaItem in '..\..\KTN\KTN_MediaItem.pas',
  KTN_MediaList in '..\..\KTN\KTN_MediaList.pas',
  KTN_consts in '..\..\KTN\KTN_consts.pas',
  KTN_Utils in '..\..\KTN\KTN_Utils.pas',
  KTN_ScrollBox in '..\..\KTN\KTN_ScrollBox.pas',
  uconsole in '..\..\KTN\uconsole.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TKTNEditorForm, KTNEditorForm);
  Application.Run;
end.
