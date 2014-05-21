unit Location_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, Vcl.StdCtrls;

type
  TLocations= class(TObject)
    sku: string;
    name: string;
    id: integer;
  end;

  TLocation_MainForm = class(TbaseForm)
    LoadLocationsBtn: TButton;
    LocationsBox: TListBox;
    AddLocationBtn: TButton;
    EditLocationBtn: TButton;
    DeleteLocationBtn: TButton;
    LocationsGet: TRESTRequest;
    LocationsDelete: TRESTRequest;
    procedure LoadLocationsBtnClick(Sender: TObject);
    procedure DeleteLocationBtnClick(Sender: TObject);
  private
    { Private declarations }
    function clearLocations: Boolean;
  public
    { Public declarations }
  end;

var
  Location_MainForm: TLocation_MainForm;

implementation

{$R *.dfm}

uses
  DataModule
  , superObject
  ;

function TLocation_MainForm.clearLocations: Boolean;
var
  location: TLocations;
begin
  while locationsBox.Count> 0 do
  begin
    location:= TLocations(locationsBox.items.Objects[0]);
    freeandNil(location);
    locationsBox.Items.Delete(0);
  end;
end;

procedure TLocation_MainForm.DeleteLocationBtnClick(Sender: TObject);
begin
  inherited;
  LocationsDelete.Params.ParameterByName('id').Value:= InttoStr(TLocations(LocationsBox.Items.Objects[locationsBox.ItemIndex]).id);
  LocationsDelete.Execute;
  LoadLocationsBtnClick(self);
end;

procedure TLocation_MainForm.LoadLocationsBtnClick(Sender: TObject);
var
  locationsResponse: ISuperObject;
  items: Integer;
  location: TLocations;
begin
  inherited;
  cursor:= crHourGlass;
  try
    clearLocations;

    LocationsGet.Execute;
    locationsResponse:= SO(locationsGet.Response.Content);
    if locationsGet.Response.StatusCode<> 200 then
    begin
      MessageDlg('Unable to fetch locations from server.', mtError, [mbOK], 0);
    end
    else
    begin
      for items := 0 to locationsResponse.AsArray.Length- 1 do
      begin
        location:= TLocations.Create;
        location.id:= locationsResponse.AsArray[items].I['id'];
        location.name:= locationsResponse.AsArray[items].S['name'];
        location.sku:= locationsResponse.AsArray[items].S['locationSKU'];
        locationsBox.AddItem(locationsResponse.AsArray[items].S['name']+' - '+ locationsResponse.AsArray[items].S['locationSKU'], location);
      end;
    end;

  finally
    cursor:= crDefault;
  end;
end;

end.
