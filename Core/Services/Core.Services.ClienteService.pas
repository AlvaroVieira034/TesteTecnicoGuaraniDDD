unit Core.Services.ClienteService;
unit Core.Services.ClienteService;

interface

uses Core.Repositories.IClienteRepository, Core.Entities.Cliente;

type
  TClienteService = class

  private
    FClienteRepository: IClienteRepository;

  public
    constructor Create(AClienteRepository: IClienteRepository);

    function CriarCliente(const ARazaoSocial: string): TCliente;
    function ValidarCliente(ACliente: TCliente): Boolean;
    function ClonarCliente(AClienteId: Integer): TCliente;

    function VerificarDuplicidadeCNPJ(ACliente: TCliente): Boolean;
    function VerificarDuplicidadeRazaoSocial(ACliente: TCliente): Boolean;

  end;

implementation

{ TClienteService }

constructor TClienteService.Create(AClienteRepository: IClienteRepository);
begin
  inherited Create;
  FClienteRepository := AClienteRepository;
end;

function TClienteService.CriarCliente(const ARazaoSocial: string): TCliente;
begin
  Result := TCliente.Create(ARazaoSocial);
end;

function TClienteService.ValidarCliente(ACliente: TCliente): Boolean;
begin
  ACliente.ValidarDados;

  if VerificarDuplicidadeCNPJ(ACliente) then
    raise Exception.Create('CNPJ já cadastrado para outro cliente');

  if VerificarDuplicidadeRazaoSocial(ACliente) then
    raise Exception.Create('Razão social já cadastrada para outro cliente');

  Result := True;
end;

function TClienteService.VerificarDuplicidadeCNPJ(ACliente: TCliente): Boolean;
begin
  Result := FClienteRepository.ExisteCNPJ(ACliente.Documento.CNPJ, ACliente.Id);
end;

function TClienteService.VerificarDuplicidadeRazaoSocial(ACliente: TCliente): Boolean;
begin
  Result := FClienteRepository.ExisteRazaoSocial(ACliente.RazaoSocial, ACliente.Id);
end;

function TClienteService.ClonarCliente(AClienteId: Integer): TCliente;
var ClienteOriginal: TCliente;
begin
  ClienteOriginal := FClienteRepository.ObterPorId(AClienteId);
  if not Assigned(ClienteOriginal) then
    raise Exception.Create('Cliente não encontrado');

  Result := TCliente.Create(ClienteOriginal.RazaoSocial);
  // Copiar outras propriedades...
end;

end.
