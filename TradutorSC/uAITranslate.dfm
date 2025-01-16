object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 573
  ClientWidth = 1007
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1001
    Height = 330
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitWidth = 991
    ExplicitHeight = 312
  end
  object Panel1: TPanel
    Left = 0
    Top = 532
    Width = 1007
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 514
    ExplicitWidth = 997
    object Button1: TButton
      Left = 3
      Top = 6
      Width = 90
      Height = 34
      Caption = 'Traduzir'
      TabOrder = 0
      OnClick = Button1Click
    end
    object OllamaModel: TComboBox
      Left = 160
      Top = 6
      Width = 209
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'llama3.1:8b-instruct-fp16'
      OnCloseUp = OllamaModelCloseUp
      Items.Strings = (
        'llama3.1:8b-instruct-fp16'
        'llama3.1:latest'
        'gemma2:27b'
        'phi3:14b')
    end
  end
  object Memo2: TMemo
    Left = 0
    Top = 336
    Width = 1007
    Height = 196
    Align = alBottom
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
    ExplicitTop = 318
    ExplicitWidth = 997
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    DriverID = 'SQLite'
    Left = 108
    Top = 84
  end
  object Connection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = ConnectionBeforeConnect
    Left = 84
    Top = 222
  end
  object qryOriginal: TFDQuery
    Connection = Connection
    Left = 284
    Top = 72
  end
end
