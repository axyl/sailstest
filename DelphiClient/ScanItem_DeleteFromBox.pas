unit ScanItem_DeleteFromBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TScanItem_DeleteFromBoxForm = class(TbaseForm)
    ItemSKUEdt: TLabeledEdit;
    BoxSKUEdt: TLabeledEdit;
    Label1: TLabel;
    DeleteItemBtn: TButton;
    item_DestroyRest: TRESTRequest;
    procedure FormShow(Sender: TObject);
    procedure BoxSKUEdtEnter(Sender: TObject);
    procedure DeleteItemBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScanItem_DeleteFromBoxForm: TScanItem_DeleteFromBoxForm;

implementation

{$R *.dfm}

uses DataModule,
  MMSystem;

procedure TScanItem_DeleteFromBoxForm.DeleteItemBtnClick(Sender: TObject);
begin
  inherited;
  self.Color:= clBtnFace;
  Item_DestroyRest.Params.ParameterByName('BoxSKU').Value:= BoxSKUEdt.Text;
  Item_DestroyRest.Params.ParameterByName('ItemSKU').Value:= ItemSKUEdt.Text;
  if (DataModule1.ExecuteRest(Item_DestroyRest, 'Delete Item from Box')) then
  begin
    self.Color:= clGreen;
    PlaySound('SystemNotification', 0, SND_ASYNC);
    FormShow(self);
  end
  else
  begin
    self.Color:= clRed;
    self.SelectFirst;
    DeleteItemBtn.Default:= False;
  end;
end;

procedure TScanItem_DeleteFromBoxForm.FormShow(Sender: TObject);
begin
  inherited;
  self.SelectFirst;

  DeleteItemBtn.Default:= False;
  itemSKUEdt.Text:= '';
  BoxSKUEdt.Text:= '';

end;

procedure TScanItem_DeleteFromBoxForm.BoxSKUEdtEnter(Sender: TObject);
begin
  inherited;
  // If this is active, then make the Move Box button accept the enter key straight away.
  if (ItemSKUEdt.Text<> '') then
    DeleteItemBtn.Default:= True;

end;

end.
