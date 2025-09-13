program TesteGuaraniDDD;

uses
  Vcl.Forms,
  Core.ValueObjects.Endereco in 'Core\ValueObjects\Core.ValueObjects.Endereco.pas',
  Core.ValueObjects.Contato in 'Core\ValueObjects\Core.ValueObjects.Contato.pas',
  Core.ValueObjects.Documento in 'Core\ValueObjects\Core.ValueObjects.Documento.pas',
  Core.Repositories.IClienteRepository in 'Core\Repositories\Core.Repositories.IClienteRepository.pas',
  Presentation.Controllers.ClienteFormController in 'Presentation\Controllers\Presentation.Controllers.ClienteFormController.pas',
  Application.UseCases.ClienteUseCases in 'Application\UseCases\Application.UseCases.ClienteUseCases.pas',
  Core.Utils.Validadores in 'Core\Utils\Core.Utils.Validadores.pas',
  Core.Entities.Cliente in 'Core\Entities\Core.Entities.Cliente.pas',
  cliente.model in 'Infrastructure\Persistence\Legacy\cliente.model.pas',
  Infrastructure.Persistence.ClienteRepository in 'Infrastructure\Persistence\Infrastructure.Persistence.ClienteRepository.pas',
  Infrastructure.Connection.DatabaseConnection in 'Infrastructure\Connection\Infrastructure.Connection.DatabaseConnection.pas',
  Infrastructure.Connection.ConexaoSingleton in 'Infrastructure\Connection\Infrastructure.Connection.ConexaoSingleton.pas',
  Core.Services.IClienteService in 'Core\Services\Core.Services.IClienteService.pas',
  Infrastructure.Service.ClienteService in 'Infrastructure\Service\Infrastructure.Service.ClienteService.pas',
  ucadastropadrao in 'Presentation\Views\ucadastropadrao.pas' {FrmCadastroPadrao},
  ucadcliente in 'Presentation\Views\ucadcliente.pas' {FrmCadCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
