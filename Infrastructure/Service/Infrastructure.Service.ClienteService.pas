unit Infrastructure.Service.ClienteService;

interface

uses
  cliente.model, Core.Entities.Cliente, Core.Services.IClienteService, Infrastructure.Connection.ConexaoSingleton, System.SysUtils,
  FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TClienteService = class(TInterfacedObject, IClienteService)

  private
    TblClientes: TFDQuery;
    DsClientes: TDataSource;

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherComboBox(TblClientes: TFDQuery);
    procedure PreencherCamposForm(ACliente: TCliente; AId: Integer);
    function BuscarClientePorCodigo(AId: Integer): TCliente;
    procedure CriarTabelas;
    function GetDataSource: TDataSource;
    procedure ValidarCliente(ACliente: TCliente);


  end;

implementation

{ TClienteService }

constructor TClienteService.Create(AConnection: TFDConnection);
begin
  inherited Create;
  CriarTabelas();
end;

destructor TClienteService.Destroy;
begin
  TblClientes.Free;
  DsClientes.Free;
  inherited;
end;

function TClienteService.BuscarClientePorCodigo(AId: Integer): TCliente;
begin
  Result := TCliente.Create;
  try
    PreencherCamposForm(Result, AId);
  except
    Result.Free;
    raise;
  end;
end;

procedure TClienteService.PreencherGridForm(APesquisa, ACampo: string);
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cli.cod_cliente,  ');
    SQL.Add('cli.des_razaosocial, ');
    SQL.Add('cli.des_nomefantasia, ');
    SQL.Add('cli.des_endereco, ');
    SQL.Add('cli.des_complemento, ');
    SQL.Add('cli.des_cep, ');
    SQL.Add('cli.des_cidade, ');
    SQL.Add('cli.des_uf, ');
    SQL.Add('cli.des_cnpj, ');
    SQL.Add('cli.des_telefone ');
    SQL.Add('from tab_cliente cli');
    SQL.Add('where ' + ACampo + ' like :pNOME');
    SQL.Add('order by ' + ACampo);

    ParamByName('PNOME').AsString := APesquisa;
    Open();
  end;
end;

procedure TClienteService.ValidarCliente(ACliente: TCliente);
begin
  ACliente.ValidarDados;
end;

procedure TClienteService.PreencherComboBox(TblClientes: TFDQuery);
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from tab_cliente order by des_razaosocial ');
    Open();
  end;
end;

procedure TClienteService.PreencherCamposForm(ACliente: TCliente; AId: Integer);
begin
  with TblClientes do
  begin
    SQL.Clear;
    SQL.Add('select cli.cod_cliente,  ');
    SQL.Add('cli.des_razaosocial, ');
    SQL.Add('cli.des_nomefantasia, ');
    SQL.Add('cli.des_endereco, ');
    SQL.Add('cli.des_complemento, ');
    SQL.Add('cli.des_cep, ');
    SQL.Add('cli.des_cidade, ');
    SQL.Add('cli.des_uf, ');
    SQL.Add('cli.des_cnpj, ');
    SQL.Add('cli.des_telefone ');
    SQL.Add('from tab_cliente cli');
    SQL.Add('where cod_cliente = :cod_cliente');
    ParamByName('cod_cliente').AsInteger := AId;
    Open;

    ACliente.Cod_Cliente := FieldByName('COD_CLIENTE').AsInteger;
    ACliente.Des_RazaoSocial := FieldByName('DES_RAZAOSOCIAL').AsString;
    ACliente.Des_NomeFantasia := FieldByName('DES_NOMEFANTASIA').AsString;
    ACliente.Des_Cep := FieldByName('DES_CEP').AsString;
    ACliente.Des_Endereco := FieldByName('DES_ENDERECO').AsString;
    ACliente.Des_Complemento := FieldByName('DES_COMPLEMENTO').AsString;
    ACliente.Des_Cidade := FieldByName('DES_CIDADE').AsString;
    ACliente.Des_UF := FieldByName('DES_UF').AsString;
    ACliente.Des_CNPJ := FieldByName('DES_CNPJ').AsString;
    ACliente.Des_Telefone := FieldByName('DES_TELEFONE').AsString;
  end;
end;

procedure TClienteService.CriarTabelas;
begin
  TblClientes := TConexaoSingleton.GetInstance.DatabaseConnection.CriarQuery;
  DsClientes := TConexaoSingleton.GetInstance.DatabaseConnection.CriarDataSource;
  DsClientes.DataSet := TblClientes;
end;

function TClienteService.GetDataSource: TDataSource;
begin
  Result := DsClientes;
end;


end.
