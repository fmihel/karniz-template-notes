unit KTN_EditorForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, KTN_Type, StdCtrls, KTN_MediaList, KTN_MediaItem;

type
  TKTNEditorForm = class(TForm)
    Memo1: TMemo;
    ScrollBox1: TScrollBox;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    data:TKTNType;
    MediaList:TKTNMediaList;

    procedure dataToForm();
    procedure fromToData();
  public
    { Public declarations }


  end;

var
  KTNEditorForm: TKTNEditorForm;

function KTNExecute(data:TKTNType):boolean;

implementation

uses
  KTN_ScrollBox;

{$R *.dfm}

function KTNExecute(data:TKTNType):boolean;
begin

    KTNEditorForm := TKTNEditorForm.Create(nil);
    KTNEditorForm.data := data;
    KTNEditorForm.dataToForm();

    KTNEditorForm.ShowModal();

    KTNEditorForm.Free();

    result:=true;

end;

procedure TKTNEditorForm.FormCreate(Sender: TObject);
begin
    MediaList:=TKTNMediaList.Create();
    OpenDialog1.InitialDir:=GetCurrentDir();
end;

procedure TKTNEditorForm.Button1Click(Sender: TObject);
var
    media:TKTNMediaItem;
begin
    if (OpenDialog1.Execute()) then
    begin
        media:=TKTNMediaItem.Create();
        media.LoadFromFile(OpenDialog1.FileName);
        MediaList.Add(media);
        KTNScrollBox.Add(self,ScrollBox1,media);
    end;
end;

{ TKTNEditorForm }

procedure TKTNEditorForm.dataToForm;
begin
    Memo1.Lines.Text := self.data.Note;
end;

procedure TKTNEditorForm.fromToData;
begin

end;

end.
