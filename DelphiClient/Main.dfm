object MainForm: TMainForm
  Caption = 'MainForm'
  PixelsPerInch = 96
  TextHeight = 19
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 105
    Height = 25
    Caption = 'Scan Item Mode'
    TabOrder = 0
    OnClick = Button1Click
  end
  object PackerName: TLabeledEdit
    Left = 536
    Top = 18
    Width = 121
    Height = 21
    EditLabel.Width = 62
    EditLabel.Height = 13
    EditLabel.Caption = 'Packer Name'
    TabOrder = 1
    Text = 'Craig'
  end
  object Button2: TButton
    Left = 16
    Top = 56
    Width = 105
    Height = 25
    Caption = 'Manage Locations'
    TabOrder = 2
    OnClick = Button2Click
  end
end
