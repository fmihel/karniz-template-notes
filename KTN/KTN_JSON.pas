unit KTN_JSON;

interface

uses
  Classes, SysUtils;
const
    KOV = '"';
type
    KTNJSON = class(TObject)
    public
        class function quotaToHtml(const str:string):string;
        class function removeCR(const str:string):string;

        class function codeHTML(const InputStr: string): string; static;
        class function decodeHTML(const InputStr: string): string; static;
        class function param(aName, value: string; startComma: Boolean = true):
            string; static;
        class procedure parsingArray(const JsonArrayStr: string; List:
            TStringList); static;
        class function parsingJSON(const JsonStr, Key: string): string; static;

    end;

implementation

uses
  StrUtils;

{
*********************************** KTNJSON ************************************
}
class function KTNJSON.codeHTML(const InputStr: string): string;
begin
    Result := InputStr;

    // Порядок замен не имеет значения, так как сущности не содержат заменяемых символов
    Result := StringReplace(Result, '{', '&#123;', [rfReplaceAll]);
    Result := StringReplace(Result, '}', '&#125;', [rfReplaceAll]);
    Result := StringReplace(Result, ':', '&#58;',  [rfReplaceAll]);
    Result := StringReplace(Result, '"', '&#34;',  [rfReplaceAll]);
    Result := StringReplace(Result, '[', '&#91;',  [rfReplaceAll]);
    Result := StringReplace(Result, ']', '&#93;',  [rfReplaceAll]);
    Result := StringReplace(Result, ',', '&#44;',  [rfReplaceAll]);
end;

class function KTNJSON.decodeHTML(const InputStr: string): string;
begin
    Result := InputStr;

    Result := StringReplace(Result, '&#123;', '{', [rfReplaceAll]);
    Result := StringReplace(Result, '&#125;', '}', [rfReplaceAll]);
    Result := StringReplace(Result, '&#58;',  ':', [rfReplaceAll]);
    Result := StringReplace(Result, '&#34;',  '"', [rfReplaceAll]);
    Result := StringReplace(Result, '&#91;',  '[', [rfReplaceAll]);
    Result := StringReplace(Result, '&#93;',  ']', [rfReplaceAll]);
    Result := StringReplace(Result, '&#44;',   ',',[rfReplaceAll]);

    // Дополнительно обрабатываем именованную сущность кавычки, если она придет извне
    Result := StringReplace(Result, '&quot;', '"', [rfReplaceAll]);
end;

class function KTNJSON.param(aName, value: string; startComma: Boolean = true):
    string;
begin
    result:='';
    if (startComma = true) then
        result:=',';
    result:=result+KOV+aName+KOV+':'+KOV+value+KOV;
end;

class procedure KTNJSON.parsingArray(const JsonArrayStr: string; List:
    TStringList);
var
  OpenPos, ClosePos: Integer;
  ObjectData: string;
begin
  List.Clear;
  // Инициализируем позицию поиска с самого начала строки
  OpenPos := Pos('[', JsonArrayStr);
  if OpenPos = 0 then OpenPos := 1; // Защита, если квадратной скобки нет

  // Ищем первую открывающую фигурную скобку
  OpenPos := PosEx('{', JsonArrayStr, OpenPos);

  while OpenPos > 0 do
  begin
    // Ищем соответствующую закрывающую фигурную скобку ПОСЛЕ найденной открывающей
    ClosePos := PosEx('}', JsonArrayStr, OpenPos + 1);

    if ClosePos > 0 then
    begin
      // Вырезаем содержимое вместе со скобками: {xxxx}
      // Если вам нужно БЕЗ скобок xxxx, измените на: Copy(JsonArrayStr, OpenPos + 1, ClosePos - OpenPos - 1);
      ObjectData := Copy(JsonArrayStr, OpenPos, ClosePos - OpenPos + 1);

      // Добавляем очищенный от крайних пробелов объект в список
      List.Add(Trim(ObjectData));

      // Ищем следующую открывающую скобку, начиная с позиции сразу за текущим объектом
      OpenPos := PosEx('{', JsonArrayStr, ClosePos + 1);
    end
    else
    begin
      // Предотвращаем бесконечный цикл, если закрывающая скобка отсутствует
      Break;
    end;
  end;

 end;

class function KTNJSON.parsingJSON(const JsonStr, Key: string): string;
var
    SearchKey: string;
    KeyIdx: Integer;
    ValStart, ValEnd: Integer;
begin
    Result := '';

    // Ищем ключ строго в формате "key" (с кавычками)
    SearchKey := '"' + Key + '"';
    KeyIdx := Pos(SearchKey, JsonStr);

    // Если ключ найден, проверяем, что идет после него
    while KeyIdx > 0 do
    begin
        // Ищем двоеточие сразу после ключа

        ValStart := PosEx(':', JsonStr, KeyIdx + Length(SearchKey));

        if ValStart > 0 then
        begin
          // Ищем открывающую кавычку значения ПОСЛЕ двоеточия
          ValStart := PosEx('"', JsonStr, ValStart + 1);

          if ValStart > 0 then
          begin
            // Ищем закрывающую кавычку значения
            ValEnd := PosEx('"', JsonStr, ValStart + 1);
            if ValEnd > 0 then
            begin
              // Успешно нашли и вырезали значение
              Result := Copy(JsonStr, ValStart + 1, ValEnd - ValStart - 1);
              Exit; // Выходим из функции
            end;
          end;
        end;

        // Защита: если совпадение было ложным (внутри текста), ищем следующее вхождение ключа
      KeyIdx := PosEx(SearchKey, JsonStr, KeyIdx + 1);
    end;
end;


class function KTNJSON.quotaToHtml(const str: string): string;
begin
    result := StringReplace(str, '"', '&#34;',  [rfReplaceAll]);
end;

class function KTNJSON.removeCR(const str: string): string;
begin
    result := StringReplace(str, #13#10, '',  [rfReplaceAll]);
end;

end.
