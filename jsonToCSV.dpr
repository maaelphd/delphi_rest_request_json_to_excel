program jsonToCSV;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  NeoEcommerceService.Model.Connections.Factory.DataSet in 'NeoEcommerceService.Model.Connections.Factory.DataSet.pas',
  NeoEcommerceService.Model.Connections.FireDac.DataSet in 'NeoEcommerceService.Model.Connections.FireDac.DataSet.pas',
  NeoEcommerceService.Model.Connections.ClientDataSet in 'NeoEcommerceService.Model.Connections.ClientDataSet.pas',
  NeoEcommerceService.Model.Connections.Interfaces in 'NeoEcommerceService.Model.Connections.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
