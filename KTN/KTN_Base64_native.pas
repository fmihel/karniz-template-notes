unit KTN_Base64_native;

interface

uses EncdDecd, SysUtils, Classes;

function StreamToBase64(Stream: TStream): string;
procedure Base64ToStream(const Base64Str: string; OutStream: TStream);

implementation

function StreamToBase64(Stream: TStream): string;
var
  Base64Stream: TStringStream;
begin
  Stream.Position := 0; // ѕереходим в начало
  Base64Stream := TStringStream.Create('');
  try
    EncodeStream(Stream, Base64Stream);
    Result := Base64Stream.DataString;
  finally
    Base64Stream.Free;
  end;
end;


procedure Base64ToStream(const Base64Str: string; OutStream: TStream);
var
  InStream: TStringStream;
begin
  InStream := TStringStream.Create(Base64Str, TEncoding.ASCII);
  try
    InStream.Position := 0;
    DecodeStream(InStream, OutStream);
    OutStream.Position := 0; // —брасываем позицию дл€ чтени€
  finally
    InStream.Free;
  end;
end;

end.
