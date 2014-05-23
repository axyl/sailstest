object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 279
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 11
    Top = 11
    Width = 110
    Height = 46
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Scan Item Mode'
    TabOrder = 0
    OnClick = Button1Click
  end
  object PackerName: TLabeledEdit
    Left = 367
    Top = 19
    Width = 83
    Height = 21
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    EditLabel.Width = 62
    EditLabel.Height = 13
    EditLabel.Margins.Left = 2
    EditLabel.Margins.Top = 2
    EditLabel.Margins.Right = 2
    EditLabel.Margins.Bottom = 2
    EditLabel.Caption = 'Packer Name'
    TabOrder = 1
    Text = 'Craig'
  end
  object Button2: TButton
    Left = 11
    Top = 61
    Width = 110
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Manage Locations'
    TabOrder = 2
    OnClick = Button2Click
  end
end
