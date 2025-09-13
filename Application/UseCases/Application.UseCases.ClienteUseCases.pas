unit Application.UseCases.ClienteUseCases;

interface

uses Core.Entities.Cliente, Core.Repositories.IClienteRepository, Core.Services.IClienteService, Infrastructure.Persistence.ClienteRepository, Infrastructure.Service.ClienteService,
     System.SysUtils;

type
  TClienteUseCases = class

  private
    FClienteService: IClienteService;
    FClienteRepository: IClienteRepository;

  public
    constructor Create(AClienteRepository: IClienteRepository; AClienteService: IClienteService);
    destructor Destroy; override;

    function CriarCliente(const ARazaoSocial, ANomeFantasia, ACEP, ALogradouro, AComplemento, ACidade, AUF, ATelefone, ACNPJ: string): Integer;
    function ObterClientePorId(AClienteId: Integer): TCliente;
    procedure AtualizarCliente(AClienteId: Integer; const ARazaoSocial, ANomeFantasia: string);
    procedure ExcluirCliente(AClienteId: Integer);

  end;

implementation

{ TClienteUseCases }

constructor TClienteUseCases.Create(AClienteRepository: IClienteRepository; AClienteService: IClienteService);
begin
  inherited Create;
  FClienteRepository := AClienteRepository;
  FClienteService := AClienteService;
end;

destructor TClienteUseCases.Destroy;
begin

  inherited;
end;

function TClienteUseCases.CriarCliente(const ARazaoSocial, ANomeFantasia, ACEP, ALogradouro, AComplemento, ACidade, AUF, ATelefone, ACNPJ: string): Integer;
var Cliente: TCliente;
begin
  Cliente := TCliente.Create(ARazaoSocial);
  try
    Cliente.AlterarDados(ARazaoSocial, ANomeFantasia);
    Cliente.DefinirEndereco(ACEP, ALogradouro, AComplemento, ACidade, AUF);
    Cliente.DefinirContato(ATelefone);
    Cliente.DefinirDocumento(ACNPJ);

    FClienteService.ValidarCliente(Cliente);
    FClienteRepository.Inserir(Cliente);
    Result := Cliente.Cod_Cliente;
  finally
    Cliente.Free;
  end;
end;

function TClienteUseCases.ObterClientePorId(AClienteId: Integer): TCliente;
begin
  Result := FClienteService.BuscarClientePorCodigo(AClienteId);
end;

procedure TClienteUseCases.AtualizarCliente(AClienteId: Integer; const ARazaoSocial, ANomeFantasia: string);
var Cliente: TCliente;
begin
  Cliente := FClienteService.BuscarClientePorCodigo(AClienteId);
  if not Assigned(Cliente) then
    raise Exception.Create('Cliente não encontrado');

  try
    Cliente.AlterarDados(ARazaoSocial, ANomeFantasia);
    FClienteService.ValidarCliente(Cliente);
    //FClienteRepository.Atualizar(Cliente);
  finally
    Cliente.Free;
  end;
end;

procedure TClienteUseCases.ExcluirCliente(AClienteId: Integer);
begin
  FClienteRepository.Excluir(AClienteId);
end;



end.
