unit Location_AddEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TLocation_AddEditForm = class(TbaseForm)
    nameEdt: TLabeledEdit;
    skuEdt: TLabeledEdit;
    cancelBtn: TButton;
    SaveBtn: TButton;
    multipleBoxesChk: TCheckBox;
    procedure SaveBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function editLocation(var locationName, locationSKU: String; var multipleBoxes: Boolean): Boolean;
  end;

var
  Location_AddEditForm: TLocation_AddEditForm;

implementation

{$R *.dfm}

{ TLocation_AddEditForm }

procedure TLocation_AddEditForm.SaveBtnClick(Sender: TObject);
begin
  inherited;
  if (Length(nameEdt.Text)> 0) and (Length(skuEdt.Text)> 0) then
  begin
    modalResult:= mrOK;
  end
  else
  begin
    MessageDlg('Name and SKU must contain content.', mtError, [mbOK], 0);
  end;
end;

procedure TLocation_AddEditForm.cancelBtnClick(Sender: TObject);
begin
  inherited;
  ModalResult:= mrCancel;
end;

function TLocation_AddEditForm.editLocation(var locationName,
  locationSKU: String; var multipleBoxes: Boolean): Boolean;
begin
  Result:= False;
  nameEdt.Text:= locationName;
  skuEdt.Text:= locationSKU;
  multipleBoxesChk.Checked:= multipleBoxes;
  if self.ShowModal=mrOK then
  begin
    locationName:= nameEdt.Text;
    locationSku:= skuEdt.Text;
    multipleBoxes:= multipleBoxesChk.Checked;
    Result:= True;
  end;
end;

end.
