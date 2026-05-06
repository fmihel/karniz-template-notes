unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KTN_EditorForm, KTN_Type;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    Button1Click(self);

end;

procedure TfrmMain.Button1Click(Sender: TObject);
var data:TKTNType;
begin
    data:=TKTNType.Create;
    data.Note := '<div>text</div>';
    KTN_EditorForm.KTNExecute(data);
    data.Free;


end;

end.
