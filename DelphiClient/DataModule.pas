unit DataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, Dialogs, VCL.Forms;

type
  TDataModule1 = class(TDataModule)
    restClient1: TRESTClient;
    getSortJobID: TRESTRequest;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ExecuteRest(restObj: TRESTRequest; ErrorTitle: String): Boolean;
    function CapsLockCheck: Boolean;
    procedure applicationIsNowIdle(Sender: TObject; var Done: Boolean);
    function findJobsSortID(JobName: String): Integer;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Main,
  Winapi.Windows,
  superobject;

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.applicationIsNowIdle(Sender: TObject; var Done: Boolean);
begin
  // Runs when an application starts being idle...  (Not continously)

  CapsLockCheck;
end;

function TDataModule1.CapsLockCheck: Boolean;
begin
  if getKeyState(VK_CAPITAL)> 0 then
  begin
    MessageDlg('Turn off the CAPS LOCK Key.', mtError, [mbOK], 0);
  end;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  // This should run after the main form's created and read in the server setting.
  restClient1.BaseURL:= MainForm.serverNameEdt.Text;
  // When app is idle...check for caps lock.
  Application.OnIdle:= ApplicationIsNowIdle;
end;

function TDataModule1.ExecuteRest(restObj: TRESTRequest;
  ErrorTitle: String): Boolean;
begin
  restObj.Execute;
  if restObj.Response.StatusCode< 300 then
    result:= true
  else
  begin
    Result:= false;
    MessageDlg('Error with '+ errorTitle+ #13#10#13#10+ 'Reported Error: '+ restObj.Response.ErrorMessage+ #13#10+ 'Status Text: '+ restObj.Response.StatusText+ #13#10+ 'Response Content: '+ restObj.Response.Content, mtError, [mbOK], 0);
  end;

end;

function TDataModule1.findJobsSortID(JobName: String): Integer;
var
  jsonResponse: ISuperObject;
begin
  result:= -1;
  // Gets the Job ID for the name provided.
  getSortJobID.Params.ParameterByName('jobName').Value:= jobName;
  if (self.ExecuteRest(getSortJobID, 'Finding Sort Job ID')) then
  begin
    jsonResponse:= SO(getSortJobID.Response.Content);
    // Is there a result that matches?
    if jsonResponse.AsArray.Length< 1 then
    begin
      MessageDlg('Sort Job Name has no match in the database.  Unable to continue.', mtError, [mbOK], 0);
      exit;
    end;
    // Return the right value.
    result:= jsonResponse.AsArray[0].I['id'];
  end
  else
    result:= -1;

end;

end.
