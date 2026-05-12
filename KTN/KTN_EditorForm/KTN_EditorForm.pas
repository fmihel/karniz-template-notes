unit KTN_EditorForm;
{$I ../config.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, KTN_Data, StdCtrls, KTN_MediaList, KTN_MediaItem, ExtCtrls,
  ActnList, ComCtrls, OleCtrls, SHDocVw;

type
  TKTNEditorForm = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    ScrollBox1: TScrollBox;
    Panel3: TPanel;
    ActionList1: TActionList;
    actSave: TAction;
    Panel4: TPanel;
    actAddMedia: TAction;
    Button3: TButton;
    actClose: TAction;
    Button4: TButton;
    actTemplate1: TAction;
    Button5: TButton;
    actClearHtml: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    WebBrowser1: TWebBrowser;
    template_html: TMemo;
    template1: TMemo;
    procedure actAddMediaExecute(Sender: TObject);
    procedure actClearHtmlExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actTemplate1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
  private
    { Private declarations }

    tmpfile:string;
    procedure doDelete(Sender:TObject);
    procedure doInsert(Sender:TObject);
    procedure generate_page_for_view();
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
  {$IF DEFINED(BASE64_NATIVE)},KTN_Base64_native {$ELSE},KTN_Base64 {$IFEND}
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND}, KTN_Utils, KTN_consts,
  StrUtils;

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

procedure TKTNEditorForm.actAddMediaExecute(Sender: TObject);
var
    media:TKTNMediaItem;
begin
    if (OpenDialog1.Execute()) then
    begin
        media:=TKTNMediaItem.Create();
        media.LoadFromFile(OpenDialog1.FileName);
        MediaList.Add(media);
        KTNScrollBox.Add(self,ScrollBox1,media,doDelete,doInsert);
    end;

end;

procedure TKTNEditorForm.actClearHtmlExecute(Sender: TObject);
begin
    Memo1.Lines.Clear;
end;

procedure TKTNEditorForm.actCloseExecute(Sender: TObject);
begin
    dlg_result:=false;
    close();
end;

procedure TKTNEditorForm.actSaveExecute(Sender: TObject);
begin
    dlg_result:=true;
    close();
end;

procedure TKTNEditorForm.actTemplate1Execute(Sender: TObject);
begin
    Memo1.Lines.Clear;
    Memo1.Lines.Add(template1.Lines.Text);
end;

procedure TKTNEditorForm.FormCreate(Sender: TObject);
begin
    MediaList:=TKTNMediaList.Create();
    OpenDialog1.InitialDir:=GetCurrentDir();
    dlg_result:=false;
    tmpfile:=GetCurrentDir()+'\_tmp_.html';
end;

procedure TKTNEditorForm.generate_page_for_view;
var html:TStringList;
    code:string;
    media:TKTNMediaItem;
    base64:string;
    i:integer;
begin
    html:=TStringList.Create;
    try
        code:=Memo1.Lines.Text;
        for i:=0 to MediaList.Count-1 do
        begin
            media:=MediaList.Item[i];
            if (media.MediaType = KTN_consts.MEDIA_TYPE_IMAGE) then
            begin
                base64:='data:image/'+KTNUtils.Extension(media.FileName)+';base64,'+StreamToBase64(media.Data);
                code:=StrUtils.ReplaceStr(code,'#'+IntToStr(media.tag)+'#',base64);
            end;

        end;

        text:=template_html.Lines.Text;
        text:=StrUtils.ReplaceStr(text,'#INSERT#',code);

        html.Add(text);
        html.SaveToFile(tmpfile);

        WebBrowser1.Navigate(tmpfile);
    finally
        html.Free;
    end;


end;

function TKTNEditorForm.getHtml: string;
begin
    result:=Memo1.Lines.Text;
end;

function TKTNEditorForm.getMedia():string;
begin
    result:=MediaList.asJSON();
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

    MediaList.fromJSON(media);
    for i:=0 to MediaList.Count-1 do begin
        KTNScrollBox.Add(self,ScrollBox1,MediaList.Item[i],doDelete,doInsert);
    end;

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
    KTNScrollBox.UpdateAlign(ScrollBox1);
end;

procedure TKTNEditorForm.doInsert(Sender: TObject);
var
    tag:integer;
    media:TKTNMediaItem;
    code:string;
begin
    {$IF DEFINED(DEVELOPMENT)}
    console.log('insert',TControl(Sender).tag);
    {$IFEND}

    tag:=TControl(Sender).tag;
    media:=MediaList.FindByTag(tag);
    if (media<>nil) then begin
        if (media.MediaType = KTN_consts.MEDIA_TYPE_IMAGE) then begin
            code:='<img src="#'+IntToStr(media.tag)+'#" />';
        end;
        if (media.MediaType = KTN_consts.MEDIA_TYPE_VIDEO) then begin
            code:='<video src="#'+IntToStr(media.tag)+'#" ></video>';
        end;



        if (code<>'') then
            KTNUtils.InsertTextAtCursor(Memo1,code);

    end;

end;

procedure TKTNEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if (FileExists(tmpfile)) then
        DeleteFile(tmpfile);
end;

procedure TKTNEditorForm.FormPaint(Sender: TObject);
begin
    Panel4.Width:=KTN_ScrollBox.MAX_WIDTH;
end;

procedure TKTNEditorForm.TabSheet2Show(Sender: TObject);
begin
    generate_page_for_view();
end;

end.
