object KTNEditorForm: TKTNEditorForm
  Left = 579
  Top = 235
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1081
  ClientHeight = 593
  ClientWidth = 957
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
    Width = 957
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Button4: TButton
      Left = 2
      Top = 3
      Width = 75
      Height = 32
      Hint = #1057#1086#1079#1076#1072#1077#1090' '#1089#1090#1072#1085#1076#1072#1088#1090#1085#1099#1081' '#1096#1072#1073#1083#1086#1085' '#1088#1072#1079#1084#1077#1090#1082#1080
      Action = actTemplate1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object Button5: TButton
      Left = 83
      Top = 3
      Width = 75
      Height = 32
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1077' '#1089' '#1082#1086#1076#1086#1084
      Action = actClearHtml
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object Button6: TButton
      Left = 219
      Top = 3
      Width = 75
      Height = 32
      Action = actBr
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object Button7: TButton
      Left = 300
      Top = 3
      Width = 75
      Height = 32
      Action = actBold
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object Button8: TButton
      Left = 415
      Top = 3
      Width = 138
      Height = 32
      Action = actValidate
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 957
    Height = 511
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
      Left = 701
      Top = 6
      Width = 250
      Height = 499
      Margins.Right = 10
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel4'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 250
        Height = 467
        HorzScrollBar.Visible = False
        Align = alClient
        TabOrder = 0
      end
      object Button1: TButton
        Left = 0
        Top = 467
        Width = 250
        Height = 32
        Action = actAddMedia
        Align = alBottom
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
    object PageControl1: TPageControl
      Left = 6
      Top = 6
      Width = 695
      Height = 499
      ActivePage = TabSheet1
      Align = alClient
      DoubleBuffered = True
      MultiLine = True
      ParentDoubleBuffered = False
      TabOrder = 1
      TabPosition = tpBottom
      ExplicitLeft = 10
      ExplicitWidth = 496
      ExplicitHeight = 364
      object TabSheet1: TTabSheet
        BorderWidth = 4
        Caption = 'Html'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 417
        ExplicitHeight = 330
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 679
          Height = 465
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
        end
      end
      object TabSheet2: TTabSheet
        BorderWidth = 3
        Caption = #1087#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088
        ImageIndex = 1
        OnShow = TabSheet2Show
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 474
        object WebBrowser1: TWebBrowser
          Left = 0
          Top = 0
          Width = 681
          Height = 467
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 6
          ExplicitTop = 6
          ExplicitWidth = 361
          ExplicitHeight = 219
          ControlData = {
            4C00000062460000443000000000000000000000000000000000000000000000
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
    Top = 552
    Width = 957
    Height = 41
    Align = alBottom
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 2
    ExplicitLeft = 192
    ExplicitTop = 368
    ExplicitWidth = 185
    DesignSize = (
      957
      41)
    object Button2: TButton
      Left = 792
      Top = 4
      Width = 75
      Height = 32
      Action = actSave
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16744448
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button3: TButton
      Left = 873
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
      Ctl3D = False
      Lines.Strings = (
        '<html>'
        ''
        '<head>'
        
          '    <!-- '#1042#1072#1078#1085#1086' '#1076#1083#1103' IE '#1076#1074#1080#1078#1082#1072', '#1095#1090#1086#1073#1099' '#1087#1088#1080#1085#1091#1076#1080#1090#1077#1083#1100#1085#1086' '#1074#1082#1083#1102#1095#1080#1090#1100' '#1088#1077#1078#1080#1084 +
          ' Edge -->'
        '    <meta http-equiv="X-UA-Compatible" content="IE=edge" />'
        '    <title>Video Player</title>'
        '</head>'
        ''
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
        'video{'
        '  width:100px;'
        '  height:100px;'
        '  border:1px dashed gray;'
        '}'
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
      ParentCtl3D = False
      TabOrder = 2
      Visible = False
      WordWrap = False
    end
    object template1: TMemo
      Left = 75
      Top = 6
      Width = 59
      Height = 27
      Ctl3D = False
      Lines.Strings = (
        '<div class="ktn-note">'
        '    <div head>'#1057#1070#1044#1040' '#1055#1048#1064#1045#1052' '#1047#1040#1043#1054#1051#1054#1042#1054#1050'</div>'
        '    <div note>'#1057#1070#1044#1040' '#1055#1048#1064#1045#1052' '#1054#1055#1048#1057#1040#1053#1048#1045'</div>'
        '</div>')
      ParentCtl3D = False
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
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1092#1072#1081#1083' '#1074' '#1082#1086#1083#1083#1077#1082#1094#1080#1102
      OnExecute = actAddMediaExecute
    end
    object actClose: TAction
      Caption = #1079#1072#1082#1088#1099#1090#1100
      OnExecute = actCloseExecute
    end
    object actTemplate1: TAction
      Caption = #1064#1072#1073#1083#1086#1085
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1096#1072#1073#1083#1086#1085' '#1088#1072#1079#1084#1077#1090#1082#1080
      OnExecute = actTemplate1Execute
    end
    object actClearHtml: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1077' '#1082#1086#1076#1072' html'
      OnExecute = actClearHtmlExecute
    end
    object actBr: TAction
      Caption = #1055#1077#1088#1077#1085#1086#1089
      Hint = #1044#1086#1073#1072#1074#1080#1090' '#1090#1077#1075' '#1087#1077#1088#1077#1085#1086#1089#1072' <br>'
      OnExecute = actBrExecute
    end
    object actValidate: TAction
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1082#1086#1076#1072
      Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1082#1086#1076' '#1085#1072' '#1074#1072#1083#1080#1076#1085#1086#1089#1090#1100
      OnExecute = actValidateExecute
    end
    object actBold: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1092#1088#1072#1075#1084#1077#1085#1090' '#1078#1080#1088#1085#1099#1084
      OnExecute = actBoldExecute
    end
  end
end
