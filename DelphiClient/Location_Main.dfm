inherited Location_MainForm: TLocation_MainForm
  Caption = 'Locations'
  ClientHeight = 425
  ClientWidth = 796
  ExplicitWidth = 812
  ExplicitHeight = 463
  PixelsPerInch = 96
  TextHeight = 19
  object LoadLocationsBtn: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Load Locations'
    TabOrder = 0
    OnClick = LoadLocationsBtnClick
  end
  object LocationsBox: TListBox
    Left = 8
    Top = 39
    Width = 780
    Height = 378
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 19
    TabOrder = 1
  end
  object AddLocationBtn: TButton
    Left = 159
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Add Location'
    TabOrder = 2
    OnClick = AddLocationBtnClick
  end
  object EditLocationBtn: TButton
    Left = 310
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Edit Location'
    TabOrder = 3
    OnClick = EditLocationBtnClick
  end
  object DeleteLocationBtn: TButton
    Left = 461
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Delete Location'
    TabOrder = 4
    OnClick = DeleteLocationBtnClick
  end
  object ImportLocationsBtn: TButton
    Left = 612
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Import Locations'
    TabOrder = 5
    OnClick = ImportLocationsBtnClick
  end
  object LocationsGet: TRESTRequest
    Client = DataModule1.restClient1
    Params = <>
    Resource = 'location?sort=name'
    Left = 632
    Top = 8
  end
  object LocationsDelete: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'id'
        Options = [poAutoCreated]
      end>
    Resource = 'location/destroy/{id}'
    Left = 712
    Top = 8
  end
  object LocationsAdd: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'name'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'locationSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'multipleBoxes'
        Options = [poAutoCreated]
      end>
    Resource = 
      'location/create?name={name}&locationSKU={locationSKU}&multipleBo' +
      'xes={multipleBoxes}'
    Left = 632
    Top = 64
  end
  object LocationsEdit: TRESTRequest
    Client = DataModule1.restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'id'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'name'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'locationSKU'
        Options = [poAutoCreated]
      end
      item
        Kind = pkURLSEGMENT
        name = 'multipleBoxes'
        Options = [poAutoCreated]
      end>
    Resource = 
      'location/update/{id}?name={name}&locationSKU={locationSKU}&multi' +
      'pleBoxes={multipleBoxes}'
    Left = 712
    Top = 64
  end
  object openCSVDialog: TOpenTextFileDialog
    DefaultExt = 'csv'
    Filter = 'CSV File|*.csv'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 632
    Top = 128
  end
end
