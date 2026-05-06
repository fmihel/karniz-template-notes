unit uconsole;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, DB;

type
    console = class(TObject)
    private
        class procedure output(const msg: string); static;
        class function VariantToStr(const value: Variant): string; static;
        class function vtype(const value: Variant): string; static;
    public
        class procedure log(val:TDataSet;include: array of string ); overload; static;
        class procedure log(const Args: array of const); overload; static;
        class procedure log(val1: Variant); overload; static;
        class procedure log(val1, val2: Variant); overload; static;
        class procedure log(val1, val2, val3: Variant); overload; static;
        class procedure log(val1, val2, val3, val4: Variant); overload; static;
        class procedure log(val1, val2, val3, val4, val5: Variant); overload;
            static;
        class procedure log(val1, val2, val3, val4, val5, val6: Variant);
            overload; static;
        class procedure log(val1, val2, val3, val4, val5, val6, val7: Variant);
            overload; static;
        class procedure log(val1, val2, val3, val4, val5, val6, val7, val8:
            Variant); overload; static;
        class procedure log(val1, val2, val3, val4, val5, val6, val7, val8,
            val9: Variant); overload; static;
        class procedure log(val1, val2, val3, val4, val5, val6, val7, val8,
            val9, val10: Variant); overload; static;
    end;


implementation
uses Variants, UStr;
{
*********************************** console ************************************
}
class procedure console.log(const Args: array of const);
var
    msg: string;
    I: Integer;
begin
    msg := '';
    for I := 0 to High(Args) do
        with Args[I] do
        case VType of
              vtInteger:    msg := msg +' '+ IntToStr(VInteger);
              vtBoolean:    msg := msg +' '+ BoolToStr(VBoolean);
              vtChar:       msg := msg +' '+ VChar;
              vtExtended:   msg := msg +' '+ FloatToStr(VExtended^);
              vtString:     msg := msg +' '+ VString^;
              vtPChar:      msg := msg +' '+ VPChar;
              vtObject:     msg := msg +' '+ VObject.ClassName;
              vtClass:      msg := msg +' '+ VClass.ClassName;
              vtWideChar:   msg := msg +' '+ VWideChar;
              vtPWideChar:  msg := msg +' '+ VPWideChar;
              vtAnsiString: msg := msg +' '+ string(AnsiString(VAnsiString));
              vtUnicodeString:  msg := msg +' '+ string(UnicodeString(VUnicodeString));
              vtCurrency:   msg := msg +' '+ CurrToStr(VCurrency^);
              vtVariant:    msg := msg +' '+ string(VVariant^);
              vtWideString: msg := msg +' '+ string(WideString(VWideString));
              vtInt64:      msg := msg +' '+ IntToStr(VInt64^);
    end;
    OutputDebugString(PChar(trim(msg)));
end;

class procedure console.log(val1: Variant);
var
    str: string;
begin
    str:=console.VariantToStr(val1);
    console.output(str);
end;

