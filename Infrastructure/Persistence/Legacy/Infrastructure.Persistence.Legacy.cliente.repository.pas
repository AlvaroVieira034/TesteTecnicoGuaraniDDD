unit Infrastructure.Persistence.Legacy.cliente.repository;

interface

uses
  cliente.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TClienteRepository = class

  private
    FConnection: TFDConnection; // Conexão direta
    QryClientes: TFDQuery;

  public
    constructor Create;
    destructor Destroy; override;

    // Métodos concretos sem interface
    procedure CarregarCliente(ACliente: TClienteModel; AId: Integer);
    function Inserir(ACliente: TClienteModel): Boolean;
    function Alterar(ACliente: TClienteModel; AId: Integer): Boolean;
    function Excluir(AId: Integer): Boolean;
    function ExecutarTransacao(AOperacao: TProc): Boolean;

    {procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherComboBox(TblClientes: TFDQuery);
    procedure PreencherCamposForm(FCliente: TCliente; ACodigo: Integer);
    procedure CriarTabelas;
    function GetDataSource: TDataSource;
    function BuscarClientePorCodigo(ACodigo: Integer): TCliente;
    }




  end;

implementation

{ TClienteRepository }

constructor TClienteRepository.Create;
begin
  inherited Create;
  FConnection := TConexao.GetInstance.Connection; // Ou cria nova conexão
  QryClientes := TFDQuery.Create(nil);
  QryClientes.Connection := FConnection;
end;

destructor TClienteRepository.Destroy;
begin
  QryClientes.Free;
  inherited;
end;

procedure TClienteRepository.CarregarCliente(ACliente: TClienteModel; AId: Integer);
begin
  QryClientes.SQL.Text := 'SELECT * FROM clientes WHERE id = :id';
  QryClientes.ParamByName('id').AsInteger := AId;
  QryClientes.Open;

  if not QryClientes.IsEmpty then
  begin
    ACliente.Cod_Cliente := QryClientes.FieldByName('id').AsInteger;
    ACliente.Des_RazaoSocial := QryClientes.FieldByName('razao_social').AsString;
    // ... outros campos
  end;
end;

// ... implementação dos outros métodos
end.

implementation

end.
