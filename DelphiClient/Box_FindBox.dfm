inherited Box_FindBoxForm: TBox_FindBoxForm
  Caption = 'Box_FindBoxForm'
  ClientHeight = 314
  ClientWidth = 581
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 597
  ExplicitHeight = 352
  PixelsPerInch = 96
  TextHeight = 19
  object itemSKUFindEdt: TLabeledEdit
    Left = 16
    Top = 32
    Width = 453
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 264
    EditLabel.Height = 19
    EditLabel.Caption = 'Enter Item SKU to search boxes for...'
    TabOrder = 0
    OnKeyPress = ControlBoxKeyPressEnterCheck
  end
  object FindItemSKUBtn: TButton
    Left = 475
    Top = 34
    Width = 89
    Height = 32
    Anchors = [akTop, akRight]
    Caption = 'Search...'
    Default = True
    TabOrder = 1
    OnClick = FindItemSKUBtnClick
  end
  object BoxesList: TStringGrid
    Left = 16
    Top = 72
    Width = 548
    Height = 223
    Anchors = [akLeft, akTop, akRight, akBottom]
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object box_FindItem: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'ItemSKU'
        Options = [poAutoCreated]
      end>
    Resource = 'box/findItemSKU?ItemSKU={ItemSKU}'
    Left = 440
    Top = 88
  end
end
