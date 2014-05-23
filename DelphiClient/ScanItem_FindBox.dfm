object ScanItem_FindBoxForm: TScanItem_FindBoxForm
  Left = 0
  Top = 0
  Caption = 'ScanItem_FindBoxForm'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 13
    Caption = 'Scan Item'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 101
    Height = 13
    Caption = 'Scanned Item Details'
  end
  object Label3: TLabel
    Left = 199
    Top = 53
    Width = 41
    Height = 13
    Caption = 'Item List'
  end
  object Label4: TLabel
    Left = 390
    Top = 53
    Width = 53
    Height = 13
    Caption = 'Box Details'
  end
  object ItemSKU: TEdit
    Left = 8
    Top = 27
    Width = 185
    Height = 21
    TabOrder = 0
    Text = '9400015744813'
  end
  object mmoItemDetails: TMemo
    Left = 8
    Top = 72
    Width = 185
    Height = 153
    TabOrder = 1
  end
  object mmoItemsList: TMemo
    Left = 199
    Top = 72
    Width = 185
    Height = 153
    Lines.Strings = (
      'Hello testing')
    TabOrder = 2
  end
  object mmoBoxDetails: TMemo
    Left = 390
    Top = 72
    Width = 185
    Height = 153
    TabOrder = 3
  end
  object ProcessScanBtn: TButton
    Left = 199
    Top = 25
    Width = 210
    Height = 25
    Caption = 'Process Scan  (Should be automatic)'
    Default = True
    TabOrder = 4
    OnClick = ProcessScanBtnClick
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://localhost:1337'
    Params = <>
    HandleRedirects = True
    Left = 24
    Top = 240
  end
  object findPackingBoxReq: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'itemSKU'
        Options = [poAutoCreated]
      end>
    Resource = 'Sku/findPackingBox?sku={itemSKU}'
    Response = RESTResponse1
    Left = 96
    Top = 240
  end
  object RESTResponse1: TRESTResponse
    Left = 200
    Top = 240
  end
  object boxItemReq: TRESTRequest
    Client = RESTClient1
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
      end>
    Resource = 'Item/create?sku={sku}&boxSKU={boxSKU}&packedBy={packedBy}'
    Response = RESTResponse1
    Left = 288
    Top = 240
  end
end
