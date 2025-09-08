program TesteGuaraniDDD;

uses
  Vcl.Forms,
  Core.ValueObjects.Endereco in 'Core\ValueObjects\Core.ValueObjects.Endereco.pas',
  Core.ValueObjects.Contato in 'Core\ValueObjects\Core.ValueObjects.Contato.pas',
  Core.ValueObjects.Documento in 'Core\ValueObjects\Core.ValueObjects.Documento.pas',
  Core.Repositories.IClienteRepository in 'Core\Repositories\Core.Repositories.IClienteRepository.pas',
  Core.Services.ClienteService in 'Core\Services\Core.Services.ClienteService.pas',
  Infrastructure.Persistence.ClienteRepositoryAdapter in 'Infrastructure\Persistence\Infrastructure.Persistence.ClienteRepositoryAdapter.pas',
  Presentation.Controllers.ClienteFormController in 'Presentation\Controllers\Presentation.Controllers.ClienteFormController.pas',
  Application.UseCases.ClienteUseCases in 'Application\UseCases\Application.UseCases.ClienteUseCases.pas',
  Core.Entities.Cliente in 'Core\Entities\Core.Entities.Cliente.pas',
  Core.Utils.Validadores in 'Core\Utils\Core.Utils.Validadores.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
