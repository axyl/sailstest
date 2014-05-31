inherited Box_MoveForm: TBox_MoveForm
  Caption = 'Box_MoveForm'
  ClientHeight = 240
  OnShow = FormShow
  ExplicitHeight = 278
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 16
    Top = 127
    Width = 110
    Height = 19
    Caption = 'New Box Status'
  end
  object BoxSKUEdt: TLabeledEdit
    Left = 16
    Top = 32
    Width = 601
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 60
    EditLabel.Height = 19
    EditLabel.Caption = 'Box SKU'
    TabOrder = 0
    OnKeyPress = ControlBoxKeyPressEnterCheck
  end
  object NewLocationSKUEdt: TLabeledEdit
    Left = 16
    Top = 88
    Width = 601
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 129
    EditLabel.Height = 19
    EditLabel.Caption = 'New Location SKU'
    TabOrder = 1
    OnKeyPress = ControlBoxKeyPressEnterCheck
  end
  object statusChkBox: TComboBox
    Left = 16
    Top = 152
    Width = 601
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    ItemIndex = 1
    TabOrder = 2
    Text = 'packed'
    OnEnter = statusChkBoxEnter
    OnKeyPress = ControlBoxKeyPressEnterCheck
    Items.Strings = (
      'packing'
      'packed'
      'empty'
      'dispatched'
      'packedNotAllocated')
  end
  object MoveBoxBtn: TButton
    Left = 520
    Top = 192
    Width = 97
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'Move Box'
    TabOrder = 3
    OnClick = MoveBoxBtnClick
  end
  object box_MoveRest: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'newLocationSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'status'
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
      'box/move?boxSKU={boxSKU}&locationSKU={newLocationSKU}&status={st' +
      'atus}&packedBy={packedBy}'
    Left = 456
    Top = 192
  end
end
