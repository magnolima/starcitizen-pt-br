object frmCompararTags: TfrmCompararTags
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Compare tags'
  ClientHeight = 603
  ClientWidth = 964
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
    Width = 303
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Check existing tags only in the original'
  end
  object Label2: TLabel
    Left = 24
    Top = 23
    Width = 297
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Check existing tags only in translation'
  end
  object lbTagOriginal: TListBox
    Tag = 1
    Left = 10
    Top = 334
    Width = 939
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
    Left = 10
    Top = 549
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Compare'
    TabOrder = 1
    OnClick = btCompararClick
  end
  object btFechar: TButton
    Left = 836
    Top = 549
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Close'
    TabOrder = 2
    OnClick = btFecharClick
  end
  object lbTagTraducao: TListBox
    Left = 10
    Top = 58
    Width = 939
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
    Top = 549
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Save'
    TabOrder = 4
    Visible = False
    OnClick = btSalvarClick
  end
  object btRemoverTags: TButton
    Left = 707
    Top = 10
    Width = 242
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Remove obsolete tags'
    Enabled = False
    TabOrder = 5
    OnClick = btRemoverTagsClick
  end
  object btCopiarTags: TButton
    Left = 707
    Top = 286
    Width = 242
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Copy tags to translation'
    Enabled = False
    TabOrder = 6
    OnClick = btCopiarTagsClick
  end
  object btAtualizarTagsVazias: TButton
    Left = 514
    Top = 549
    Width = 195
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Update empty tags'
    TabOrder = 7
    OnClick = btAtualizarTagsVaziasClick
  end
  object btHashCompare: TButton
    Left = 279
    Top = 549
    Width = 195
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Check for Diffs'
    TabOrder = 8
    OnClick = btHashCompareClick
  end
  object Memo1: TMemo
    Left = 10
    Top = 58
    Width = 944
    Height = 481
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Lines.Strings = (
      'Memo1')
    TabOrder = 9
    Visible = False
  end
  object PopupMenu1: TPopupMenu
    Left = 180
    Top = 176
    object Copiar1: TMenuItem
      Caption = 'Copiar'
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ini'
    Filter = 'Global.ini|*.ini|Todos|*.*'
    Title = 'Importar Global.ini'
    Left = 72
    Top = 102
  end
end
