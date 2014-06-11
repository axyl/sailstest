inherited ScanItem_DeleteFromBoxForm: TScanItem_DeleteFromBoxForm
  Caption = 'ScanItem_DeleteFromBoxForm'
  ClientHeight = 203
  OnShow = FormShow
  ExplicitWidth = 651
  ExplicitHeight = 241
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 167
    Height = 19
    Caption = 'Delete Item from Box...'
  end
  object ItemSKUEdt: TLabeledEdit
    Left = 16
    Top = 56
    Width = 601
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 67
    EditLabel.Height = 19
    EditLabel.Caption = 'Item SKU'
    TabOrder = 0
    OnKeyPress = ControlBoxKeyPressEnterCheck
  end
  object BoxSKUEdt: TLabeledEdit
    Left = 16
    Top = 112
    Width = 601
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 60
    EditLabel.Height = 19
    EditLabel.Caption = 'Box SKU'
    TabOrder = 1
    OnEnter = BoxSKUEdtEnter
    OnKeyPress = ControlBoxKeyPressEnterCheck
  end
  object DeleteItemBtn: TButton
    Left = 512
    Top = 160
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete Item'
    TabOrder = 2
    OnClick = DeleteItemBtnClick
  end
  object item_DestroyRest: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'boxSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'itemSKU'
        Options = [poAutoCreated]
      end>
    Resource = 'item/destroy?boxSKU={boxSKU}&itemSKU={itemSKU}'
    Left = 456
    Top = 151
  end
end
