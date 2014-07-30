inherited ScanItem_AddToBoxForm: TScanItem_AddToBoxForm
  Caption = 'Add Item(s) to a Box...'
  ClientHeight = 301
  ClientWidth = 630
  OnShow = FormShow
  ExplicitWidth = 646
  ExplicitHeight = 339
  PixelsPerInch = 96
  TextHeight = 19
  object SKUedt: TLabeledEdit
    Left = 8
    Top = 24
    Width = 614
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 187
    EditLabel.Height = 19
    EditLabel.Caption = 'Box SKU to add items to...'
    TabOrder = 0
    ExplicitWidth = 619
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 57
    Width = 341
    Height = 201
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Items to Add to Box'
    TabOrder = 1
    ExplicitWidth = 346
    ExplicitHeight = 200
    object itemsListMmo: TMemo
      Left = 2
      Top = 21
      Width = 337
      Height = 178
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 24
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
  object processSKUBtn: TButton
    Left = 355
    Top = 268
    Width = 267
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Add Items (or Scan Box Again)'
    Default = True
    TabOrder = 2
    OnClick = processSKUBtnClick
  end
  object GroupBox2: TGroupBox
    Left = 355
    Top = 57
    Width = 267
    Height = 201
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Scan Item Details'
    TabOrder = 3
    ExplicitLeft = 360
    ExplicitHeight = 200
    object itemDetailsMmo: TMemo
      Left = 2
      Top = 21
      Width = 263
      Height = 178
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 23
    end
  end
  object findBox: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'boxSKU'
        Options = [poAutoCreated]
      end>
    Resource = 'box/?boxSKU={boxSKU}'
    Left = 24
    Top = 240
  end
  object findSKU: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'sortJob'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'itemSKU'
        Options = [poAutoCreated]
      end>
    Resource = 'Sku/?sortJob={sortJob}&SKU={itemSKU}'
    Left = 96
    Top = 240
  end
  object createItem: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'sortJob'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'itemSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'packedBy'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'boxSKU'
        Options = [poAutoCreated]
      end>
    Resource = 
      'item/Create?sku={ItemSKU}&packedBy={packedBy}&boxSKU={boxSKU}&so' +
      'rtJob={sortJob}'
    Left = 160
    Top = 240
  end
  object setBoxPacked: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'boxID'
        Options = [poAutoCreated]
      end>
    Resource = 'box/update/{boxID}?status=packed'
    Left = 240
    Top = 240
  end
end
