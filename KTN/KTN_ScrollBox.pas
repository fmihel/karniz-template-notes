unit KTN_ScrollBox;

interface

uses
  KTN_MediaItem, StdCtrls, Forms, Controls, ExtCtrls;
type
    KTNScrollBox = class(TObject)
    public
        class procedure Add(Owner:TForm;Container:TScrollBox;media: TKTNMediaItem); static;
    end;

implementation

uses
  KTN_consts, uconsole;

{
********************************* KTNScrollBox *********************************
}
class procedure KTNScrollBox.Add(Owner:TForm;Container:TScrollBox;media: TKTNMediaItem);
var
    Group:TGroupBox;
    Edit:TEdit;
    Btn:TButton;
    Image:TImage;

    x,y:integer;
    dy:integer;
begin
    x:=5;
    y:=5;
    dy:=32;


    Group := TGroupBox.Create(Owner);
    Group.Parent := Container; // Указываем, где он появится
    Group.Caption := 'media';
    Group.Align := alTop;       // Чтобы блоки шли друг за другом сверху вниз
    Group.Height := 100;
    Group.Padding.SetBounds(5, 5, 5, 5); // Небольшие отступы внутри

    Edit := TEdit.Create(Owner);
    Edit.Parent := Group;       // Parent — именно GroupBox!
    Edit.Left := x;
    Edit.Top := y;
    Edit.Width := 150;
    Edit.Text := media.FileName;
    Edit.ReadOnly:=true;

    y:=y+dy;

    Btn := TButton.Create(Owner);
    Btn.Parent := Group;        // Parent — именно GroupBox!
    Btn.Left := x;
    Btn.Top := y;   // Немного ровняем по высоте
    Btn.Caption := 'delete';

    y:=y+dy;

    if (media.MediaType = KTN_consts.MEDIA_TYPE_IMAGE) then begin
        Image := TImage.Create(Owner);

        Image.Parent := Group;        // Parent — именно GroupBox!
        Image.Left := x;
        Image.Top := y;   // Немного ровняем по высоте
        Image.Width:=150;
        Image.Height:=50;
        Image.Proportional := True;
        Image.Stretch := True;
//        console.log(media.FileName,media.FileName);
        media.AssignToImage(Image);
    end;

end;

end.
