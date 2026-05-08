unit KTN_MediaItem;
{$I config.inc}
interface

uses
  Classes, ExtCtrls, Graphics,UHash;


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
        procedure AssignToImage(Image: TImage);
        procedure ConvertFromString(const Data: string);
        function ConvertToString: string;

        procedure AssignToHashParam(aHash:THash;toParam:string);
        procedure AssignFromHashParam(aHash:THash;toParam:string);

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
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND}, SysUtils;

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

procedure TKTNMediaItem.AssignFromHashParam(aHash: THash; toParam: string);
begin

end;

procedure TKTNMediaItem.AssignToHashParam(aHash: THash; toParam: string);
begin

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

procedure TKTNMediaItem.ConvertFromString(const Data: string);
var
    h: THash;
    cData: string;
begin
    h:=Hash();
    h.fromJSON(Data);
    ftag:=h.Int['tag'];
    fFileName:=h.Value['FileName'];
    fMediaType:=h.Value['MediaType'];
    cData:=h.Value['Data'];
    Base64ToStream(cData,fData);
    FreeHash(h);
end;

function TKTNMediaItem.ConvertToString: string;
var
    h: THash;
begin
    h:=Hash([
        'tag',tag,
        'FileName',FileName,
        'MediaType',MediaType,
        'Data',StreamToBase64(fData)
    ]);
    result:=h.toJSON();
    FreeHash(h);
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
