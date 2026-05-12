object KTNEditorForm: TKTNEditorForm
  Left = 702
  Top = 380
  Caption = 'KTNEditorForm'
  ClientHeight = 458
  ClientWidth = 758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 758
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitWidth = 687
    object Button4: TButton
      Left = 2
      Top = 3
      Width = 75
      Height = 32
      Action = actTemplate1
      TabOrder = 0
    end
    object Button5: TButton
      Left = 83
      Top = 3
      Width = 75
      Height = 32
      Action = actClearHtml
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 758
    Height = 376
    Align = alClient
    Caption = 'Panel2'
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 33
    ExplicitWidth = 687
    ExplicitHeight = 304
    object Panel4: TPanel
      Left = 502
      Top = 6
      Width = 250
      Height = 364
      Margins.Right = 10
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel4'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      ExplicitLeft = 431
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 250
        Height = 332
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
      end
      object Button1: TButton
        Left = 0
        Top = 332
        Width = 250
        Height = 32
        Action = actAddMedia
        Align = alBottom
        TabOrder = 1
        ExplicitTop = 339
        ExplicitWidth = 249
      end
    end
    object PageControl1: TPageControl
      Left = 6
      Top = 6
      Width = 496
      Height = 364
      ActivePage = TabSheet1
      Align = alClient
      DoubleBuffered = True
      MultiLine = True
      ParentDoubleBuffered = False
      TabOrder = 1
      TabPosition = tpBottom
      ExplicitLeft = 10
      object TabSheet1: TTabSheet
        BorderWidth = 4
        Caption = 'Html'
        ExplicitWidth = 417
        ExplicitHeight = 330
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 480
          Height = 330
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Lines.Strings = (
            '<div class="ktn-note"'#39'>'
            '    <div head>'#1047#1040#1043#1054#1051#1054#1042#1054#1050'</div>'
            #39'    <div note>'#1054#1055#1048#1057#1040#1053#1048#1045'</div>'
            '</div>')
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
          ExplicitLeft = -1
          ExplicitTop = -3
        end
      end
      object TabSheet2: TTabSheet
        BorderWidth = 3
        Caption = #1087#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088
        ImageIndex = 1
        OnShow = TabSheet2Show
        ExplicitLeft = 2
        ExplicitTop = 0
        object WebBrowser1: TWebBrowser
          Left = 0
          Top = 0
          Width = 482
          Height = 332
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 6
          ExplicitTop = 6
          ExplicitWidth = 361
          ExplicitHeight = 219
          ControlData = {
            4C000000D1310000502200000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 417
    Width = 758
    Height = 41
    Align = alBottom
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 2
    ExplicitLeft = 192
    ExplicitTop = 368
    ExplicitWidth = 185
    DesignSize = (
      758
      41)
    object Button2: TButton
      Left = 593
      Top = 4
      Width = 75
      Height = 32
      Action = actSave
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object Button3: TButton
      Left = 674
      Top = 4
      Width = 75
      Height = 32
      Action = actClose
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object template_html: TMemo
      Left = 10
      Top = 6
      Width = 59
      Height = 27
      Lines.Strings = (
        '<html>'
        '<style>'
        'html{ font-family: "Roboto", sans-serif; }'
        'body{'
        '   border:1px solid gray;'
        '   background:silver;'
        '}'
        ''
        '.ktn-note{'
        '   border:2px solid gray;'
        '   text-align:center;'
        '}'
        ''
        '.ktn-note [head]{'
        '   color:black;'
        '   font-weight:bold;'
        '}'
        ''
        '.ktn-note [note]{'
        '   color:gray;'
        '}'
        ''
        'img{'
        '   width:100px;'
        '   height:200px;'
        '   object-fit:contain;'
        '   object-position: center;'
        '}'
        ''
        '</style>'
        '<body>'
        '#INSERT#'
        '</body>'
        '</html>')
      TabOrder = 2
      Visible = False
      WordWrap = False
    end
    object template1: TMemo
      Left = 75
      Top = 6
      Width = 59
      Height = 27
      Lines.Strings = (
        '<div class="ktn-note">'
        '    <div head>'#1047#1040#1043#1054#1051#1054#1042#1054#1050'</div>'
        '    <div note>'#1054#1055#1048#1057#1040#1053#1048#1045'</div>'
        '</div>')
      TabOrder = 3
      Visible = False
      WordWrap = False
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'media|*.jpg;*.png;*.bmp;*.mp4|*.*|*.*'
    Left = 144
    Top = 152
  end
  object ActionList1: TActionList
    Left = 64
    Top = 153
    object actSave: TAction
      Caption = #1089#1086#1093#1088#1072#1085#1080#1090#1100
      OnExecute = actSaveExecute
    end
    object actAddMedia: TAction
      Caption = #1076#1086#1073#1072#1074#1080#1090#1100' media..'
      OnExecute = actAddMediaExecute
    end
    object actClose: TAction
      Caption = #1079#1072#1082#1088#1099#1090#1100
      OnExecute = actCloseExecute
    end
    object actTemplate1: TAction
      Caption = #1064#1072#1073#1083#1086#1085' 1'
      OnExecute = actTemplate1Execute
    end
    object actClearHtml: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnExecute = actClearHtmlExecute
    end
  end
end
