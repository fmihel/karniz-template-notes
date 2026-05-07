object KTNEditorForm: TKTNEditorForm
  Left = 1100
  Top = 417
  Caption = 'KTNEditorForm'
  ClientHeight = 423
  ClientWidth = 687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 265
    Height = 385
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object ScrollBox1: TScrollBox
    Left = 392
    Top = 8
    Width = 287
    Height = 385
    Align = alCustom
    TabOrder = 1
  end
  object Button1: TButton
    Left = 288
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'media|*.jpg;*.png;*.bmp;*.mp4|*.*|*.*'
    Left = 192
    Top = 32
  end
end
