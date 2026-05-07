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
        function Add(media: TKTNMediaItem): TKTNMediaItem;
        procedure Clear;
        procedure ConvertFromString(const aData: string);
        function ConvertToString: string;
        procedure Delete(aIndex: Integer);
        procedure DeleteByTag(tag: Integer);
        function FindByTag(tag: Integer): TKTNMediaItem;
        function IndexOf(media: TKTNMediaItem): Integer;
        function Remove(media: TKTNMediaItem): TKTNMediaItem;
        property Count: Integer read getCount;
        property Item[Index: Integer]: TKTNMediaItem read getItem;
    end;

implementation
uses
{$IF DEFINED(BASE64_NATIVE)} KTN_Base64_native {$ELSE} KTN_Base64 {$IFEND}
{$IF DEFINED(DEVELOPMENT)} ,KTN_console {$IFEND};

{
******************************** TKTNMediaList *********************************
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

function TKTNMediaList.Add(media: TKTNMediaItem): TKTNMediaItem;
begin
    try
        result:=media;
        fList.Add(result);
    except
        result:=nil;
    end;
end;

procedure TKTNMediaList.Clear;
begin
    while fList.Count>0 do
        self.Delete(fList.Count-1);
end;

procedure TKTNMediaList.ConvertFromString(const aData: string);
begin
end;

function TKTNMediaList.ConvertToString: string;
var
    i:integer;
    h:
begin
    for i:=0 to fList.Count-1 do
    begin

    end;
end;

procedure TKTNMediaList.Delete(aIndex: Integer);
var
    obj: TKTNMediaItem;
begin
    if ( aIndex>=0 ) and (aIndex<fList.Count) then begin
        obj:=TKTNMediaItem(fList.Items[aIndex]);
        obj.Free;
        fList.Delete(aIndex);
    end;
end;

procedure TKTNMediaList.DeleteByTag(tag: Integer);
var
    obj: TKTNMediaItem;
    i: Integer;
begin
    for i:=0 to fList.Count - 1 do
    begin
        obj:=fList.Items[i];
        if (obj.tag = tag) then begin
            obj.free;
            fList.Delete(i);
            break;
        end;
    end;
end;

function TKTNMediaList.FindByTag(tag: Integer): TKTNMediaItem;
var
    i: Integer;
begin
    for i:=0 to self.Count do begin
       result:=self.Item[i];
       if (result.Tag = tag) then begin
           exit;
       end;
    end;

    result:=nil;
end;

function TKTNMediaList.getCount: Integer;
begin
    result:=fList.Count;
end;

function TKTNMediaList.getItem(Index: Integer): TKTNMediaItem;
begin
    result:=TKTNMediaItem(fList.Items[Index]);
end;

function TKTNMediaList.IndexOf(media: TKTNMediaItem): Integer;
begin
    result:=fList.IndexOf(media);
end;

function TKTNMediaList.Remove(media: TKTNMediaItem): TKTNMediaItem;
begin
    if (media<>nil) then
        fList.Remove(media);

    result:=media;
end;


end.
