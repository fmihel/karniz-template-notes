unit KTN_ScrollBox;
{$I config.inc}

interface


uses
  KTN_MediaItem, StdCtrls, Forms, Controls, ExtCtrls, Classes, SysUtils;
type

    TKTNDeleteEvent = procedure (Sender: TObject; tag:integer) of object;
    KTNScrollBox = class(TObject)
  private
    public
        class procedure Clear(Container: TScrollBox); static;
        class procedure Add(Owner: TForm; Container: TScrollBox; media:
            TKTNMediaItem; onDelete: TNotifyEvent); static;
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
    TKTNMediaItem; onDelete: TNotifyEvent);
var
    Group: TGroupBox;
    Edit: TEdit;
    Btn: TButton;
    ctrl: TControl;
    Image: TImage;
    x, y: Integer;
    dy: Integer;
    height: Integer;
    i: Integer;
begin
    x:=5;
    y:=16;
    dy:=32;
    height:=10;

    Group := TGroupBox.Create(Owner);
    Group.Parent := Container; // ”казываем, где он по€витс€
    Group.Caption := media.MediaType+' '+IntToStr(media.Tag);
    Group.Height := 100;
    Group.Padding.SetBounds(5, 5, 5, 5); // Ќебольшие отступы внутри
    Group.Tag:=media.Tag;

    Edit := TEdit.Create(Owner);
    Edit.Parent := Group;       // Parent Ч именно GroupBox!
    Edit.Left := x;
    Edit.Top := y;
    Edit.Width := 150;
    Edit.Text := media.FileName;
    Edit.ReadOnly:=true;

    y:=y+dy;
    height:=height+dy;


    Btn := TButton.Create(Owner);
    Btn.Parent := Group;        // Parent Ч именно GroupBox!
    Btn.Left := x;
    Btn.Top := y;   // Ќемного ровн€ем по высоте
    Btn.Caption := 'delete';
    Btn.OnClick := onDelete;
    Btn.Tag:=media.Tag;

    y:=y+dy;
    height:=height+dy;

    if (media.MediaType = KTN_consts.MEDIA_TYPE_IMAGE) then begin

        Image := TImage.Create(Owner);
        Image.Parent := Group;        // Parent Ч именно GroupBox!
        Image.Left := x;
        Image.Top := y;   // Ќемного ровн€ем по высоте
        Image.Width:=150;
        Image.Height:=100;
        Image.Proportional := True;
        Image.Stretch := True;
    //        console.log(media.FileName,media.FileName);
        media.AssignToImage(Image);

        height:=height+Image.Height;
        y:=y+Image.Height;
    end;

    Group.Height:=height;

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
begin
    y:=5;
    for i:=0 to Container.ControlCount-1 do begin
        ctrl:=Container.Controls[i];
        ctrl.top:=y;
        y:=ctrl.height + y;
    end;
end;

end.
