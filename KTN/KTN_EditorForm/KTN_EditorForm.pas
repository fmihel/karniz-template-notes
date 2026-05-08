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
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }


    procedure doDelete(Sender:TObject);
  public
    { Public declarations }
    dlg_result:boolean;
    MediaList:TKTNMediaList;

    procedure setHtml(const html:string);
    procedure setMedia(const media:string);

    function getHtml():string;
    function getMedia():string;

  end;

var
  KTNEditorForm: TKTNEditorForm;

function KTNExecute(var html:string;var media:string):boolean;

implementation

uses
  KTN_ScrollBox
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND};

{$R *.dfm}

function KTNExecute(var html:string;var media:string):boolean;
begin

    result:=false;
    try
        KTNEditorForm := TKTNEditorForm.Create(nil);
        KTNEditorForm.setHtml(html);
        KTNEditorForm.setMedia(media);

        KTNEditorForm.ShowModal();

        if (KTNEditorForm.dlg_result) then
        begin
            html:=KTNEditorForm.getHtml();
            media:=KTNEditorForm.getMedia();
            result:=true;
        end;

    finally
        KTNEditorForm.Free();
    end;



end;

procedure TKTNEditorForm.FormCreate(Sender: TObject);
begin
    MediaList:=TKTNMediaList.Create();
    OpenDialog1.InitialDir:=GetCurrentDir();
    dlg_result:=false;

end;

function TKTNEditorForm.getHtml: string;
begin
    result:=Memo1.Lines.Text;
end;

function TKTNEditorForm.getMedia():string;
begin
    result:=MediaList.ConvertToString();
end;

procedure TKTNEditorForm.setHtml(const html: string);
begin
    Memo1.Lines.Clear;
    Memo1.Lines.Add(html);
end;

procedure TKTNEditorForm.setMedia(const media: string);
var
    i:integer;
begin
    MediaList.Clear();
    KTNScrollBox.Clear(ScrollBox1);

    MediaList.ConvertFromString(media);
    for i:=0 to MediaList.Count-1 do begin
        KTNScrollBox.Add(self,ScrollBox1,MediaList.Item[i],doDelete);
    end;

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
        KTNScrollBox.Add(self,ScrollBox1,media,doDelete);
    end;
end;

procedure TKTNEditorForm.Button2Click(Sender: TObject);
begin
    dlg_result:=true;
    close();
end;


procedure TKTNEditorForm.doDelete(Sender: TObject);
var
    tag:integer;
begin
    {$IF DEFINED(DEVELOPMENT)}
    console.log('delete',TControl(Sender).tag);
    {$IFEND}

    tag:=TControl(Sender).tag;

    MediaList.DeleteByTag(tag);
    KTNScrollBox.DeleteByTag(ScrollBox1,tag);



end;


end.
