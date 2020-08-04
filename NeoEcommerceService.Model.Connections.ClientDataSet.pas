unit NeoEcommerceService.Model.Connections.ClientDataSet;

interface

uses
  NeoEcommerceService.Model.Connections.Interfaces, System.Classes, Data.DB, Datasnap.DBClient, MidasLib;

type

  TModelConnetionsClientDataSet = class(TInterfacedObject, iModelClientDataSet)
  private
    FDataSet: TClientDataSet;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelClientDataSet;
    function SetDataSet(aValue: TClientDataSet): iModelClientDataSet;
    function EndDataSet: TClientDataSet;
    function Free: iModelClientDataSet;
  end;

implementation

uses
  System.SysUtils;

{ TModelConnetionsClientDataSet }

constructor TModelConnetionsClientDataSet.Create;
begin
  //FDataSet := TFDTable.Create(nil);
  if not Assigned(FDataSet) then
    FDataSet := TClientDataSet.Create(nil);
end;

destructor TModelConnetionsClientDataSet.Destroy;
begin
  FreeAndNil(FDataSet);
  inherited;
end;

function TModelConnetionsClientDataSet.EndDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

function TModelConnetionsClientDataSet.Free: iModelClientDataSet;
begin
  Result := Self;
  //FDataSet.Free;
  Self.Destroy;
end;

class function TModelConnetionsClientDataSet.New: iModelClientDataSet;
begin
  Result := Self.Create();
end;

function TModelConnetionsClientDataSet.SetDataSet(aValue: TClientDataSet): iModelClientDataSet;
begin
  Result := Self;
  FDataSet := aValue as TClientDataSet;
end;

end.