class procedure console.log(val1, val2: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    console.output(str);
end;

class procedure console.log(val1, val2, val3: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    console.output(str);
end;

class procedure console.log(val1, val2, val3, val4: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    str:= str+' '+console.VariantToStr(val4);

    console.output(str);
end;

class procedure console.log(val1, val2, val3, val4, val5: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    str:= str+' '+console.VariantToStr(val4);
    str:= str+' '+console.VariantToStr(val5);

    console.output(str);
end;

class procedure console.log(val1, val2, val3, val4, val5, val6: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    str:= str+' '+console.VariantToStr(val4);
    str:= str+' '+console.VariantToStr(val5);
    str:= str+' '+console.VariantToStr(val6);

    console.output(str);
end;

class procedure console.log(val1, val2, val3, val4, val5, val6, val7: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    str:= str+' '+console.VariantToStr(val4);
    str:= str+' '+console.VariantToStr(val5);
    str:= str+' '+console.VariantToStr(val6);
    str:= str+' '+console.VariantToStr(val7);

    console.output(str);
end;

class procedure console.log(val1, val2, val3, val4, val5, val6, val7, val8:
    Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    str:= str+' '+console.VariantToStr(val4);
    str:= str+' '+console.VariantToStr(val5);
    str:= str+' '+console.VariantToStr(val6);
    str:= str+' '+console.VariantToStr(val7);
    str:= str+' '+console.VariantToStr(val8);

    console.output(str);
end;

class procedure console.log(val1, val2, val3, val4, val5, val6, val7, val8,
    val9: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    str:= str+' '+console.VariantToStr(val4);
    str:= str+' '+console.VariantToStr(val5);
    str:= str+' '+console.VariantToStr(val6);
    str:= str+' '+console.VariantToStr(val7);
    str:= str+' '+console.VariantToStr(val8);
    str:= str+' '+console.VariantToStr(val9);

    console.output(str);
end;

class procedure console.log(val1, val2, val3, val4, val5, val6, val7, val8,
    val9, val10: Variant);
var
    str: string;
begin
    str:= console.VariantToStr(val1);
    str:= str+' '+console.VariantToStr(val2);
    str:= str+' '+console.VariantToStr(val3);
    str:= str+' '+console.VariantToStr(val4);
    str:= str+' '+console.VariantToStr(val5);
    str:= str+' '+console.VariantToStr(val6);
    str:= str+' '+console.VariantToStr(val7);
    str:= str+' '+console.VariantToStr(val8);
    str:= str+' '+console.VariantToStr(val9);
    str:= str+' '+console.VariantToStr(val10);
    console.output(str);
end;

class procedure console.log(val: TDataSet;include: array of string );
const
    crop_field = 15;
    crop_value = 10;

var
    i,j:integer;
    field:string;
    value:string;
    str:string;
    need:boolean;
begin

    str:='|  ';
    for i:=0 to val.Fields.count-1 do
    begin
        field:=val.Fields[i].FieldName;

        need:=true;
        if (High(include)>-1) then
        begin
            need:=false;
            for j:=0 to High(include) do
            begin
                if (include[j] = field) then
                begin
                    need:=true;
                    break;
                end;
            end;
        end;


        if (need) then
        begin
            field:=TStr.CropText(val.Fields[i].FieldName,crop_field,true);
            value:=TStr.CropText(val.Fields[i].AsString,crop_value,true);
//            if (str<>'') then
//                str:=str+'  |  ';
            str:=str+''+field+'='+value+'  |  ';
        end;


    end;
    console.output(str);
end;

class procedure console.output(const msg: string);
begin
    OutputDebugString(PChar(trim(msg)));
end;

class function console.VariantToStr(const value: Variant): string;
var
    vtype: string;
begin
    vtype:=console.vtype(value);

    result:=vtype;

    if ( vtype = 'integer') or (vtype ='smallint') or (vtype='int64')  or (vtype='shortint')  or (vtype='uint64')   or (vtype='byte') then begin
       result:=IntToStr(value);
    end;
    if ( vtype = 'string') or ( vtype = 'ustring') then begin
       result:=VarToStr(value);
    end;

    if ( vtype = 'single') or (vtype='double') then begin
       result:=FloatToStr(value);
    end;
end;

class function console.vtype(const value: Variant): string;
var
    basicType: Integer;
    typeString: string;
begin
     basicType := VarType(value) and VarTypeMask;
     typeString := 'unknown';
      // Установка строки для согласования типа
      case basicType of
        varEmpty     : typeString := 'empty';
        varNull      : typeString := 'null';
        varSmallInt  : typeString := 'smallint';
        varShortInt  : typeString := 'shortint';

        varInteger   : typeString := 'integer';
        varSingle    : typeString := 'single';
        varDouble    : typeString := 'double';
        varCurrency  : typeString := 'currency';
        varDate      : typeString := 'date';
        varOleStr    : typeString := 'olestr';
        varDispatch  : typeString := 'dispatch';
        varError     : typeString := 'error';
        varBoolean   : typeString := 'boolean';
        varVariant   : typeString := 'varvariant';
        varUnknown   : typeString := 'unknown';
        varByte      : typeString := 'byte';
        varWord      : typeString := 'word';
        varLongWord  : typeString := 'longword';
        varInt64     : typeString := 'int64';
        varUInt64    : typeString := 'uint64';
        varStrArg    : typeString := 'strarg';
        varString    : typeString := 'string';
        varUString   : typeString := 'ustring';
        varAny       : typeString := 'any';
        varTypeMask  : typeString := 'typemask';
        varArray     : typeString := 'array';
      end;
    result:=typeString;
end;



end.
