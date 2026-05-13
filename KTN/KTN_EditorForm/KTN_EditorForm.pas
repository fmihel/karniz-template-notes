unit KTN_EditorForm;
{$I ../config.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, KTN_MediaList, KTN_MediaItem, ExtCtrls,
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
    actBr: TAction;
    actValidate: TAction;
    Button6: TButton;
    actBold: TAction;
    Button7: TButton;
    Button8: TButton;
    procedure actAddMediaExecute(Sender: TObject);
    procedure actBoldExecute(Sender: TObject);
    procedure actBrExecute(Sender: TObject);
    procedure actClearHtmlExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actTemplate1Execute(Sender: TObject);
    procedure actValidateExecute(Sender: TObject);
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
    function YesNo(const msg:string):boolean;
    function inTabHtml:bool;
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

procedure TKTNEditorForm.actBoldExecute(Sender: TObject);
begin
    if (inTabHtml) then begin
        KTNUtils.WrapSelectedText(memo1,'<b>','</b>');
    end;
end;

procedure TKTNEditorForm.actBrExecute(Sender: TObject);
begin
    if (inTabHtml) then begin
        KTNUtils.InsertTextAtCursor(Memo1,'<br>'+#13#10);
    end;
end;

procedure TKTNEditorForm.actClearHtmlExecute(Sender: TObject);
begin
    if (inTabHtml) then
        Memo1.Lines.Clear;
end;

procedure TKTNEditorForm.actCloseExecute(Sender: TObject);
begin
    dlg_result:=false;
    close();
end;

procedure TKTNEditorForm.actSaveExecute(Sender: TObject);

begin
    if (KTNUtils.ValidHtml(Memo1.Lines.Text)) or (YesNo('Внимание! Код не прошел валидацию.'+#13#10+'Все равно сохранить?')) then
    begin
        dlg_result:=true;
        close();
    end;
end;

procedure TKTNEditorForm.actTemplate1Execute(Sender: TObject);
begin
    if (inTabHtml) then begin
        Memo1.Lines.Clear;
        Memo1.Lines.Add(template1.Lines.Text);
    end;
end;

procedure TKTNEditorForm.actValidateExecute(Sender: TObject);
begin
    if (KTNUtils.ValidHtml(Memo1.Lines.Text)) then
        MessageDlg('Код валиден', mtConfirmation, [mbOK],0)
    else
        MessageDlg('Ошибка. Проверьте Ваш код!', mtError, [mbOK],0);
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
    template:string;
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
            end else
            if (media.MediaType = KTN_consts.MEDIA_TYPE_VIDEO) then
            begin
                code:=StrUtils.ReplaceStr(code,'#'+IntToStr(media.tag)+'#',media.FileName);
            end
            else
                code:=StrUtils.ReplaceStr(code,'#'+IntToStr(media.tag)+'#',media.FileName);

        end;

        template:=template_html.Lines.Text;
        template:=StrUtils.ReplaceStr(template,'#INSERT#',code);

        html.Add(template);
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

function TKTNEditorForm.inTabHtml: bool;
begin
    result:=true;
    if PageControl1.ActivePage<>tabSheet1 then
    begin
        ShowMessage('Перейдите во вкладку html');
        result:=false;
    end;
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
        end else
        if (media.MediaType = KTN_consts.MEDIA_TYPE_VIDEO) then begin
            code:='<video>';
            code:=code+'<source src="#'+IntToStr(media.tag)+'#" type="video/mp4"></source>';
            code:=code+'</video>';
        end
        else
            code:='<a href="#'+IntToStr(media.tag)+'#" >'+ExtractFileName(media.FileName)+'</a>';

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

function TKTNEditorForm.YesNo(const msg: string): boolean;
begin
    result:=false;
    if MessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        result:=true;
    end
end;

end.
