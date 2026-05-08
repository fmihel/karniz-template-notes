unit KTN_Utils;
{$I config.inc}

interface
uses Windows, Dialogs, SysUtils;
type
    KTNUtils = class(TObject)
    public
        class function Extension(const aFileName: string): string; static;
        class function MediaType(const FileName: string): string; static;
        class function NewTag: Integer; static;
        class procedure SetTag(tag: Integer); static;
        class function getTimeSec(const aType:string = 'simple'):double;
    end;

implementation

uses
  KTN_consts
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND};
var global_tag:integer;
{
*********************************** KTNUtils ***********************************
}
class function KTNUtils.Extension(const aFileName: string): string;
begin

    result := LowerCase(ExtractFileExt(aFileName));
    if (result <> '') and (result[1] = '.') then
      Delete(result, 1, 1);

end;

class function KTNUtils.getTimeSec(const aType:string = 'simple'): double;
var
  Frequency, StartCount: Int64;
begin
    if (aType<>'simple') and QueryPerformanceFrequency(Frequency) then
    begin
        QueryPerformanceCounter(StartCount);
        result:=StartCount/Frequency;
    end
    else
    begin
        result:= GetTickCount / 1000;
    end;
end;

class function KTNUtils.MediaType(const FileName: string): string;
var
    Ext: string;
begin
    // Извлекаем расширение и переводим в нижний регистр
    Ext := Extension(FileName);

    if (Ext = 'jpg') or (Ext = 'jpeg') or (Ext = 'bmp') or (Ext = 'png') then
        Result := KTN_consts.MEDIA_TYPE_IMAGE
    else if (Ext = 'mpg') or (Ext = 'mp4') or (Ext = 'avi') then
        Result := KTN_consts.MEDIA_TYPE_VIDEO
    else
        Result := KTN_consts.MEDIA_TYPE_UNDEF;
end;

class function KTNUtils.NewTag: Integer;
begin
    global_tag:=global_tag+1;
    result:=global_tag;
end;


class procedure KTNUtils.SetTag(tag: Integer);
begin
    if (tag>global_tag) then
        global_tag:=tag;
end;

initialization
  global_tag:=0;

end.
