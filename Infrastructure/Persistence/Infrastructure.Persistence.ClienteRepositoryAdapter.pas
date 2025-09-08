unit Infrastructure.Persistence.ClienteRepositoryAdapter;

interface

uses Core.Repositories.IClienteRepository, Core.Entities.Cliente, cliente.repository, cliente.model, System.Generics.Collections;

type
  TClienteRepositoryAdapter = class(TInterfacedObject, IClienteRepository)

  private
    FRepositoryAntigo: TClienteRepository;

    function ConverterParaNovaEntity(AClienteAntigo: TClienteModel): TCliente;
    function ConverterParaAntigaModel(AClienteNovo: TCliente): TClienteModel;

  public
    constructor Create;
    destructor Destroy; override;

    function ObterPorId(AId: Integer): TCliente;
    function ObterPorCNPJ(ACNPJ: string): TCliente;
    function ListarTodos: TObjectList<TCliente>;
    function ListarPorCidade(ACidade: string): TObjectList<TCliente>;
    function ListarPorNome(ANome: string): TObjectList<TCliente>;

    procedure Adicionar(ACliente: TCliente);
    procedure Atualizar(ACliente: TCliente);
    procedure Remover(AId: Integer);

    function ProximoId: Integer;
    function ExisteCNPJ(ACNPJ: string; AExcluirId: Integer = 0): Boolean;
    function ExisteRazaoSocial(ARazaoSocial: string; AExcluirId: Integer = 0): Boolean;

  end;

implementation

{ TClienteRepositoryAdapter }

constructor TClienteRepositoryAdapter.Create;
begin
  inherited Create;
  FRepositoryAntigo := TClienteRepository.Create;
end;

destructor TClienteRepositoryAdapter.Destroy;
begin
  FRepositoryAntigo.Free;
  inherited;
end;

function TClienteRepositoryAdapter.ConverterParaNovaEntity(AClienteAntigo: TClienteModel): TCliente;
begin
  Result := TCliente.Create;
  Result.Id := AClienteAntigo.Cod_Cliente;
  Result.AlterarDados(AClienteAntigo.Des_RazaoSocial, AClienteAntigo.Des_NomeFantasia);
  Result.DefinirEndereco(
    AClienteAntigo.Des_Cep,
    AClienteAntigo.Des_Endereco,
    AClienteAntigo.Des_Complemento,
    AClienteAntigo.Des_Cidade,
    AClienteAntigo.Des_UF
  );
  Result.DefinirContato(AClienteAntigo.Des_Telefone);
  Result.DefinirDocumento(AClienteAntigo.Des_Cnpj);
end;

function TClienteRepositoryAdapter.ConverterParaAntigaModel(AClienteNovo: TCliente): TClienteModel;
begin
  Result := TClienteModel.Create;
  Result.Cod_Cliente := AClienteNovo.Id;
  Result.Des_RazaoSocial := AClienteNovo.RazaoSocial;
  Result.Des_NomeFantasia := AClienteNovo.NomeFantasia;
  Result.Des_Cep := AClienteNovo.Endereco.CEP;
  Result.Des_Endereco := AClienteNovo.Endereco.Logradouro;
  Result.Des_Complemento := AClienteNovo.Endereco.Complemento;
  Result.Des_Cidade := AClienteNovo.Endereco.Cidade;
  Result.Des_UF := AClienteNovo.Endereco.UF;
  Result.Des_Telefone := AClienteNovo.Contato.Telefone;
  Result.Des_Cnpj := AClienteNovo.Documento.CNPJ;
end;

function TClienteRepositoryAdapter.ObterPorId(AId: Integer): TCliente;
var
  ClienteAntigo: TClienteModel;
begin
  ClienteAntigo := TClienteModel.Create;
  try
    // Usar repository antigo para buscar
    // FRepositoryAntigo.CarregarCliente(ClienteAntigo, AId);
    Result := ConverterParaNovaEntity(ClienteAntigo);
  finally
    ClienteAntigo.Free;
  end;
end;

// Implementar outros métodos seguindo o mesmo padrão...

end.
