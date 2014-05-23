inherited Location_AddEditForm: TLocation_AddEditForm
  Caption = 'Add/Edit Location'
  ClientHeight = 174
  ExplicitWidth = 651
  ExplicitHeight = 212
  PixelsPerInch = 96
  TextHeight = 19
  object nameEdt: TLabeledEdit
    Left = 8
    Top = 24
    Width = 619
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 105
    EditLabel.Height = 19
    EditLabel.Caption = 'Location Name'
    TabOrder = 0
  end
  object skuEdt: TLabeledEdit
    Left = 8
    Top = 98
    Width = 619
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 93
    EditLabel.Height = 19
    EditLabel.Caption = 'Location SKU'
    TabOrder = 2
  end
  object cancelBtn: TButton
    Left = 552
    Top = 139
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = cancelBtnClick
    ExplicitTop = 105
  end
  object SaveBtn: TButton
    Left = 471
    Top = 139
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    Default = True
    TabOrder = 3
    OnClick = SaveBtnClick
    ExplicitTop = 105
  end
  object multipleBoxesChk: TCheckBox
    Left = 8
    Top = 57
    Width = 619
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Allow Multiple Boxes in this Location?'
    TabOrder = 1
  end
end
