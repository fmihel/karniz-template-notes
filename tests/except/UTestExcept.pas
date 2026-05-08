unit UTestExcept;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TTestExcept = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestExcept: TTestExcept;

implementation

uses
  KTN_console;

{$R *.dfm}

procedure TTestExcept.BitBtn1Click(Sender: TObject);
begin
    console.log('----------------------------');
    console.log('test normal ');
    try
    try
        console.log('try');

    except
    on e:Exception do
    begin

        console.log(e.Message);
    end;
    end;
    finally
        console.log('finally');
    end;

    console.log('after finally');
end;

procedure TTestExcept.BitBtn2Click(Sender: TObject);
begin
    console.log('----------------------------');
    console.log('test normal (no finally section)');
    try
        console.log('try');
    except
    on e:Exception do
    begin
        console.log(e.Message);
    end;
    end;
    console.log('after');

end;

procedure TTestExcept.BitBtn3Click(Sender: TObject);
begin
    console.log('----------------------------');
    console.log('test except (no finally section)');
    try
        console.log('try');
        raise Exception.Create('exception !!');
    except
    on e:Exception do
    begin
        console.log(e.Message);
    end;
    end;
    console.log('after');

end;

procedure TTestExcept.BitBtn4Click(Sender: TObject);
begin
    console.log('----------------------------');
    console.log('test exception ');
    try
    try
        console.log('try');
        raise Exception.Create('exception');

    except
    on e:Exception do
    begin
        console.log(e.Message);
    end;
    end;
    finally
        console.log('finally');
    end;
    console.log('after finally');
end;

procedure TTestExcept.BitBtn5Click(Sender: TObject);
begin
    console.log('----------------------------');
    console.log('test only finally ');
    try
        console.log('try');
        raise Exception.Create('exception');

    finally
        console.log('finally');
    end;
    console.log('after finally no out');

end;

end.
