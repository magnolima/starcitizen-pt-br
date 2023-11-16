object frmCompararTags: TfrmCompararTags
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Comparar tags'
  ClientHeight = 568
  ClientWidth = 973
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 25
  object Label1: TLabel
    Left = 24
    Top = -2
    Width = 268
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Tags existentes apenas no original'
  end
  object Label2: TLabel
    Left = 24
    Top = 248
    Width = 277
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Tags existentes apenas na tradu'#231#227'o'
  end
  object ListBox1: TListBox
    Left = 24
    Top = 33
    Width = 925
    Height = 205
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ItemHeight = 25
    TabOrder = 0
  end
  object btComparar: TButton
    Left = 24
    Top = 501
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Comparar'
    TabOrder = 1
    OnClick = btCompararClick
  end
  object btFechar: TButton
    Left = 836
    Top = 501
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = btFecharClick
  end
  object ListBox2: TListBox
    Left = 24
    Top = 286
    Width = 925
    Height = 205
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ItemHeight = 25
    TabOrder = 3
  end
  object btSalvar: TButton
    Left = 156
    Top = 501
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Salvar'
    TabOrder = 4
    Visible = False
    OnClick = btSalvarClick
  end
end
