object frmMain: TfrmMain
  Left = 603
  Top = 366
  Caption = 'frmMain'
  ClientHeight = 323
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 316
    Height = 25
    Align = alTop
    Caption = 'open'
    TabOrder = 0
    OnClick = Button1Click
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 75
  end
  object Memo1: TMemo
    Left = 0
    Top = 25
    Width = 316
    Height = 89
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'html'
      '')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 19
  end
  object Memo2: TMemo
    Left = 0
    Top = 114
    Width = 316
    Height = 209
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'media')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    ExplicitTop = 120
  end
end
