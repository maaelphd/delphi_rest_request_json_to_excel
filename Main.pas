unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ScrollBox, FMX.Memo,
  Data.DB, Datasnap.DBClient, System.StrUtils, System.JSON, REST.Response.Adapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  NeoEcommerceService.Model.Connections.Interfaces, FMX.Colors, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, REST.Authenticator.Basic;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    FDataSet: TFDMemTable;
    Edit2: TEdit;
    SaveDialog1: TSaveDialog;
    ColorButton1: TColorButton;
    Label1: TLabel;
    Label2: TLabel;
    ColorButton2: TColorButton;
    OpenDialog1: TOpenDialog;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    edtUrl: TEdit;
    edtUserName: TEdit;
    edtPassword: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button2: TButton;
    edtNumPages: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    edtPagInicial: TEdit;
    procedure Button1Click(Sender: TObject);
    function LoadTextFromFile(const FileName: string): string;
    procedure JsonArrayToDataset(aDataset: TDataSet; aJSON: String);
    procedure SaveAsCSV(myFileName: string; myDataSet: TDataSet);
    procedure ColorButton1Click(Sender: TObject);
    procedure ColorButton2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FDataSetProductSizeDescription: iModelDataSet;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  NeoEcommerceService.Model.Connections.Factory.DataSet;

{$R *.fmx}

function TForm1.LoadTextFromFile(const FileName: string): string;
var
  SL: TStringList;
begin
  Result := '';
  SL := TStringList.Create;
  try
    SL.LoadFromFile(FileName);
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not(Edit2.Text = '') then
  begin

  JsonArrayToDataset(FDataSetProductSizeDescription.EndDataSet, Memo1.Text);

  SaveAsCSV(Edit2.Text, FDataSetProductSizeDescription.EndDataSet);

  ShowMessage('ACABOU');
  end
  else
    ShowMessage('Campo destino vazio');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  xTexto: String;
  xJSONArray: TJSONArray;
  FJSONMain: TJSONObject;
  FJsonArray: TJSONArray;
  I: Integer;
  J: Integer;
begin
  if (edtUserName.Text = '') or (edtPassword.Text = '') or (edtNumPages.Text = '') or (edtPagInicial.Text = '') then
    ShowMessage('Campos Vazio')
  else
  begin
    for  J := edtPagInicial.Text.ToInteger to edtNumPages.Text.ToInteger do
    begin
      edtUrl.Text := 'https://api.com/api/v2/users.json?page='+J.ToString+'&role=agent&active=true';
      RESTClient2.BaseURL := 'https://api.com/api/v2/users.json?page='+J.ToString+'&role=agent&active=true';
      FJsonArray := TJSONArray.Create;

      HTTPBasicAuthenticator1.Username := edtUserName.Text;
      HTTPBasicAuthenticator1.Password := edtPassword.Text;

      RESTClient2.BaseURL := edtUrl.Text;

      RESTRequest2.Execute;

      FDataSetProductSizeDescription := TModelConnectionsFactoryDataSet.New.DataSetFiredac;

      xJSONArray := RESTResponse2.JSONValue.GetValue<TJSONArray>('users');


      // FOR PARA PERCORRER JSON E PEGAR APENAS CAMPOS NECESSARIOS
      for I := 0 to xJSONArray.Count -1 do
      begin
        FJSONMain := TJSONObject.Create;
        FJSONMain.AddPair('name', xJSONArray.Items[i].GetValue<String>('name'));
        FJSONMain.AddPair('email', xJSONArray.Items[i].GetValue<String>('name'));
        FJSONMain.AddPair('created_at', xJSONArray.Items[i].GetValue<String>('created_at'));

        FJsonArray.Add(FJSONMain);
      end;


      xTexto := FJsonArray.ToJSON;

      Memo1.Lines.Add(xTexto);
    end;
  end;
end;

procedure TForm1.ColorButton1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin

    Edit2.Text := SaveDialog1.FileName ;

  end;

end;

procedure TForm1.ColorButton2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.JsonArrayToDataset(aDataset: TDataSet; aJSON: String);
var
  JObj: TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    try
     vConv.Dataset := aDataset;
     vConv.UpdateDataSet(JObj);
    except on E:Exception do
      ShowMessage('ERRO AO CONVERTER JSON, VERIFICAR VIRGULA E CHAVES');
    end;
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

procedure TForm1.SaveAsCSV(myFileName: string; myDataSet: TDataSet);
var
  myTextFile: TextFile;
  i: integer;
  s: string;
begin
  //create a new file
  AssignFile(myTextFile, myFileName);
  Rewrite(myTextFile);

  s := ''; //initialize empty string

  try
    //write field names (as column headers)
    for i := 0 to myDataSet.FieldCount - 1 do
      begin
        s := s + Format('"%s";', [myDataSet.Fields[i].FieldName]);
      end;
    Writeln(myTextFile, s);

    //write field values
    while not myDataSet.Eof do
      begin
        s := '';
        for i := 0 to myDataSet.FieldCount - 1 do
          begin
            s := s + Format('"%s";', [myDataSet.Fields[i].AsString]);
          end;
        Writeln(myTextfile, s);
        myDataSet.Next;
      end;

  finally
    CloseFile(myTextFile);
  end;
end;

end.
