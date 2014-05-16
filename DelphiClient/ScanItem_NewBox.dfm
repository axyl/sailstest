object ScanItem_NewBoxForm: TScanItem_NewBoxForm
  Left = 0
  Top = 0
  Caption = 'ScanItem_NewBoxForm'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BoxSKUEdt: TLabeledEdit
    Left = 8
    Top = 24
    Width = 161
    Height = 21
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Box SKU'
    TabOrder = 0
  end
  object BoxLocationEdt: TLabeledEdit
    Left = 8
    Top = 64
    Width = 161
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'Box Location'
    TabOrder = 1
  end
  object boxGroupEdt: TLabeledEdit
    Left = 8
    Top = 104
    Width = 161
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'Box Group'
    Enabled = False
    TabOrder = 2
  end
  object SetupBoxBtn: TButton
    Left = 528
    Top = 267
    Width = 99
    Height = 25
    Caption = 'Define Box'
    Default = True
    TabOrder = 3
    OnClick = SetupBoxBtnClick
  end
  object createBoxRes: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'boxSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'boxGroupID'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'location'
        Options = [poAutoCreated]
      end>
    Resource = 
      'box/create?boxSKU={boxSKU}&status=packing&boxGroup={boxGroupID}&' +
      'location={location}'
    Left = 288
    Top = 144
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    BaseURL = 'http://localhost:1337'
    Params = <>
    HandleRedirects = True
    Left = 384
    Top = 144
  end
end
