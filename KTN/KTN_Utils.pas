unit KTN_Utils;
{$I config.inc}

interface

type
    KTNUtils = class(TObject)
    public
        class function Extension(const aFileName: string): string; static;
        class function MediaType(const FileName: string): string; static;
        class function NewTag: Integer; static;
    end;

implementation

uses
  KTN_consts, SysUtils
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND};
var global_tag:integer;
{
*********************************** KTNUtils ***********************************
}
class function KTNUtils.Extension(const aFileName: string): string;
begin
    result := LowerCase(ExtractFileExt(aFileName));
end;

class function KTNUtils.MediaType(const FileName: string): string;
var
    Ext: string;
begin
    // Извлекаем расширение и переводим в нижний регистр
    Ext := LowerCase(ExtractFileExt(FileName));
    // Убираем точку в начале (ExtractFileExt возвращает ".jpg")
    if (Ext <> '') and (Ext[1] = '.') then
      Delete(Ext, 1, 1);

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


initialization
  global_tag:=0;

end.
