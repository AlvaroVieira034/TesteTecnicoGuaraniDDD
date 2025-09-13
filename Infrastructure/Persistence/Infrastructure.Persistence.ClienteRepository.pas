unit Infrastructure.Persistence.ClienteRepository;

interface

uses
  cliente.model, Core.Entities.Cliente, Infrastructure.Connection.ConexaoSingleton, Core.Repositories.IClienteRepository,
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TClienteRepository = class(TInterfacedObject, IClienteRepository)

  private
    QryClientes: TFDQuery;
    Transacao: TFDTransaction;

  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    function Inserir(ACliente: TCliente): Boolean;
    function Alterar(ACliente: TCliente; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;

  end;

implementation

{ TClienteRepository }

constructor TClienteRepository.Create(AConnection: TFDConnection);
begin
  inherited Create;
  Transacao := TConexaoSingleton.GetInstance.DatabaseConnection.CriarTransaction;
  QryClientes := TConexaoSingleton.GetInstance.DatabaseConnection.CriarQuery;
  QryClientes.Transaction := Transacao;
end;

destructor TClienteRepository.Destroy;
begin
  QryClientes.Free;

  inherited Destroy;
end;

function TClienteRepository.Inserir(ACliente: TCliente): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryClientes, ACliente do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into tab_cliente(');
        SQL.Add('des_razaosocial, ');
        SQL.Add('des_nomefantasia, ');
        SQL.Add('des_cep, ');
        SQL.Add('des_endereco, ');
        SQL.Add('des_complemento, ');
        SQL.Add('des_cidade, ');
        SQL.Add('des_uf, ');
        SQL.Add('des_cnpj, ');
        SQL.Add('des_telefone) ');
        SQL.Add('values (:des_razaosocial, ');
        SQL.Add(':des_nomefantasia, ');
        SQL.Add(':des_cep, ');
        SQL.Add(':des_endereco, ');
        SQL.Add(':des_complemento, ');
        SQL.Add(':des_cidade, ');
        SQL.Add(':des_uf,');
        SQL.Add(':des_cnpj,');
        SQL.Add(':des_telefone)');

        ParamByName('DES_RAZAOSOCIAL').AsString := Des_RazaoSocial;
        ParamByName('DES_NOMEFANTASIA').AsString := Des_NomeFantasia;
        ParamByName('DES_CEP').AsString := Des_Cep;
        ParamByName('DES_ENDERECO').AsString := Des_Endereco;
        ParamByName('DES_COMPLEMENTO').AsString := Des_Complemento;
        ParamByName('DES_CIDADE').AsString := Des_Cidade;
        ParamByName('DES_UF').AsString := Des_UF;
        ParamByName('DES_CNPJ').AsString := Des_Cnpj;
        ParamByName('DES_TELEFONE').AsString := Des_Telefone;

        ExecSQL;
      end;
    end);
end;

function TClienteRepository.Alterar(ACliente: TCliente; AId: Integer): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryClientes, ACliente do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update tab_cliente set ');
        SQL.Add('des_razaosocial = :des_razaosocial, ');
        SQL.Add('des_nomefantasia = :des_nomefantasia, ');
        SQL.Add('des_cep = :des_cep, ');
        SQL.Add('des_endereco = :des_endereco, ');
        SQL.Add('des_complemento = :des_complemento, ');
        SQL.Add('des_cidade = :des_cidade, ');
        SQL.Add('des_uf = :des_uf, ');
        SQL.Add('des_cnpj = :des_cnpj, ');
        SQL.Add('des_telefone = :des_telefone ');
        SQL.Add('where cod_cliente = :cod_cliente');

        ParamByName('DES_RAZAOSOCIAL').AsString := Des_RazaoSocial;
        ParamByName('DES_NOMEFANTASIA').AsString := Des_NomeFantasia;
        ParamByName('DES_CEP').AsString := Des_Cep;
        ParamByName('DES_ENDERECO').AsString := Des_Endereco;
        ParamByName('DES_COMPLEMENTO').AsString := Des_Complemento;
        ParamByName('DES_CIDADE').AsString := Des_Cidade;
        ParamByName('DES_UF').AsString := Des_UF;
        ParamByName('DES_CNPJ').AsString := Des_Cnpj;
        ParamByName('DES_TELEFONE').AsString := Des_Telefone;
        ParamByName('COD_CLIENTE').AsInteger := AId;

        ExecSQL;
      end;
    end);
end;

function TClienteRepository.Excluir(AId: Integer): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryClientes do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'delete from tab_cliente where cod_cliente = :cod_cliente';
        ParamByName('COD_CLIENTE').AsInteger := AId;

        ExecSQL;
      end;
    end);
end;

function TClienteRepository.ExecutarTransacao(AOperacao: TProc): Boolean;
begin
  Result := False;
  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();

  Transacao.StartTransaction;
  try
    AOperacao;
    Transacao.Commit;
    Result := True;
  except
    on E: Exception do
    begin
      Transacao.Rollback;
      raise Exception.Create('Ocorreu um erro na transa��o do cliente! Erro: ' + E.Message);
    end;
  end;
end;



end.

