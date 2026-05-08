unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;
type
  TTestBase84 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    out_path:string;
  end;

var
  TestBase84: TTestBase84;

implementation

uses
  KTN_Base64, KTN_Utils, KTN_Base64_native;

{$R *.dfm}

procedure TTestBase84.BitBtn1Click(Sender: TObject);
var
    m:TMemoryStream;
    base64:string;
    out_file:string;
    start:double;
begin
    if (OpenDialog1.Execute()) then begin
        start:=KTN_Utils.KTNUtils.getTimeSec();

        m:=TMemoryStream.Create();
        m.LoadFromFile(OpenDialog1.FileName);

        m.Position:=0;
//        base64:=KTN_Base64.StreamToBase64(m);
        base64:=KTN_Base64_native.StreamToBase64(m);
        memo1.Lines.Add(base64);
        m.Position:=0;
        m.Free;


        m:=TmemoryStream.Create();
//        KTN_Base64.Base64ToStream(base64,m);
        KTN_Base64_native.Base64ToStream(base64,m);
        out_file:=out_path+'\tmp.'+KTN_Utils.KTNUtils.Extension(OpenDialog1.FileName);
        memo1.Lines.Add(out_file);
        m.SaveToFile(out_file);

        m.Free;
        Memo1.Lines.Add(Format('time (native): %f sec',[KTNUtils.getTimeSec()-start]));

    end;

end;

procedure TTestBase84.FormCreate(Sender: TObject);
begin
  out_path:=GetCurrentDir();
  OpenDialog1.InitialDir:='E:\work\karniz-template-notes\examples\simple\media';

end;

procedure TTestBase84.Button1Click(Sender: TObject);
var
    m:TMemoryStream;
    base64:string;
    out_file:string;
    start:double;
begin
    if (OpenDialog1.Execute()) then begin

        start:=KTN_Utils.KTNUtils.getTimeSec();

        m:=TMemoryStream.Create();
        m.LoadFromFile(OpenDialog1.FileName);

        m.Position:=0;
        base64:=KTN_Base64.StreamToBase64(m);
//        base64:=KTN_Base64_native.StreamToBase64(m);
        memo1.Lines.Add(base64);
        m.Position:=0;
        m.Free;


        m:=TmemoryStream.Create();
        KTN_Base64.Base64ToStream(base64,m);
//        KTN_Base64_native.Base64ToStream(base64,m);
        out_file:=out_path+'\tmp.'+KTN_Utils.KTNUtils.Extension(OpenDialog1.FileName);
        memo1.Lines.Add(out_file);
        m.SaveToFile(out_file);

        m.Free;

        Memo1.Lines.Add(Format('time: %f sec',[KTNUtils.getTimeSec()-start]));

    end;
end;

end.
