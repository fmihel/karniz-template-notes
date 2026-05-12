unit KTN_MediaItem;
{$I config.inc}
interface

uses
  Classes, ExtCtrls, Graphics;


type
    TKTNMediaItem = class(TObject)
    private
        fData: TMemoryStream;
        fFileName: string;
        fMediaType: string;
        fTag: Integer;
    public
        constructor Create;
        destructor Destroy; override;
        function asJSON: string;
        procedure AssignToImage(Image: TImage);
        procedure fromJSON(const aJson: string);
        procedure LoadFromFile(const aFileName: string);
        procedure SaveToFile(const aFileName: string);
        property Data: TMemoryStream read fData write fData;
        property FileName: string read fFileName write fFileName;
        property MediaType: string read fMediaType write fMediaType;
        property Tag: Integer read fTag write fTag;
    end;

implementation

uses
  KTN_consts, KTN_Utils, jpeg, pngimage
  {$IF DEFINED(BASE64_NATIVE)},KTN_Base64_native {$ELSE},KTN_Base64 {$IFEND}
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND}, SysUtils, KTN_JSON;

{
******************************** TKTNMediaItem *********************************
}
constructor TKTNMediaItem.Create;
begin
    inherited Create;
    fData:=TMemoryStream.create();
    fMediaType:=KTN_consts.MEDIA_TYPE_UNDEF;
    fTag:=KTNUtils.NewTag();
end;

destructor TKTNMediaItem.Destroy;
begin
    fData.Free();
    inherited Destroy;
end;

function TKTNMediaItem.asJSON: string;
begin
    result:='{';
    result:=result+KTNJSON.param('Tag',IntToStr(self.fTag),false);
    result:=result+KTNJSON.param('FileName',self.fFileName);
    result:=result+KTNJSON.param('MediaType',self.fMediaType);
    result:=result+KTNJSON.param('Data',StreamToBase64(fData));
    result:=result+'}';
end;

procedure TKTNMediaItem.AssignToImage(Image: TImage);
var
    NewGraphic: TGraphic;
    Ext: string;
begin
    if (fMediaType = MEDIA_TYPE_IMAGE) then
    begin
        Ext := KTNUtils.Extension(fFileName);
        NewGraphic := nil;

        // Создаем объект нужного класса в зависимости от расширения
        if (Ext = 'jpg') or (Ext = 'jpeg') then NewGraphic := TJPEGImage.Create
        else if (Ext = 'png') then NewGraphic := TPNGImage.Create
        else if (Ext = 'bmp') then NewGraphic := TBitmap.Create
        else Exit; // Неизвестный формат

        try
            fData.Position := 0;
            NewGraphic.LoadFromStream(fData);
            Image.Picture.Assign(NewGraphic);
        finally
            NewGraphic.Free;
        end;
    end;
end;

procedure TKTNMediaItem.fromJSON(const aJson: string);
var
    cData:string;
begin

    fTag:=StrToInt(KTNJSON.parsingJSON(aJson,'Tag'));
    fFileName:=KTNJSON.parsingJSON(aJson,'FileName');
    fMediaType:=KTNJSON.parsingJSON(aJson,'MediaType');
    cData:=KTNJSON.parsingJSON(aJson,'Data');
    Base64ToStream(cData,fData);

end;

procedure TKTNMediaItem.LoadFromFile(const aFileName: string);
begin
    fData.Clear;
    fData.Position:=0;
    fData.LoadFromFile(aFileName);
    fFileName:=aFileName;
    fMediaType:=KTNUtils.MediaType(aFileName);


end;

procedure TKTNMediaItem.SaveToFile(const aFileName: string);
begin
    fData.Position:=0;
    fData.SaveToFile(aFileName);
end;

//procedure TKTNMediaItem.AssignToImage(Image: TImage);
//begin
//    if (fMediaType = MEDIA_TYPE_IMAGE) then
//    begin
//        fData.Position:=0;
//        Image.Picture.LoadFromStream(fData);
//    end;
//end;


end.
