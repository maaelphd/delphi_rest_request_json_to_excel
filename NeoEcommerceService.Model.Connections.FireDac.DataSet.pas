unit NeoEcommerceService.Model.Connections.FireDac.DataSet;

interface

uses
  NeoEcommerceService.Model.Connections.Interfaces, FireDAC.Comp.Client, System.Classes, Data.DB, FireDAC.Comp.DataSet;

type

  TModelConnetionsFiredacDataSet = class(TInterfacedObject, iModelDataSet)
  private
    FDataSet: TFDMemTable;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelDataSet;
    function SetDataSet(aValue: TDataSet): iModelDataSet;
    function CopyDataSet(aValue: TDataSet): iModelDataset;
    function EndDataSet: TDataSet;
  end;

implementation

uses
  System.SysUtils;

{ TModelConnetionsFiredacDataSet }

function TModelConnetionsFiredacDataSet.CopyDataSet(
  aValue: TDataSet): iModelDataset;
begin
  Result := Self;
  FDataSet.CopyDataSet(aValue, [coStructure, coRestart, coAppend]);
end;

constructor TModelConnetionsFiredacDataSet.Create;
begin
  FDataSet := TFDMemTable.Create(nil);
end;

destructor TModelConnetionsFiredacDataSet.Destroy;
begin
  FreeAndNil(FDataSet);
  inherited;
end;

function TModelConnetionsFiredacDataSet.EndDataSet: TDataSet;
begin
  Result := FDataSet;
end;

class function TModelConnetionsFiredacDataSet.New: iModelDataSet;
begin
  Result := Self.Create();
end;

function TModelConnetionsFiredacDataSet.SetDataSet(aValue: TDataSet): iModelDataSet;
begin
  Result := Self;
  FDataSet := aValue as TFDMemTable;
end;

end.
