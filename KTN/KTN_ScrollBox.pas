unit KTN_ScrollBox;
{$I config.inc}

interface
uses
  KTN_MediaItem, StdCtrls, Forms, Controls, ExtCtrls, Classes, SysUtils,
  Graphics;
const MAX_WIDTH = 250;
type

    TKTNDeleteEvent = procedure (Sender: TObject; tag:integer) of object;
    KTNScrollBox = class(TObject)
  private
    public
        class procedure Clear(Container: TScrollBox); static;
        class procedure Add(Owner: TForm; Container: TScrollBox; media:
            TKTNMediaItem; onDelete: TNotifyEvent; onInsert: TNotifyEvent); static;
        class function Count(Container: TScrollBox): Integer; static;
        class procedure Delete(Container: TScrollBox; aIndex: Integer); static;
        class procedure DeleteByTag(Container: TScrollBox; tag: Integer);
            static;
        class function FindByTag(Container: TScrollBox; tag: Integer): TControl;
            static;
        class function Item(Container: TScrollBox; aIndex: Integer): TControl;
        class procedure UpdateAlign(Container: TScrollBox); static;
    end;

implementation

uses
  KTN_consts
  {$IF DEFINED(DEVELOPMENT)},KTN_console{$IFEND} ;

{
********************************* KTNScrollBox *********************************
}
class procedure KTNScrollBox.Add(Owner: TForm; Container: TScrollBox; media:
    TKTNMediaItem; onDelete: TNotifyEvent; onInsert: TNotifyEvent);
var
    Group: TPanel;
    Edit: TEdit;
    Btn: TButton;
    Shape:TShape;
    ctrl: TControl;
    Image: TImage;
    x, y: Integer;
    dy: Integer;
    height: Integer;
    width:integer;
    i: Integer;
    gap:integer;
begin
    x:=5;
    y:=5;
    dy:=32;
    gap:=2;
    height:=10;
    width:=MAX_WIDTH-36;

    //------------------------------------------------
    Group := TPanel.Create(Owner);
    Group.Parent := Container; // ”казываем, где он по€витс€
    Group.ShowCaption:=false;
    Group.BorderStyle:=bsSingle;
    Group.BevelOuter:=bvNone;
    Group.Left:=5;
    Group.Height := 100;
    Group.Width:=MAX_WIDTH-24;
    Group.Tag:=media.Tag;

    //------------------------------------------------
    Edit := TEdit.Create(Owner);
    Edit.Parent := Group;
    Edit.Text := media.MediaType+' '+IntToStr(media.Tag);
    Edit.ReadOnly:=true;
    Edit.Color:=clBtnFace;
    Edit.BorderStyle:=bsNone;
    Edit.Alignment:=taCenter;
    Edit.Font.Style:=[fsBold];

    Edit.Left:=x;
    Edit.Top:=y;
    Edit.Width:=width;

    y:=y+Edit.Height+gap;
    height:=Edit.Top+Edit.height;

    //------------------------------------------------
    Edit := TEdit.Create(Owner);
    Edit.Parent := Group;       // Parent Ч именно GroupBox!
    Edit.Text := media.FileName;
    Edit.ReadOnly:=true;

    Edit.Left:=x;
    Edit.Top:=y;
    Edit.Width:=width;

    y:=y+Edit.Height+gap;
    height:=Edit.Top+Edit.height;
    //------------------------------------------------
    Btn := TButton.Create(Owner);
    Btn.Parent := Group;
    Btn.Caption := 'вставить в код';
    Btn.OnClick := onInsert;
    Btn.Tag:=media.Tag;

    Btn.Left:=x;
    Btn.Top:=y;
    Btn.Width:=width;

    y:=y+Btn.Height+gap;
    height:=Btn.Top+Btn.height;
    //------------------------------------------------


    if (media.MediaType = KTN_consts.MEDIA_TYPE_IMAGE) then begin

        Image := TImage.Create(Owner);
        Image.Parent := Group;        // Parent Ч именно GroupBox!
        Image.Proportional := True;
        Image.Stretch := True;
        media.AssignToImage(Image);


        Image.Left:=x;
        Image.Top:=y;
        Image.Height:=100;
        Image.Width:=width;

        y:=y+Image.Height+gap;
        height:=Image.Top+Image.height;
    end;

    //------------------------------------------------

    Btn := TButton.Create(Owner);
    Btn.Parent := Group;
    Btn.Caption := 'удалить [x]';
    Btn.OnClick := onDelete;
    Btn.Tag:=media.Tag;

    Btn.Left:=x;
    Btn.Top:=y;
    Btn.Width:=width;

    y:=y+Btn.Height+gap;
    height:=Btn.Top+Btn.height;
    //------------------------------------------------
//    Shape := TShape.Create(Owner);
//    Shape.Parent := Group;
//
//    Shape.Left:=x;
//    Shape.Height:=2;
//    Shape.Top:=y;
//    Shape.Width:=width;
//
//    y:=y+Shape.Height+gap;
//    height:=Shape.Top+Shape.height;
    //------------------------------------------------

    Group.Height:=height+10;
    UpdateAlign(Container);
end;

class function KTNScrollBox.Count(Container: TScrollBox): Integer;
begin
    result:=Container.ControlCount;
end;

class procedure KTNScrollBox.Delete(Container: TScrollBox; aIndex: Integer);
var
    obj: TControl;
begin
    obj := Item(Container,aIndex);
    obj.Free;
end;

class procedure KTNScrollBox.Clear(Container: TScrollBox);
var
    obj: TControl;
begin
    while( Container.ControlCount>0) do
    begin
        obj := Item(Container,Container.ControlCount-1);
        obj.Free;
    end;
end;

class procedure KTNScrollBox.DeleteByTag(Container: TScrollBox; tag: Integer);
var
    obj: TControl;
    i: Integer;
begin
    for i:=0 to Container.ControlCount - 1 do begin
        obj := Container.Controls[i];
        if (obj.tag = tag) then begin
            obj.Free;
            break;
        end;
    end;
    UpdateAlign(Container);
end;

class function KTNScrollBox.FindByTag(Container: TScrollBox; tag: Integer):
    TControl;
var
    i: Integer;
begin
    for i:=0 to Count(Container)-1 do begin
        result:=Item(Container,i);
        if (result.tag = tag) then
            exit;
    end;

    result:=nil;
end;

class function KTNScrollBox.Item(Container: TScrollBox; aIndex: Integer):
    TControl;
begin
    result:=Container.Controls[aIndex];
end;

class procedure KTNScrollBox.UpdateAlign(Container: TScrollBox);
var
    ctrl: TControl;
    i: Integer;
    y: Integer;
    gap:integer;
begin
    y:=5;
    gap:=10;
    for i:=0 to Container.ControlCount-1 do begin
        ctrl:=Container.Controls[i];
        ctrl.top:=y;
        y:=ctrl.height + y+gap;
    end;
end;

end.
