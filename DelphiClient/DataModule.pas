unit DataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client;

type
  TDataModule1 = class(TDataModule)
    restClient1: TRESTClient;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
