unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KTN_EditorForm;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    media:string;
    html:string;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    html := '<div>text</div>';
    media:='';

    Button1Click(self);

end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin

    try
        if (KTN_EditorForm.KTNExecute(html,media)) then begin
             memo1.Lines.Text:=html;
             memo2.Lines.Text:=media;
        end
    finally
    end;

end;

end.
