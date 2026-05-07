unit KTN_EditorForm;
{$I ../config.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, KTN_Data, StdCtrls, KTN_MediaList, KTN_MediaItem;

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
    data:TKTNData;
    MediaList:TKTNMediaList;

    procedure dataToForm();
    procedure fromToData();

    procedure doDelete(Sender:TObject);
  public
    { Public declarations }


  end;

var
  KTNEditorForm: TKTNEditorForm;

function KTNExecute(data:TKTNData):boolean;

implementation

uses
  KTN_ScrollBox
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND};

{$R *.dfm}

function KTNExecute(data:TKTNData):boolean;
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
        KTNScrollBox.Add(self,ScrollBox1,media,nil);
    end;
end;

{ TKTNEditorForm }

procedure TKTNEditorForm.dataToForm;
begin
    Memo1.Lines.Text := self.data.Note;
end;

procedure TKTNEditorForm.doDelete(Sender: TObject);
begin

end;

procedure TKTNEditorForm.fromToData;
begin

end;

end.
