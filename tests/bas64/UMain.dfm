object TestBase84: TTestBase84
  Left = 746
  Top = 283
  Caption = 'TestBase84'
  ClientHeight = 452
  ClientWidth = 397
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
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 41
    Caption = 'test'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 184
    Width = 321
    Height = 121
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 72
    Width = 177
    Height = 57
    Caption = 'native'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object OpenDialog1: TOpenDialog
    InitialDir = './../'
    Left = 224
    Top = 8
  end
end
