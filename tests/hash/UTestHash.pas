unit UTestHash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm30 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form30: TForm30;

implementation

uses
  UHash, KTN_console;

{$R *.dfm}

procedure TForm30.BitBtn1Click(Sender: TObject);
var
    h:THash;
    json:string;
begin
    h:=Hash(['name',10]);
    json:=      h.toJSON();
    console.log(json);

    json:='{"test":10}';
    h.fromJSON(json);

    console.log('test',h.Value['test']);

    FreeHash(h);
end;

procedure TForm30.BitBtn2Click(Sender: TObject);
var h:THash;
    json:string;
begin

    h:=Hash();
    try
        json:='{"name":10,"a":{"b":1}}';

        h.fromJSON(json);

        console.log(h.Hash['a'].Value['b']);

    except
    on e:Exception do
    begin
    	console.log(e.Message);
    end;
    end;

    FreeHash(h);

end;

procedure TForm30.BitBtn3Click(Sender: TObject);
var h:THash;
    json:string;

begin

    h:=Hash();
    try
        json:='[{"name":"me1"},{"name":"me2"}]';
//        json:='{"name":10,"a":[1,2]}';
        if (h.fromJSON(json) = hjprOk) then
            console.log(h.Value[0])
        else
            raise Exception.Create('error parsing :( ');



    except
    on e:Exception do
    begin
    	console.log(e.Message);
    end;
    end;

    FreeHash(h);

end;

end.
