object frmNovaTag: TfrmNovaTag
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nova tag'
  ClientHeight = 362
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  PixelsPerInch = 144
  TextHeight = 25
  object Label1: TLabel
    Left = 24
    Top = 9
    Width = 27
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Tag'
  end
  object Label2: TLabel
    Left = 24
    Top = 93
    Width = 71
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Tradu'#231#227'o'
  end
  object btnCancel: TButton
    Left = 608
    Top = 296
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 476
    Top = 296
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object mmTraducao: TMemo
    Left = 24
    Top = 128
    Width = 697
    Height = 134
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 1
  end
  object edtTag: TEdit
    Left = 24
    Top = 44
    Width = 697
    Height = 33
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 0
    Text = 'edtTag'
  end
end
