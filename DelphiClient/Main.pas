unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Base;

type
  TMainForm = class(TBaseForm)
    Button1: TButton;
    PackerName: TLabeledEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses ScanItem_FindBox, Location_Main;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  ScanItem_FindBoxForm.ShowModal;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  inherited;
  Location_MainForm.ShowModal;
end;

end.
