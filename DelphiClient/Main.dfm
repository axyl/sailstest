object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 349
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScanItemsBtn: TButton
    Left = 11
    Top = 7
    Width = 110
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Scan/Pack Items'
    TabOrder = 0
    OnClick = ScanItemsBtnClick
  end
  object PackerName: TLabeledEdit
    Left = 328
    Top = 18
    Width = 138
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
  object ManageLocationsBtn: TButton
    Left = 11
    Top = 103
    Width = 110
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Manage Locations'
    TabOrder = 2
    OnClick = ManageLocationsBtnClick
  end
  object PackBoxBtn: TButton
    Left = 11
    Top = 55
    Width = 110
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Pack Box/Move Box'
    TabOrder = 3
    OnClick = PackBoxBtnClick
  end
  object serverNameEdt: TLabeledEdit
    Left = 328
    Top = 66
    Width = 138
    Height = 21
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    EditLabel.Width = 74
    EditLabel.Height = 13
    EditLabel.Margins.Left = 2
    EditLabel.Margins.Top = 2
    EditLabel.Margins.Right = 2
    EditLabel.Margins.Bottom = 2
    EditLabel.Caption = 'Server Address'
    TabOrder = 4
    Text = 'http://localhost:1337'
    OnChange = serverNameEdtChange
  end
  object btnGetBoxCSVFile: TButton
    Left = 11
    Top = 247
    Width = 110
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Get Box CSV File'
    TabOrder = 5
    OnClick = btnGetBoxCSVFileClick
  end
  object SearchBoxesBtn: TButton
    Left = 11
    Top = 151
    Width = 110
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Search Boxes'
    TabOrder = 6
    OnClick = SearchBoxesBtnClick
  end
  object DeleteItemBtn: TButton
    Left = 11
    Top = 199
    Width = 110
    Height = 44
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Delete Item from Box'
    TabOrder = 7
    OnClick = DeleteItemBtnClick
  end
end
