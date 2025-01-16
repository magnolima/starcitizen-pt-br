object frmCompararTags: TfrmCompararTags
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Comparar tags'
  ClientHeight = 619
  ClientWidth = 981
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
    Top = 299
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
    Top = 23
    Width = 277
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Tags existentes apenas na tradu'#231#227'o'
  end
  object lbTagOriginal: TListBox
    Tag = 1
    Left = 24
    Top = 334
    Width = 925
    Height = 205
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ItemHeight = 25
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object btComparar: TButton
    Left = 24
    Top = 561
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
    Top = 561
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
  object lbTagTraducao: TListBox
    Left = 24
    Top = 58
    Width = 925
    Height = 205
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ItemHeight = 25
    PopupMenu = PopupMenu1
    TabOrder = 3
  end
  object btSalvar: TButton
    Left = 156
    Top = 561
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
  object btRemoverTags: TButton
    Left = 311
    Top = 10
    Width = 242
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Remover tags obsoletas'
    Enabled = False
    TabOrder = 5
    OnClick = btRemoverTagsClick
  end
  object btCopiarTags: TButton
    Left = 311
    Top = 286
    Width = 242
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Copiar tags para tradu'#231#227'o'
    Enabled = False
    TabOrder = 6
    OnClick = btCopiarTagsClick
  end
  object btAtualizarTagsVazias: TButton
    Left = 310
    Top = 561
    Width = 242
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Atualizar tags vazias'
    TabOrder = 7
    OnClick = btAtualizarTagsVaziasClick
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 180
    Top = 176
    object Copiar1: TMenuItem
      Caption = 'Copiar'
    end
  end
end
