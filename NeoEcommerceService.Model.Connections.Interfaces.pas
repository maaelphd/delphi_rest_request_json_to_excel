unit NeoEcommerceService.Model.Connections.Interfaces;

interface

uses
  System.Classes, Data.DB, System.JSON, Datasnap.DBClient;

type

  TEvDisplay = procedure(Value: string) of Object;

  iModelConnectionParams = interface;
  iModelConnectionRestParams = interface;

  iModelConnection = interface
    ['{F8EA8C21-F79C-402F-ACA2-AA9794412061}']
    function Connect: iModelConnection;
    function EndConnection: TComponent;
    function Params: iModelConnectionParams;
  end;

  iModelConnectionParams = interface
    ['{7E7DF611-6FE8-4E1E-8D7A-4BB1B36A91D7}']
    function DataBase(const Value: string): iModelConnectionParams;
    function UserName(const Value: string): iModelConnectionParams;
    function Password(const Value: string): iModelConnectionParams;
    function DriverID(const Value: string): iModelConnectionParams;
    function Server(const Value: string): iModelConnectionParams;
    function Port(const Value: integer): iModelConnectionParams;
    function EndParams: iModelConnection;
  end;

  iModelFactoryConnection = interface
    ['{C806DF9A-E9E6-438C-89B8-F39DF661473F}']
    function ConnectionFiredac: iModelConnection;
  end;

  iModelConnectionRest = interface
    ['{D4228031-7774-49F5-AAD5-FF0D26B15EB2}']
    function EndConnection: TComponent;
    function Params: iModelConnectionRestParams;
  end;

  iModelConnectionRestParams = interface
    ['{98237618-64FA-45E2-ADF1-D20DC3912213}']
    function BaseUrl(const Value: string): iModelConnectionRestParams;
    function UserName(const Value: string): iModelConnectionRestParams;
    function Password(const Value: string): iModelConnectionRestParams;
    function EndParams: iModelConnectionRest;
  end;

  iModelFactoryConnectionRest = interface
    ['{FB86F716-AE55-40DF-9585-DD39C7D39631}']
    function ConnectionRestDelphi: iModelConnectionRest;
  end;

  iModelQuery = interface
    ['{C5051F28-92FC-482F-98AC-2F0C080DC714}']
    function SQL(const Value: TStrings): iModelQuery;
    function Query: TDataSet;
    function ExecSQL: iModelQuery;
  end;

  iModelFactoryQuery = interface
    ['{6F588BC1-2C22-4EB5-A862-8FB64085A7DD}']
    function FiredacQuery(Connection: iModelConnection): iModelQuery;
  end;

  iModelDataSet = interface
    ['{5CBD1A76-2E1B-4F37-90CF-7E60874280F2}']
    function SetDataSet(aValue: TDataSet): iModelDataSet;
    function CopyDataSet(aValue: TDataSet): iModelDataset;
    function EndDataSet: TDataSet;
  end;

  iModelClientDataSet = interface
    ['{1CD0D954-7CFF-4E00-99D4-E50CF8E973C4}']
    function SetDataSet(aValue: TClientDataSet): iModelClientDataSet;
    function EndDataSet: TClientDataSet;
    function Free: iModelClientDataSet;
  end;

  iModelFactoryDataSet = interface
    ['{9D88FA15-B08D-4127-8617-B1A195DA8601}']
    function DataSetFiredac: iModelDataSet;
    function ClientDataSet: iModelClientDataSet;
  end;

  iModelRestData = interface
    ['{38C09079-55EC-489A-A088-C4C7EB570D45}']
    function Resource(const Value: string): iModelRestData;
    function Param(const Value:string): iModelRestData;
    function QueryParam(const Value:string): iModelRestData;
    function Execute: iModelRestData;
    function Get: iModelRestData;
    function JSonValue: TJsonValue;
    {function GetStatusCode(Value: TEvDisplay): iModelRestData;
    function GetStatusText(Value: TEvDisplay): iModelRestData;}
    //function EndRestData: TComponent;
  end;

  iModelFactoryRestData = interface
    ['{BEEA4D74-18D9-4BB0-867A-2FA688A0E263}']
    function RestDataDelphi(ConnectionRest: iModelConnectionRest): iModelRestData;
  end;

implementation

end.
