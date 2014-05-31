unit Box_Move;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TBox_MoveForm = class(TbaseForm)
    BoxSKUEdt: TLabeledEdit;
    NewLocationSKUEdt: TLabeledEdit;
    statusChkBox: TComboBox;
    Label1: TLabel;
    MoveBoxBtn: TButton;
    box_MoveRest: TRESTRequest;
    procedure FormShow(Sender: TObject);
    procedure statusChkBoxEnter(Sender: TObject);
    procedure MoveBoxBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Box_MoveForm: TBox_MoveForm;

implementation

{$R *.dfm}
uses
  DataModule, Main, MMSystem;

procedure TBox_MoveForm.FormShow(Sender: TObject);
begin
  inherited;
  // Reset defaults.
  MoveBoxBtn.Default:= False;
  boxSKUEdt.Text:= '';
  NewLocationSKUEdt.Text:= '';
  statusChkBox.ItemIndex:= 1;

  self.SelectFirst;
end;

procedure TBox_MoveForm.MoveBoxBtnClick(Sender: TObject);
begin
  inherited;

  box_MoveRest.Params.ParameterByName('boxSKU').Value:= BoxSKUEdt.Text;
  box_MoveRest.Params.ParameterByName('newLocationSKU').Value:= NewLocationSKUEdt.Text;
  box_MoveRest.Params.ParameterByName('status').Value:= statusChkBox.Text;
  box_MoveRest.Params.ParameterByName('packedBy').Value:= MainForm.PackerName.Text;

  if DataModule1.ExecuteRest(box_MoveRest, 'Moving Box') then
  begin
    PlaySound('SystemNotification', 0, SND_ASYNC);
    modalResult:= mrClose;
  end;
end;

procedure TBox_MoveForm.statusChkBoxEnter(Sender: TObject);
begin
  inherited;
  // If this is active, then make the Move Box button accept the enter key straight away.
  if (NewLocationSKUEdt.Text<> '') and (BoxSKUEdt.Text<> '') then
    MoveBoxBtn.Default:= True;
end;

end.
