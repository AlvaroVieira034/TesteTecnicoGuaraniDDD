unit Application.UseCases.ClienteUseCases;

interface

uses Core.Services.ClienteService, Core.Entities.Cliente, Core.Repositories.IClienteRepository;

type
  TClienteUseCases = class

  private
    FClienteService: TClienteService;
    FClienteRepository: IClienteRepository;

  public
    constructor Create(AClienteRepository: IClienteRepository);
    destructor Destroy; override;

    function CriarCliente(const ARazaoSocial, ANomeFantasia, ACEP, ALogradouro, AComplemento, ACidade, AUF, ATelefone, ACNPJ: string): Integer;
    function ObterClientePorId(AClienteId: Integer): TCliente;
    procedure AtualizarCliente(AClienteId: Integer; const ARazaoSocial, ANomeFantasia: string);
    procedure ExcluirCliente(AClienteId: Integer);
    function ListarClientesPorNome(const ANome: string): TObjectList<TCliente>;
    function ListarClientesPorCidade(const ACidade: string): TObjectList<TCliente>;

  end;

implementation

{ TClienteUseCases }

constructor TClienteUseCases.Create(AClienteRepository: IClienteRepository);
begin
  inherited Create;
  FClienteRepository := AClienteRepository;
  FClienteService := TClienteService.Create(FClienteRepository);
end;

destructor TClienteUseCases.Destroy;
begin
  FClienteService.Free;
  inherited;
end;

function TClienteUseCases.CriarCliente(const ARazaoSocial, ANomeFantasia, ACEP, ALogradouro, AComplemento, ACidade, AUF, ATelefone, ACNPJ: string): Integer;
var Cliente: TCliente;
begin
  Cliente := FClienteService.CriarCliente(ARazaoSocial);
  try
    Cliente.AlterarDados(ARazaoSocial, ANomeFantasia);
    Cliente.DefinirEndereco(ACEP, ALogradouro, AComplemento, ACidade, AUF);
    Cliente.DefinirContato(ATelefone);
    Cliente.DefinirDocumento(ACNPJ);

    FClienteService.ValidarCliente(Cliente);

    FClienteRepository.Adicionar(Cliente);
    Result := Cliente.Id;
  finally
    Cliente.Free;
  end;
end;

function TClienteUseCases.ObterClientePorId(AClienteId: Integer): TCliente;
begin
  Result := FClienteRepository.ObterPorId(AClienteId);
end;

procedure TClienteUseCases.AtualizarCliente(AClienteId: Integer; const ARazaoSocial, ANomeFantasia: string);
var Cliente: TCliente;
begin
  Cliente := FClienteRepository.ObterPorId(AClienteId);
  if not Assigned(Cliente) then
    raise Exception.Create('Cliente não encontrado');

  try
    Cliente.AlterarDados(ARazaoSocial, ANomeFantasia);
    FClienteService.ValidarCliente(Cliente);
    FClienteRepository.Atualizar(Cliente);
  finally
    Cliente.Free;
  end;
end;

procedure TClienteUseCases.ExcluirCliente(AClienteId: Integer);
begin
  FClienteRepository.Remover(AClienteId);
end;

function TClienteUseCases.ListarClientesPorNome(const ANome: string): TObjectList<TCliente>;
begin
  Result := FClienteRepository.ListarPorNome(ANome);
end;

function TClienteUseCases.ListarClientesPorCidade(const ACidade: string): TObjectList<TCliente>;
begin
  Result := FClienteRepository.ListarPorCidade(ACidade);
end;

end.
