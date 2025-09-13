unit Presentation.Controllers.ClienteFormController;

interface

uses
  System.SysUtils, System.Generics.Collections, Application.UseCases.ClienteUseCases, Core.Entities.Cliente,
  Core.Repositories.IClienteRepository, Core.Services.IClienteService, Infrastructure.Persistence.ClienteRepository,
  Infrastructure.Service.ClienteService, ucadcliente;

type
  TClienteFormController = class

  private
    FClienteUseCases: TClienteUseCases;
    FView: TFrmCadCliente;
    FClienteRepository: IClienteRepository;
    FClienteService: IClienteService;

  public
    constructor Create(AView: TFrmCadCliente);
    destructor Destroy; override;

    procedure CarregarCliente(AClienteId: Integer);
    procedure SalvarCliente;
    procedure ExcluirCliente(AClienteId: Integer);
    procedure PesquisarClientes(const ANome: string);
    procedure PreencherComboClientes;

  end;

implementation

{ TClienteFormController }

constructor TClienteFormController.Create(AView: TFrmCadCliente);
var
  ClienteRepository: IClienteRepository;
begin
  inherited Create;
  FView := AView;

  // Criar as implementações concretas
  FClienteRepository := TClienteRepository.Create;
  FClienteService := TClienteService.Create;

  // Injectar ambas as dependências no Use Case
  FClienteUseCases := TClienteUseCases.Create(FClienteRepository, FClienteService);
end;

destructor TClienteFormController.Destroy;
begin
  FClienteUseCases.Free;
  inherited Destroy;

end;

procedure TClienteFormController.CarregarCliente(AClienteId: Integer);
var Cliente: TCliente;
begin
  Cliente := FClienteUseCases.ObterClientePorId(AClienteId);
  try
    FView.EdtCodigoCliente.Text := IntToStr(Cliente.Id);
    FView.EdtRazaoSocial.Text := Cliente.RazaoSocial;
    FView.EdtNomeFantasia.Text := Cliente.NomeFantasia;
    FView.EdtCep.Text := Cliente.Endereco.CEP;
    FView.EdtEndereco.Text := Cliente.Endereco.Logradouro;
    FView.EdtComplemento.Text := Cliente.Endereco.Complemento;
    FView.EdtCidade.Text := Cliente.Endereco.Cidade;
    FView.EdtUF.Text := Cliente.Endereco.UF;
    FView.EdtTelefone.Text := Cliente.Contato.Telefone;
    FView.EdtCnpj.Text := Cliente.Documento.CNPJ;
  finally
    Cliente.Free;
  end;
end;

procedure TClienteFormController.SalvarCliente;
var ClienteId: Integer;
begin
  if FView.EdtCodigoCliente.Text = '' then
  begin
    // Novo cliente
    ClienteId := FClienteUseCases.CriarCliente(
      FView.EdtRazaoSocial.Text,
      FView.EdtNomeFantasia.Text,
      FView.EdtCep.Text,
      FView.EdtEndereco.Text,
      FView.EdtComplemento.Text,
      FView.EdtCidade.Text,
      FView.EdtUF.Text,
      FView.EdtTelefone.Text,
      FView.EdtCnpj.Text
    );
    FView.EdtCodigoCliente.Text := IntToStr(ClienteId);
  end
  else
  begin
    // Cliente existente
    FClienteUseCases.AtualizarCliente(
      StrToInt(FView.EdtCodigoCliente.Text),
      FView.EdtRazaoSocial.Text,
      FView.EdtNomeFantasia.Text
    );
  end;
end;

procedure TClienteFormController.ExcluirCliente(AClienteId: Integer);
begin
  FClienteUseCases.ExcluirCliente(AClienteId);
end;

procedure TClienteFormController.PesquisarClientes(const ANome: string);
var
  Clientes: TObjectList<TCliente>;
  Cliente: TCliente;
begin
  Clientes := FClienteUseCases.ListarClientesPorNome(ANome);
  try
    FView.DbGridClientes.DataSource.DataSet.Close;
    // Preencher grid com resultados...
  finally
    Clientes.Free;
  end;
end;

end.
