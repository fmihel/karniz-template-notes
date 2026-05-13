unit KTN_Utils;
{$I config.inc}

interface
uses Windows, Dialogs, SysUtils, StdCtrls;
type
    KTNUtils = class(TObject)
    public
        class function Extension(const aFileName: string): string; static;
        class function getTimeSec(const aType:string = 'simple'): Double;
        class procedure InsertTextAtCursor(AMemo: TMemo; const AText: string);
            static;
        class function MediaType(const FileName: string): string; static;
        class function NewTag: Integer; static;
        class procedure SetTag(tag: Integer); static;
        class function ValidHtml(const Html: string): Boolean; static;
        class procedure WrapSelectedText(AMemo: TMemo; const cLeft, cRight:
            string); static;
    end;

implementation

uses
  KTN_consts
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND}, Messages, Classes, StrUtils;
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

class function KTNUtils.getTimeSec(const aType:string = 'simple'): Double;
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

class procedure KTNUtils.InsertTextAtCursor(AMemo: TMemo; const AText: string);
begin
    if AMemo = nil then Exit;

    // Переводим фокус на Memo, чтобы каретка была активна (опционально)
    AMemo.SetFocus;

    // Отправляем сообщение EM_REPLACESEL
    // WParam = 1 означает, что операцию можно будет отменить (Undo)
    // LParam = указатель на вставляемую строку
    SendMessage(AMemo.Handle, EM_REPLACESEL, 1, LPARAM(PChar(AText)));
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
        Result := KTN_consts.MEDIA_TYPE_FILE;
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

class function KTNUtils.ValidHtml(const Html: string): Boolean;
var
    Stack: TStringList;
    p, pEnd, pSpace: Integer;
    Tag, TagName: string;
    IsClosing: Boolean;
begin
    Result := False;
    Stack := TStringList.Create;
    try
      p := Pos('<', Html);
      while p > 0 do
      begin
        // Ищем конец тега
        pEnd := PosEx('>', Html, p + 1);
        if pEnd = 0 then Exit; // Ошибка: тег не закрыт скобкой '>'

        // Вырезаем содержимое между < и >
        Tag := Trim(Copy(Html, p + 1, pEnd - p - 1));

        // Игнорируем комментарии <!-- -->, DOCTYPE и XML декларации <?xml ?>
        if (Tag <> '') and (Tag[1] <> '!') and (Tag[1] <> '?') then
        begin
          // Проверяем, является ли тег закрывающим (начинается с /)
          IsClosing := Tag[1] = '/';

          if IsClosing then
            TagName := Trim(Copy(Tag, 2, MaxInt)) // Убираем символ '/'
          else
          begin
            // Извлекаем имя тега до первого пробела (отсекаем атрибуты)
            pSpace := Pos(' ', Tag);
            if pSpace > 0 then
              TagName := Copy(Tag, 1, pSpace - 1)
            else
              TagName := Tag;
          end;

          TagName := LowerCase(TagName);

          // Игнорируем самозакрывающиеся теги (по стандарту HTML или слэш в конце)
          // Если тег заканчивается на '/', например <img />, он не требует закрытия
          if (Tag[Length(Tag)] <> '/') and
             (TagName <> 'br') and (TagName <> 'img') and (TagName <> 'hr') and
             (TagName <> 'input') and (TagName <> 'meta') and (TagName <> 'link') and
             (TagName <> 'base') and (TagName <> 'area') and (TagName <> 'col') then
          begin
            if IsClosing then
            begin
              // Если это закрывающий тег, он должен совпадать с последним в стеке
              if (Stack.Count > 0) and (Stack[Stack.Count - 1] = TagName) then
                Stack.Delete(Stack.Count - 1)
              else
                Exit; // Ошибка: лишний тег или неверный порядок (например, <b><i></b>)
            end
            else
            begin
              // Открывающий тег кладем в стек
              Stack.Add(TagName);
            end;
          end;
        end;

        // Ищем начало следующего тега
        p := PosEx('<', Html, pEnd + 1);
      end;

      // Если в стеке ничего не осталось — HTML структурно верен
      Result := (Stack.Count = 0);
    finally
      Stack.Free;
    end;
end;

class procedure KTNUtils.WrapSelectedText(AMemo: TMemo; const cLeft, cRight:
    string);
var
    SelectedStr: string;
    OriginalSelStart: Integer;
    NewLength: Integer;
begin
    if AMemo = nil then Exit;

    AMemo.SetFocus;

    // Запоминаем текущую позицию начала выделения
    OriginalSelStart := AMemo.SelStart;

    // Получаем сам выделенный фрагмент (если ничего не выделено, будет пустая строка)
    SelectedStr := AMemo.SelText;

    // Заменяем выделенный текст на новую комбинацию
    AMemo.SelText := cLeft + SelectedStr + cRight;

    // Восстанавливаем выделение вокруг измененного фрагмента
    NewLength := Length(cLeft) + Length(SelectedStr) + Length(cRight);
    AMemo.SelStart := OriginalSelStart;
    AMemo.SelLength := NewLength;
end;

initialization
  global_tag:=0;

end.
