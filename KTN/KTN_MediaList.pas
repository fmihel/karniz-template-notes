unit KTN_MediaList;
{$I ./config.inc}

interface

uses
  Classes, KTN_MediaItem;

type
    TKTNMediaList = class(TObject)
    private
        fList: TList;
        function getCount: Integer;
        function getItem(Index: Integer): TKTNMediaItem;
    public
        constructor Create;
        destructor Destroy; override;
        function Add(aObject:TKTNMediaItem): TKTNMediaItem;
        procedure Clear;
        procedure Delete(aIndex: Integer = -1);
        function IndexOf(aObject: TKTNMediaItem): Integer;
        procedure Remove(aObject:TKTNMediaItem);
        property Count: Integer read getCount;
        property Item[Index: Integer]: TKTNMediaItem read getItem;
    end;

implementation
{$IF DEFINED(DEVELOPMENT)}uses KTN_console; {$IFEND}
{
********************************* KTNMediaList *********************************
}
constructor TKTNMediaList.Create;
begin
    fList :=TList.Create;
end;

destructor TKTNMediaList.Destroy;
begin
    Clear ;
    fList .Free;
end;

function TKTNMediaList.Add(aObject:TKTNMediaItem): TKTNMediaItem;
begin
    try
        result:=aObject;
        fList .Add(result);
    except
        result:=nil;
    end;
end;

procedure TKTNMediaList.Clear;
begin
    Delete (-1);
end;

procedure TKTNMediaList.Delete(aIndex: Integer = -1);
var
    obj: TKTNMediaItem;
begin
    if aIndex = -1 then
    begin
        while fList .Count>0 do
        begin
            obj:=TKTNMediaItem(fList.Items[fList.Count-1]);
            obj.Free;
            fList.Delete(fList.Count -1);
        end
    end
    else
    begin
        obj:=TKTNMediaItem(fList.Items[aIndex]);
        obj.Free;
        fList.Delete(aIndex);
    end;
end;

function TKTNMediaList.getCount: Integer;
begin
    result:=fList .Count;
end;

function TKTNMediaList.getItem(Index: Integer): TKTNMediaItem;
begin
    result:=TKTNMediaItem(fList.Items[Index]);
end;

function TKTNMediaList.IndexOf(aObject: TKTNMediaItem): Integer;
begin
    result:=fList.IndexOf(aObject);
end;

procedure TKTNMediaList.Remove(aObject:TKTNMediaItem);
begin
    fList.Remove(aObject);
end;


end.
