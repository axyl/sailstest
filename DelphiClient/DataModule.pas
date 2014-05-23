unit DataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, Dialogs;

type
  TDataModule1 = class(TDataModule)
    restClient1: TRESTClient;
  private
    { Private declarations }
  public
    { Public declarations }
    function ExecuteRest(restObj: TRESTRequest; ErrorTitle: String): Boolean;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TDataModule1.ExecuteRest(restObj: TRESTRequest;
  ErrorTitle: String): Boolean;
begin
  restObj.Execute;
  if restObj.Response.StatusCode< 300 then
    result:= true
  else
  begin
    Result:= false;
    MessageDlg('Error with '+ errorTitle+ #13#10#13#10+ 'Reported Error: '+ restObj.Response.ErrorMessage+ #13#10+ 'Status Text: '+ restObj.Response.StatusText, mtError, [mbOK], 0);
  end;

end;

end.
