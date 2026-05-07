unit KTN_ScrollBox;
{$I config.inc}

interface


uses
  KTN_MediaItem, StdCtrls, Forms, Controls, ExtCtrls, Classes;
type

    TKTNDeleteEvent = procedure (Sender: TObject; tag:integer) of object;

    KTNScrollBox = class(TObject)
    public
        class procedure Add(Owner: TForm; Container: TScrollBox; media:
            TKTNMediaItem; onDelete: TNotifyEvent); static;
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
    Image: TImage;
    x, y: Integer;
    dy: Integer;
    height: Integer;
begin
    x:=5;
    y:=5;
    dy:=32;
    height:=10;

    Group := TGroupBox.Create(Owner);
    Group.Parent := Container; // Указываем, где он появится
    Group.Caption := 'media';
    Group.Align := alTop;       // Чтобы блоки шли друг за другом сверху вниз
    Group.Height := 100;
    Group.Padding.SetBounds(5, 5, 5, 5); // Небольшие отступы внутри
    Group.Tag:=media.Tag;

    Edit := TEdit.Create(Owner);
    Edit.Parent := Group;       // Parent — именно GroupBox!
    Edit.Left := x;
    Edit.Top := y;
    Edit.Width := 150;
    Edit.Text := media.FileName;
    Edit.ReadOnly:=true;

    y:=y+dy;
    height:=height+dy;


    Btn := TButton.Create(Owner);
    Btn.Parent := Group;        // Parent — именно GroupBox!
    Btn.Left := x;
    Btn.Top := y;   // Немного ровняем по высоте
    Btn.Caption := 'delete';
    Btn.OnClick := onDelete;

    y:=y+dy;
    height:=height+dy;

    if (media.MediaType = KTN_consts.MEDIA_TYPE_IMAGE) then begin
        Image := TImage.Create(Owner);

        Image.Parent := Group;        // Parent — именно GroupBox!
        Image.Left := x;
        Image.Top := y;   // Немного ровняем по высоте
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
end;

end.
