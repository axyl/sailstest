object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object restClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    BaseURL = 'http://localhost:1337'
    Params = <>
    HandleRedirects = True
    Left = 24
    Top = 24
  end
  object getSortJobID: TRESTRequest
    Client = restClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'jobName'
        Options = [poAutoCreated]
      end>
    Resource = 'sortJob/?name={jobName}'
    Left = 24
    Top = 88
  end
end
