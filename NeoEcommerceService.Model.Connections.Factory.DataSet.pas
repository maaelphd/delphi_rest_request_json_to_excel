unit NeoEcommerceService.Model.Connections.Factory.DataSet;

interface

uses
  NeoEcommerceService.Model.Connections.Interfaces, NeoEcommerceService.Model.Connections.Firedac.DataSet,
  NeoEcommerceService.Model.Connections.ClientDataSet;

type

  TModelConnectionsFactoryDataSet = class(TInterfacedObject, iModelFactoryDataSet)
  private
    FDataSetFiredac: iModelDataSet;
    FClientDataSet: iModelClientDataSet;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelFactoryDataSet;
    function DataSetFiredac: iModelDataSet;
    function ClientDataSet: iModelClientDataSet;
  end;

implementation

{ TModelConnectionsFactoryDataSet }

function TModelConnectionsFactoryDataSet.ClientDataSet: iModelClientDataSet;
begin
  if not Assigned(FClientDataSet) then
    FClientDataSet := TModelConnetionsClientDataSet.New();

  Result := FClientDataSet;
end;

constructor TModelConnectionsFactoryDataSet.Create;
begin

end;

function TModelConnectionsFactoryDataSet.DataSetFiredac: iModelDataSet;
begin
  if not Assigned(FDataSetFiredac) then
    FDataSetFiredac := TModelConnetionsFiredacDataset.New();

  Result := FDataSetFiredac;
end;

destructor TModelConnectionsFactoryDataSet.Destroy;
begin

  inherited;
end;

class function TModelConnectionsFactoryDataSet.New: iModelFactoryDataSet;
begin
  result := Self.Create;
end;

end.
