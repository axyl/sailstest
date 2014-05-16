unit ScanItem_NewBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SuperObject, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TScanItem_NewBoxForm = class(TForm)
    BoxSKUEdt: TLabeledEdit;
    BoxLocationEdt: TLabeledEdit;
    boxGroupEdt: TLabeledEdit;
    SetupBoxBtn: TButton;
    createBoxRes: TRESTRequest;
    RESTClient1: TRESTClient;
    procedure SetupBoxBtnClick(Sender: TObject);
  private
    { Private declarations }
    boxGroupID: String;

  public
    { Public declarations }
    function SetupNewBox(lastItemResp: ISuperObject): Boolean;
  end;

var
  ScanItem_NewBoxForm: TScanItem_NewBoxForm;

implementation

{$R *.dfm}

{ TScanItem_NewBoxForm }

// Get the location for the box...create it..
procedure TScanItem_NewBoxForm.SetupBoxBtnClick(Sender: TObject);
begin
  createBoxRes.Params.ParameterByName('boxSKU').Value:= boxSKUEdt.Text;
  createBoxRes.Params.ParameterByName('boxGroupID').Value:= boxGroupID;
  createBoxRes.Params.ParameterByName('Location').Value:= boxLocationEdt.Text;
  createBoxRes.Execute;
  modalResult:= mrOK;
end;

function TScanItem_NewBoxForm.SetupNewBox(lastItemResp: ISuperObject): Boolean;
begin
  boxGroupID:= lastItemResp['sku.boxGroup'].AsString;
  boxGroupEdt.Text:= lastItemResp['sku.boxGroup'].AsString;
  if ShowModal= mrOK then
    result:= True
  else
    Result:= false;

end;

end.
