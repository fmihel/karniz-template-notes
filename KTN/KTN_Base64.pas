unit KTN_Base64;

interface

uses
  Classes, SysUtils;

function StreamToBase64(Stream: TStream): string;
procedure Base64ToStream(const Base64Str: string; Stream: TStream);

implementation

const
  B64: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

function StreamToBase64(Stream: TStream): string;
var
  i: Integer;
  Buffer: array[1..3] of Byte;
  InCount: Integer;
  S: AnsiString;
begin
  Result := '';
  if (Stream = nil) or (Stream.Size = 0) then Exit;

  Stream.Position := 0;
  // Предварительно выделяем память (Base64 занимает ~1.33 от оригинала)
  SetLength(S, ((Stream.Size + 2) div 3) * 4);
  i := 1;

  while Stream.Position < Stream.Size do
  begin
    InCount := Stream.Read(Buffer, 3);

    // Первый байт
    S[i] := AnsiChar(B64[((Buffer[1] shr 2) and $3F) + 1]);

    // Второй байт
    if InCount > 1 then
      S[i+1] := AnsiChar(B64[(((Buffer[1] shl 4) or (Buffer[2] shr 4)) and $3F) + 1])
    else
      S[i+1] := AnsiChar(B64[((Buffer[1] shl 4) and $3F) + 1]);

    // Третий байт
    if InCount > 2 then
      S[i+2] := AnsiChar(B64[(((Buffer[2] shl 2) or (Buffer[3] shr 6)) and $3F) + 1])
    else if InCount > 1 then
      S[i+2] := AnsiChar(B64[((Buffer[2] shl 2) and $3F) + 1])
    else
      S[i+2] := '=';

    // Четвертый байт
    if InCount > 2 then
      S[i+3] := AnsiChar(B64[(Buffer[3] and $3F) + 1])
    else
      S[i+3] := '=';

    Inc(i, 4);
  end;

  Result := string(S); // Возвращаем как Unicode string для XML
end;

procedure Base64ToStream(const Base64Str: string; Stream: TStream);
var
  i, j: Integer;
  p: array[1..4] of Integer;
  S: AnsiString;
  Buffer: array[1..3] of Byte;
begin
  if (Base64Str = '') or (Stream = nil) then Exit;

//  Stream.Clear;
  S := AnsiString(Base64Str); // Работаем с 8-битной строкой
  i := 1;
  while i <= Length(S) do
  begin
    for j := 1 to 4 do
    begin
      if (i <= Length(S)) and (S[i] <> '=') then
        p[j] := Pos(string(S[i]), B64) - 1
      else
        p[j] := 0;
      Inc(i);
    end;

    Buffer[1] := (p[1] shl 2) or (p[2] shr 4);
    Buffer[2] := (p[2] shl 4) or (p[3] shr 2);
    Buffer[3] := (p[3] shl 6) or p[4];

    Stream.Write(Buffer, 3);
  end;

  // Обрезаем лишние нулевые байты, если в конце были '='
  if Pos('==', Base64Str) > 0 then Stream.Size := Stream.Size - 2
  else if Pos('=', Base64Str) > 0 then Stream.Size := Stream.Size - 1;

  Stream.Position := 0;
end;

end.

