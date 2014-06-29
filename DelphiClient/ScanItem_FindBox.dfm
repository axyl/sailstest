object ScanItem_FindBoxForm: TScanItem_FindBoxForm
  Left = 0
  Top = 0
  Caption = 'ScanItem_FindBoxForm'
  ClientHeight = 277
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    732
    277)
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 268
    Height = 19
    Caption = 'Scan Item or Box (Once Boxed Items)'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 149
    Height = 19
    Caption = 'Scanned Item Details'
  end
  object Label3: TLabel
    Left = 330
    Top = 55
    Width = 62
    Height = 19
    Anchors = [akTop, akRight]
    Caption = 'Item List'
  end
  object Label4: TLabel
    Left = 521
    Top = 55
    Width = 78
    Height = 19
    Anchors = [akTop, akRight]
    Caption = 'Box Details'
  end
  object BoxLocationLbl: TLabel
    Left = 8
    Top = 244
    Width = 6
    Height = 23
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 231
  end
  object ItemSKU: TEdit
    Left = 8
    Top = 27
    Width = 420
    Height = 27
    TabOrder = 0
  end
  object mmoItemDetails: TMemo
    Left = 8
    Top = 79
    Width = 316
    Height = 153
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object mmoItemsList: TMemo
    Left = 330
    Top = 80
    Width = 185
    Height = 153
    Anchors = [akTop, akRight, akBottom]
    Lines.Strings = (
      'Hello testing')
    TabOrder = 2
  end
  object mmoBoxDetails: TMemo
    Left = 521
    Top = 80
    Width = 203
    Height = 153
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 3
  end
  object ProcessScanBtn: TButton
    Left = 434
    Top = 26
    Width = 290
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Process Scan  (Should be automatic)'
    Default = True
    TabOrder = 4
    OnClick = ProcessScanBtnClick
  end
  object findPackingBoxReq: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'itemSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'sortJob'
        Options = [poAutoCreated]
      end>
    Resource = 'Sku/findPackingBox?sku={itemSKU}&sortJob={sortJob}'
    Response = RESTResponse1
    Left = 104
    Top = 224
  end
  object RESTResponse1: TRESTResponse
    Left = 200
    Top = 224
  end
  object boxItemReq: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'boxSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'packedBy'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'sku'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'sortJob'
        Options = [poAutoCreated]
      end>
    Resource = 
      'Item/create?sku={sku}&boxSKU={boxSKU}&packedBy={packedBy}&sortJo' +
      'b={sortJob}'
    Response = RESTResponse1
    Left = 288
    Top = 224
  end
end
